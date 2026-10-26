-- Additive HTML menu structure for the Migration database.
-- Creates one menu entry per HtmlPages row; rerunning updates labels/order/parent links.
SET NOCOUNT ON;
SET XACT_ABORT ON;
IF DB_NAME() <> N'Migration'
    THROW 51004, 'Run this script only in the Migration database.', 1;
IF OBJECT_ID(N'dbo.HtmlPages',N'U') IS NULL
    THROW 51005, 'dbo.HtmlPages must exist before creating dbo.HtmlMenu.', 1;

BEGIN TRANSACTION;
IF OBJECT_ID(N'dbo.HtmlMenu',N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HtmlMenu
    (
        HtmlMenuID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_HtmlMenu PRIMARY KEY,
        HtmlPageID int NOT NULL,
        ParentHtmlMenuID int NULL,
        MenuLabel nvarchar(200) NOT NULL,
        DisplayOrder int NOT NULL,
        IsVisible bit NOT NULL CONSTRAINT DF_HtmlMenu_IsVisible DEFAULT (1),
        CONSTRAINT FK_HtmlMenu_HtmlPages FOREIGN KEY (HtmlPageID) REFERENCES dbo.HtmlPages(HtmlPageID),
        CONSTRAINT FK_HtmlMenu_Parent FOREIGN KEY (ParentHtmlMenuID) REFERENCES dbo.HtmlMenu(HtmlMenuID),
        CONSTRAINT UQ_HtmlMenu_HtmlPage UNIQUE (HtmlPageID)
    );
END;

-- Seed pages in the existing inventory order. Our People and News & Events
-- detail pages are children of their corresponding listing entries.
;WITH OrderedPages AS
(
    SELECT p.HtmlPageID,p.PageName,ROW_NUMBER() OVER (ORDER BY p.HtmlPageID) AS DisplayOrder
    FROM dbo.HtmlPages p
), PageParents AS
(
    SELECT c.HtmlPageID,
           CASE WHEN parent.HtmlPageID IS NOT NULL THEN pm.HtmlMenuID END AS ParentHtmlMenuID
    FROM OrderedPages c
    LEFT JOIN dbo.HtmlPages parent
      ON (parent.PageName=N'Our People' AND c.PageName IN (N'Dr. Alex Ortega Loayza',N'Corlis Watkins-Nass',N'Dave DePottie',N'Lasaunia Thompson',N'LaGail Odoms',N'Gina Castelli'))
      OR (parent.PageName=N'News & Events' AND c.PageName IN (N'November 14 PFAC',N'Phase 3 Clinical Trial for Spesolimab',N'First PFAC Meeting in Michigan',N'July 2026 All Things PG Newsletter',N'First Year Anniversary Celebration',N'Welcome to All Things PG'))
    LEFT JOIN dbo.HtmlMenu pm ON pm.HtmlPageID=parent.HtmlPageID
)
MERGE dbo.HtmlMenu AS target
USING
(
    SELECT o.HtmlPageID,o.PageName AS MenuLabel,CONVERT(int,o.DisplayOrder) AS DisplayOrder,pp.ParentHtmlMenuID
    FROM OrderedPages o JOIN PageParents pp ON pp.HtmlPageID=o.HtmlPageID
) AS source
ON target.HtmlPageID=source.HtmlPageID
WHEN MATCHED THEN UPDATE SET MenuLabel=source.MenuLabel,DisplayOrder=source.DisplayOrder,ParentHtmlMenuID=source.ParentHtmlMenuID
WHEN NOT MATCHED THEN INSERT (HtmlPageID,ParentHtmlMenuID,MenuLabel,DisplayOrder) VALUES (source.HtmlPageID,source.ParentHtmlMenuID,source.MenuLabel,source.DisplayOrder);

COMMIT TRANSACTION;

SELECT m.HtmlMenuID,m.ParentHtmlMenuID,m.MenuLabel,m.DisplayOrder,m.IsVisible,p.PageName
FROM dbo.HtmlMenu m JOIN dbo.HtmlPages p ON p.HtmlPageID=m.HtmlPageID
ORDER BY m.DisplayOrder;
