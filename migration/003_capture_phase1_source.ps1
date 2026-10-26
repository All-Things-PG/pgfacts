[CmdletBinding()]
param(
    [string]$SqlServer = 'LENOVO-LAPTOP',
    [string]$Database = 'Migration',
    [System.Management.Automation.PSCredential]$SqlCredential
)

$ErrorActionPreference = 'Stop'
if (-not $SqlCredential) { $SqlCredential = Get-Credential -Message 'SQL login for the local Migration database' }

function Quote-ConnectionValue([string]$Value) { '"' + $Value.Replace('"','""') + '"' }
$connectionString = 'Server=' + $SqlServer + ';Database=' + $Database + ';User ID=' + (Quote-ConnectionValue $SqlCredential.UserName) + ';Password=' + (Quote-ConnectionValue $SqlCredential.GetNetworkCredential().Password) + ';Encrypt=True;TrustServerCertificate=True;Connect Timeout=10'
$connection = [System.Data.SqlClient.SqlConnection]::new($connectionString)
function Get-SourceMainHtml([string]$Html) {
    $match = [regex]::Match($Html, '(?is)<main\b[^>]*>(.*?)</main>')
    if ($match.Success) { return $match.Groups[1].Value }
    $body = [regex]::Match($Html, '(?is)<body\b[^>]*>(.*?)</body>')
    if ($body.Success) { return $body.Groups[1].Value }
    return $Html
}

function Convert-SourceHtmlToText([string]$Html) {
    $text = [regex]::Replace($Html, '(?is)<(script|style|noscript)\b[^>]*>.*?</\1>', ' ')
    $text = [regex]::Replace($text, '(?is)<[^>]+>', ' ')
    $text = [System.Net.WebUtility]::HtmlDecode($text)
    return [regex]::Replace($text, '\s+', ' ').Trim()
}

function Get-MediaReferences([string]$Html, [Uri]$BaseUri) {
    $seen = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    $tagPattern = '(?is)<(img|source|video|audio|a)\b([^>]*)>'
    foreach ($tagMatch in [regex]::Matches($Html, $tagPattern)) {
        $tag = $tagMatch.Groups[1].Value.ToLowerInvariant()
        $attributes = @{}
        foreach ($attribute in [regex]::Matches($tagMatch.Groups[2].Value, '(?is)([\w:-]+)\s*=\s*(?:"([^"]*)"|''([^'']*)''|([^\s>]+))')) {
            $value = $attribute.Groups[2].Value
            if (-not $value) { $value = $attribute.Groups[3].Value }
            if (-not $value) { $value = $attribute.Groups[4].Value }
            $attributes[$attribute.Groups[1].Value.ToLowerInvariant()] = [System.Net.WebUtility]::HtmlDecode($value)
        }

        $candidates = [System.Collections.Generic.List[string]]::new()
        $kind = $null
        if ($tag -eq 'img') {
            $kind = 'Image'
            foreach ($name in @('src','data-src','data-lazy-src')) { if ($attributes[$name]) { $candidates.Add($attributes[$name]) } }
            if ($attributes['srcset']) { $candidates.Add(($attributes['srcset'] -split ',')[0].Trim() -replace '\s+\d+(?:\.\d+)?[wx]$','') }
        } elseif ($tag -eq 'source') {
            $kind = 'Media'
            if ($attributes['src']) { $candidates.Add($attributes['src']) }
            if ($attributes['srcset']) { $candidates.Add(($attributes['srcset'] -split ',')[0].Trim() -replace '\s+\d+(?:\.\d+)?[wx]$','') }
        } elseif ($tag -eq 'video' -or $tag -eq 'audio') {
            $kind = if ($tag -eq 'video') { 'Video' } else { 'Audio' }
            if ($attributes['src']) { $candidates.Add($attributes['src']) }
            if ($attributes['poster']) { $candidates.Add($attributes['poster']); $kind = 'Image' }
        } elseif ($tag -eq 'a' -and $attributes['href'] -match '(?i)\.(pdf|docx?|pptx?|xlsx?|mp4|mp3)(?:[?#].*)?$') {
            $kind = 'Document'
            $candidates.Add($attributes['href'])
        }

        foreach ($candidate in $candidates) {
            if ([string]::IsNullOrWhiteSpace($candidate) -or $candidate -match '^(?i)(data:|javascript:|mailto:|tel:|#)') { continue }
            try {
                if ($candidate.StartsWith('//')) { $uri = [Uri]::new($BaseUri.Scheme + ':' + $candidate) }
                else { $uri = [Uri]::new($BaseUri, $candidate) }
                if ($uri.Scheme -notin @('http','https')) { continue }
                $absolute = $uri.AbsoluteUri
                if (-not $seen.Add($absolute)) { continue }
                [pscustomobject]@{
                    SourceUrl = $absolute
                    AltText = $attributes['alt']
                    MediaKind = $kind
                    IsExternal = [int]($uri.Host -ne $BaseUri.Host)
                }
            } catch { }
        }
    }
}

