-- Validate the Phase 1 source inventory and captured HTML in Migration.
-- Read-only apart from returning diagnostics; raises an error if core counts fail.
SET NOCOUNT ON;
IF DB_NAME() <> N'Migration'
    THROW 51002, 'Run this validation only in the Migration database.', 1;

DECLARE @Pages int = (SELECT COUNT(*) FROM dbo.HtmlPages);
DECLARE @PageUrls int = (SELECT COUNT(*) FROM dbo.HtmlPageUrl WHERE IsCanonical=1);
DECLARE @CapturedPages int = (SELECT COUNT(*) FROM dbo.HtmlPages WHERE CaptureStatus='Captured' AND NULLIF(SourceHTML,N'') IS NOT NULL AND NULLIF(SourceText,N'') IS NOT NULL);
DECLARE @GoodUrls int = (SELECT COUNT(*) FROM dbo.HtmlPageUrl WHERE IsCanonical=1 AND HttpStatusCode=200);
DECLARE @ListItems int = (SELECT COUNT(*) FROM dbo.HtmlList);
DECLARE @TitledItems int = (SELECT COUNT(*) FROM dbo.HtmlList WHERE NULLIF(ItemTitle,N'') IS NOT NULL);
DECLARE @PageMaps int = (SELECT COUNT(*) FROM dbo.HtmlMigrationMap WHERE HtmlPageID IS NOT NULL AND HtmlListID IS NULL);
DECLARE @ListMaps int = (SELECT COUNT(*) FROM dbo.HtmlMigrationMap WHERE HtmlListID IS NOT NULL AND HtmlPageID IS NULL);
DECLARE @MediaRefs int = (SELECT COUNT(*) FROM dbo.HtmlMediaReference);

SELECT N'Pages' AS CheckName, @Pages AS Actual, 32 AS Expected, IIF(@Pages=32,N'PASS',N'FAIL') AS Result
UNION ALL SELECT N'Canonical URLs',@PageUrls,32,IIF(@PageUrls=32,N'PASS',N'FAIL')
UNION ALL SELECT N'Captured pages with text',@CapturedPages,32,IIF(@CapturedPages=32,N'PASS',N'FAIL')
UNION ALL SELECT N'Canonical HTTP 200',@GoodUrls,32,IIF(@GoodUrls=32,N'PASS',N'FAIL')
UNION ALL SELECT N'List items',@ListItems,23,IIF(@ListItems=23,N'PASS',N'FAIL')
UNION ALL SELECT N'Titled list items',@TitledItems,23,IIF(@TitledItems=23,N'PASS',N'FAIL')
UNION ALL SELECT N'Page mappings',@PageMaps,32,IIF(@PageMaps=32,N'PASS',N'FAIL')
UNION ALL SELECT N'List item mappings',@ListMaps,23,IIF(@ListMaps=23,N'PASS',N'FAIL')
UNION ALL SELECT N'Media references',@MediaRefs,@MediaRefs,N'INFO';

IF @Pages<>32 OR @PageUrls<>32 OR @CapturedPages<>32 OR @GoodUrls<>32 OR @ListItems<>23 OR @TitledItems<>23 OR @PageMaps<>32 OR @ListMaps<>23
    THROW 51003, 'Migration capture validation failed; inspect the result set above.', 1;

SELECT ItemType, COUNT(*) AS ItemCount FROM dbo.HtmlList GROUP BY ItemType ORDER BY ItemType;
SELECT p.PageName, u.SourceUrl, u.HttpStatusCode, p.CaptureStatus, LEN(p.SourceText) AS SourceTextLength
FROM dbo.HtmlPages p
JOIN dbo.HtmlPageUrl u ON u.HtmlPageID=p.HtmlPageID AND u.IsCanonical=1
ORDER BY p.PageName;
