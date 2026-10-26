/*
Load captured Phase 1 HtmlMenu into AllThingsPG.dbo.MasterMenuStage.
Replaces only MasterMenuStage. Does not alter MasterMenu or run downstream routines.
Root rows map to Parent; child rows map to Child. All source entries use RouteType C.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;
IF DB_NAME() <> N'AllThingsPG' THROW 51060, 'Run in AllThingsPG.', 1;
IF DB_ID(N'Migration') IS NULL THROW 51061, 'Migration database unavailable.', 1;
IF OBJECT_ID(N'dbo.MasterMenuStage',N'U') IS NULL THROW 51062, 'MasterMenuStage missing.', 1;
IF OBJECT_ID(N'Migration.dbo.HtmlMenu',N'U') IS NULL OR OBJECT_ID(N'Migration.dbo.HtmlPages',N'U') IS NULL OR OBJECT_ID(N'Migration.dbo.HtmlPageUrl',N'U') IS NULL THROW 51063, 'Migration source tables missing.', 1;
CREATE TABLE #MenuSource(HtmlMenuID int NOT NULL PRIMARY KEY, ParentHtmlMenuID int NULL, MenuLabel nvarchar(200) NOT NULL, DisplayOrder int NOT NULL, SourceUrl nvarchar(2048) NULL, HierarchyPath varchar(max) NULL, MenuID int NULL);
INSERT #MenuSource(HtmlMenuID,ParentHtmlMenuID,MenuLabel,DisplayOrder,SourceUrl)
SELECT hm.HtmlMenuID,hm.ParentHtmlMenuID,LTRIM(RTRIM(hm.MenuLabel)),hm.DisplayOrder,url.SourceUrl
FROM Migration.dbo.HtmlMenu hm JOIN Migration.dbo.HtmlPages hp ON hp.HtmlPageID=hm.HtmlPageID
LEFT JOIN Migration.dbo.HtmlPageUrl url ON url.HtmlPageID=hp.HtmlPageID AND url.IsCanonical=1
WHERE hm.IsVisible=1;
IF (SELECT COUNT(*) FROM #MenuSource)=0 THROW 51065, 'No visible source rows.', 1;
IF EXISTS(SELECT 1 FROM #MenuSource WHERE MenuLabel=N'') THROW 51066, 'Blank source label.', 1;
IF EXISTS(SELECT 1 FROM #MenuSource c LEFT JOIN #MenuSource p ON p.HtmlMenuID=c.ParentHtmlMenuID WHERE c.ParentHtmlMenuID IS NOT NULL AND p.HtmlMenuID IS NULL) THROW 51067, 'Child has missing or hidden parent.', 1;
;WITH MenuTree AS
(
 SELECT s.HtmlMenuID,CAST(RIGHT('000000'+CONVERT(varchar(6),s.DisplayOrder),6) AS varchar(max)) AS HierarchyPath FROM #MenuSource s WHERE s.ParentHtmlMenuID IS NULL
 UNION ALL
 SELECT c.HtmlMenuID,CAST(p.HierarchyPath+'/'+RIGHT('000000'+CONVERT(varchar(6),c.DisplayOrder),6) AS varchar(max)) FROM #MenuSource c JOIN MenuTree p ON p.HtmlMenuID=c.ParentHtmlMenuID
)
UPDATE s SET HierarchyPath=t.HierarchyPath FROM #MenuSource s JOIN MenuTree t ON t.HtmlMenuID=s.HtmlMenuID OPTION(MAXRECURSION 100);
IF EXISTS(SELECT 1 FROM #MenuSource WHERE HierarchyPath IS NULL) THROW 51068, 'Menu cycle or unreachable row.', 1;
;WITH Ordered AS(SELECT HtmlMenuID,CONVERT(int,ROW_NUMBER() OVER(ORDER BY HierarchyPath)) AS MenuID FROM #MenuSource)
UPDATE s SET MenuID=o.MenuID FROM #MenuSource s JOIN Ordered o ON o.HtmlMenuID=s.HtmlMenuID;
BEGIN TRY
 BEGIN TRANSACTION;
 DELETE dbo.MasterMenuStage;
 SET IDENTITY_INSERT dbo.MasterMenuStage ON;
 INSERT dbo.MasterMenuStage(MenuID,Parent,Child,SubMenu,VisitorMask,RouteType,RouteTarget,Description,Notes)
 SELECT s.MenuID,CASE WHEN s.ParentHtmlMenuID IS NULL THEN s.MenuLabel ELSE N'' END,CASE WHEN s.ParentHtmlMenuID IS NOT NULL THEN s.MenuLabel ELSE N'' END,N'',N'ALL',N'C',N'',N'',LEFT(COALESCE(s.SourceUrl,N''),400)
 FROM #MenuSource s;
 SET IDENTITY_INSERT dbo.MasterMenuStage OFF;
 IF (SELECT COUNT(*) FROM dbo.MasterMenuStage)<>(SELECT COUNT(*) FROM #MenuSource) THROW 51069, 'Stage count mismatch.', 1;
 IF EXISTS(SELECT 1 FROM dbo.MasterMenuStage WHERE RouteType<>N'C' OR VisitorMask<>N'ALL' OR (NULLIF(Parent,N'') IS NULL AND NULLIF(Child,N'') IS NULL AND NULLIF(SubMenu,N'') IS NULL)) THROW 51070, 'Invalid staged row.', 1;
 IF EXISTS(SELECT 1 FROM #MenuSource s JOIN dbo.MasterMenuStage d ON d.MenuID=s.MenuID WHERE (s.ParentHtmlMenuID IS NULL AND (d.Parent<>s.MenuLabel OR d.Child<>N'')) OR (s.ParentHtmlMenuID IS NOT NULL AND (d.Child<>s.MenuLabel OR d.Parent<>N''))) THROW 51071, 'Staged hierarchy mismatch.', 1;
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
 IF XACT_STATE()<>0 ROLLBACK TRANSACTION;
 BEGIN TRY SET IDENTITY_INSERT dbo.MasterMenuStage OFF; END TRY BEGIN CATCH END CATCH;
 THROW;
END CATCH;
SELECT MenuID,Parent,Child,SubMenu,VisitorMask,RouteType,RouteTarget,Description,Notes FROM dbo.MasterMenuStage ORDER BY MenuID;
SELECT COUNT(*) AS StagedRows,SUM(CASE WHEN Parent<>N'' THEN 1 ELSE 0 END) AS ParentRows,SUM(CASE WHEN Child<>N'' THEN 1 ELSE 0 END) AS ChildRows,SUM(CASE WHEN RouteType=N'C' THEN 1 ELSE 0 END) AS ContentRoutes FROM dbo.MasterMenuStage;