try {
    $connection.Open()
    $select = $connection.CreateCommand()
    $select.CommandText = "SELECT u.HtmlPageUrlID,u.HtmlPageID,u.SourceUrl FROM dbo.HtmlPageUrl u WHERE u.IsCanonical=1 ORDER BY u.HtmlPageID;"
    $reader = $select.ExecuteReader()
    $pages = [System.Collections.Generic.List[object]]::new()
    while ($reader.Read()) {
        $pages.Add([pscustomobject]@{ UrlID=$reader.GetInt32(0); PageID=$reader.GetInt32(1); Url=$reader.GetString(2) })
    }
    $reader.Close()

    $completed = 0
    foreach ($page in $pages) {
        try {
            $response = Invoke-WebRequest -Uri $page.Url -MaximumRedirection 5 -TimeoutSec 30
            $statusCode = [int]$response.StatusCode
            $sourceHtml = Get-SourceMainHtml $response.Content
            $sourceText = Convert-SourceHtmlToText $sourceHtml
            $media = @(Get-MediaReferences $sourceHtml ([Uri]$page.Url))
            $transaction = $connection.BeginTransaction()
            try {
                $cmd = $connection.CreateCommand(); $cmd.Transaction = $transaction
                $cmd.CommandText = "UPDATE dbo.HtmlPages SET SourceHTML=@html,SourceText=@text,CaptureStatus='Captured',CapturedAt=SYSUTCDATETIME() WHERE HtmlPageID=@id; UPDATE dbo.HtmlPageUrl SET HttpStatusCode=@status,LastCheckedAt=SYSUTCDATETIME() WHERE HtmlPageUrlID=@urlid; DELETE FROM dbo.HtmlMediaReference WHERE HtmlPageID=@id;"
                [void]$cmd.Parameters.Add('@html',[System.Data.SqlDbType]::NVarChar,-1); $cmd.Parameters['@html'].Value=$sourceHtml
                [void]$cmd.Parameters.Add('@text',[System.Data.SqlDbType]::NVarChar,-1); $cmd.Parameters['@text'].Value=$sourceText
                [void]$cmd.Parameters.Add('@id',[System.Data.SqlDbType]::Int); $cmd.Parameters['@id'].Value=$page.PageID
                [void]$cmd.Parameters.Add('@status',[System.Data.SqlDbType]::SmallInt); $cmd.Parameters['@status'].Value=$statusCode
                [void]$cmd.Parameters.Add('@urlid',[System.Data.SqlDbType]::Int); $cmd.Parameters['@urlid'].Value=$page.UrlID
                [void]$cmd.ExecuteNonQuery()
                foreach ($asset in $media) {
                    $assetCmd=$connection.CreateCommand(); $assetCmd.Transaction=$transaction
                    $assetCmd.CommandText='INSERT INTO dbo.HtmlMediaReference(HtmlPageID,SourceUrl,AltText,MediaKind,IsExternal) VALUES (@id,@url,@alt,@kind,@external);'
                    [void]$assetCmd.Parameters.Add('@id',[System.Data.SqlDbType]::Int); $assetCmd.Parameters['@id'].Value=$page.PageID
                    [void]$assetCmd.Parameters.Add('@url',[System.Data.SqlDbType]::NVarChar,1000); $assetCmd.Parameters['@url'].Value=$asset.SourceUrl
                    [void]$assetCmd.Parameters.Add('@alt',[System.Data.SqlDbType]::NVarChar,1000); $assetCmd.Parameters['@alt'].Value=if($asset.AltText){$asset.AltText}else{[DBNull]::Value}
                    [void]$assetCmd.Parameters.Add('@kind',[System.Data.SqlDbType]::NVarChar,40); $assetCmd.Parameters['@kind'].Value=$asset.MediaKind
                    [void]$assetCmd.Parameters.Add('@external',[System.Data.SqlDbType]::Bit); $assetCmd.Parameters['@external'].Value=$asset.IsExternal
                    [void]$assetCmd.ExecuteNonQuery()
                }
                $transaction.Commit()
            } catch { $transaction.Rollback(); throw }
            $completed++
            '{0}/{1} captured: {2} (HTTP {3}, {4} media refs)' -f $completed,$pages.Count,$page.Url,$statusCode,$media.Count
        } catch {
            $failed = $connection.CreateCommand()
            $failed.CommandText = "UPDATE dbo.HtmlPages SET CaptureStatus='Failed',MigrationNotes=LEFT(CONCAT(COALESCE(MigrationNotes+N' | ',N''),@error),1000) WHERE HtmlPageID=@id; UPDATE dbo.HtmlPageUrl SET LastCheckedAt=SYSUTCDATETIME() WHERE HtmlPageUrlID=@urlid;"
            [void]$failed.Parameters.Add('@error',[System.Data.SqlDbType]::NVarChar,1000); $failed.Parameters['@error'].Value=$_.Exception.Message
            [void]$failed.Parameters.Add('@id',[System.Data.SqlDbType]::Int); $failed.Parameters['@id'].Value=$page.PageID
            [void]$failed.Parameters.Add('@urlid',[System.Data.SqlDbType]::Int); $failed.Parameters['@urlid'].Value=$page.UrlID
            [void]$failed.ExecuteNonQuery()
            'FAILED: {0} ({1})' -f $page.Url,$_.Exception.GetType().Name
        }
    }
    'Capture complete: {0} page URLs processed.' -f $pages.Count
} finally {
    if ($connection.State -ne [System.Data.ConnectionState]::Closed) { $connection.Close() }
}




