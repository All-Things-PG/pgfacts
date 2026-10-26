-- Phase 1 migration capture schema for the local Migration database.
-- Additive and rerunnable: existing HtmlPages/HtmlList rows are retained.
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF DB_NAME() <> N'Migration'
    THROW 51000, 'Run this script only in the Migration database.', 1;

BEGIN TRANSACTION;

IF COL_LENGTH(N'dbo.HtmlPages', N'SourceType') IS NULL
    ALTER TABLE dbo.HtmlPages ADD SourceType nvarchar(40) NOT NULL CONSTRAINT DF_HtmlPages_SourceType DEFAULT (N'Page');
IF COL_LENGTH(N'dbo.HtmlPages', N'SourceHTML') IS NULL
    ALTER TABLE dbo.HtmlPages ADD SourceHTML nvarchar(max) NULL;
IF COL_LENGTH(N'dbo.HtmlPages', N'SourceText') IS NULL
    ALTER TABLE dbo.HtmlPages ADD SourceText nvarchar(max) NULL;
IF COL_LENGTH(N'dbo.HtmlPages', N'CaptureStatus') IS NULL
    ALTER TABLE dbo.HtmlPages ADD CaptureStatus varchar(20) NOT NULL CONSTRAINT DF_HtmlPages_CaptureStatus DEFAULT ('NotCaptured');
IF COL_LENGTH(N'dbo.HtmlPages', N'CapturedAt') IS NULL
    ALTER TABLE dbo.HtmlPages ADD CapturedAt datetime2(0) NULL;
IF COL_LENGTH(N'dbo.HtmlPages', N'MigrationStatus') IS NULL
    ALTER TABLE dbo.HtmlPages ADD MigrationStatus varchar(20) NOT NULL CONSTRAINT DF_HtmlPages_MigrationStatus DEFAULT ('Cataloged');
IF COL_LENGTH(N'dbo.HtmlPages', N'MigrationNotes') IS NULL
    ALTER TABLE dbo.HtmlPages ADD MigrationNotes nvarchar(1000) NULL;

IF COL_LENGTH(N'dbo.HtmlList', N'HtmlListID') IS NULL
BEGIN
    ALTER TABLE dbo.HtmlList ADD HtmlListID int IDENTITY(1,1) NOT NULL;
    ALTER TABLE dbo.HtmlList ADD CONSTRAINT PK_HtmlList PRIMARY KEY CLUSTERED (HtmlListID);
END;
IF COL_LENGTH(N'dbo.HtmlList', N'ItemType') IS NULL
    ALTER TABLE dbo.HtmlList ADD ItemType nvarchar(40) NOT NULL CONSTRAINT DF_HtmlList_ItemType DEFAULT (N'ContentItem');
IF COL_LENGTH(N'dbo.HtmlList', N'ItemTitle') IS NULL
    ALTER TABLE dbo.HtmlList ADD ItemTitle nvarchar(500) NULL;
IF COL_LENGTH(N'dbo.HtmlList', N'SourceUrl') IS NULL
    ALTER TABLE dbo.HtmlList ADD SourceUrl nvarchar(1000) NULL;
IF COL_LENGTH(N'dbo.HtmlList', N'SourceHTML') IS NULL
    ALTER TABLE dbo.HtmlList ADD SourceHTML nvarchar(max) NULL;
IF COL_LENGTH(N'dbo.HtmlList', N'DisplayOrder') IS NULL
    ALTER TABLE dbo.HtmlList ADD DisplayOrder int NULL;
IF COL_LENGTH(N'dbo.HtmlList', N'CaptureStatus') IS NULL
    ALTER TABLE dbo.HtmlList ADD CaptureStatus varchar(20) NOT NULL CONSTRAINT DF_HtmlList_CaptureStatus DEFAULT ('NotCaptured');
IF COL_LENGTH(N'dbo.HtmlList', N'CapturedAt') IS NULL
    ALTER TABLE dbo.HtmlList ADD CapturedAt datetime2(0) NULL;
IF COL_LENGTH(N'dbo.HtmlList', N'MigrationStatus') IS NULL
    ALTER TABLE dbo.HtmlList ADD MigrationStatus varchar(20) NOT NULL CONSTRAINT DF_HtmlList_MigrationStatus DEFAULT ('Cataloged');
IF COL_LENGTH(N'dbo.HtmlList', N'MigrationNotes') IS NULL
    ALTER TABLE dbo.HtmlList ADD MigrationNotes nvarchar(1000) NULL;

GO

IF OBJECT_ID(N'dbo.HtmlPageUrl', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HtmlPageUrl
    (
        HtmlPageUrlID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_HtmlPageUrl PRIMARY KEY,
        HtmlPageID int NOT NULL,
        SourceUrl nvarchar(1000) NOT NULL,
        IsCanonical bit NOT NULL CONSTRAINT DF_HtmlPageUrl_IsCanonical DEFAULT (1),
        HttpStatusCode smallint NULL,
        LastCheckedAt datetime2(0) NULL,
        CONSTRAINT FK_HtmlPageUrl_HtmlPages FOREIGN KEY (HtmlPageID) REFERENCES dbo.HtmlPages(HtmlPageID),
        CONSTRAINT UQ_HtmlPageUrl_SourceUrl UNIQUE (SourceUrl)
    );
END;

IF OBJECT_ID(N'dbo.HtmlMigrationMap', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HtmlMigrationMap
    (
        HtmlMigrationMapID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_HtmlMigrationMap PRIMARY KEY,
        HtmlPageID int NULL,
        HtmlListID int NULL,
        TargetType nvarchar(40) NULL,
        TargetKey nvarchar(200) NULL,
        TargetUrl nvarchar(1000) NULL,
        MappingStatus varchar(20) NOT NULL CONSTRAINT DF_HtmlMigrationMap_Status DEFAULT ('Pending'),
        Notes nvarchar(1000) NULL,
        CreatedAt datetime2(0) NOT NULL CONSTRAINT DF_HtmlMigrationMap_CreatedAt DEFAULT (sysdatetime()),
        CONSTRAINT FK_HtmlMigrationMap_HtmlPages FOREIGN KEY (HtmlPageID) REFERENCES dbo.HtmlPages(HtmlPageID),
        CONSTRAINT FK_HtmlMigrationMap_HtmlList FOREIGN KEY (HtmlListID) REFERENCES dbo.HtmlList(HtmlListID),
        CONSTRAINT CK_HtmlMigrationMap_OneSource CHECK ((HtmlPageID IS NOT NULL AND HtmlListID IS NULL) OR (HtmlPageID IS NULL AND HtmlListID IS NOT NULL)),
        CONSTRAINT CK_HtmlMigrationMap_Status CHECK (MappingStatus IN ('Pending','Mapped','Verified','Exception'))
    );
    CREATE UNIQUE INDEX UX_HtmlMigrationMap_Page ON dbo.HtmlMigrationMap(HtmlPageID) WHERE HtmlPageID IS NOT NULL;
    CREATE UNIQUE INDEX UX_HtmlMigrationMap_List ON dbo.HtmlMigrationMap(HtmlListID) WHERE HtmlListID IS NOT NULL;
END;

IF OBJECT_ID(N'dbo.HtmlMediaReference', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HtmlMediaReference
    (
        HtmlMediaReferenceID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_HtmlMediaReference PRIMARY KEY,
        HtmlPageID int NULL,
        HtmlListID int NULL,
        SourceUrl nvarchar(1000) NOT NULL,
        AltText nvarchar(1000) NULL,
        MediaKind nvarchar(40) NULL,
        IsExternal bit NOT NULL CONSTRAINT DF_HtmlMediaReference_IsExternal DEFAULT (0),
        AvailabilityStatus varchar(20) NOT NULL CONSTRAINT DF_HtmlMediaReference_Availability DEFAULT ('NotChecked'),
        LastCheckedAt datetime2(0) NULL,
        CONSTRAINT FK_HtmlMediaReference_HtmlPages FOREIGN KEY (HtmlPageID) REFERENCES dbo.HtmlPages(HtmlPageID),
        CONSTRAINT FK_HtmlMediaReference_HtmlList FOREIGN KEY (HtmlListID) REFERENCES dbo.HtmlList(HtmlListID),
        CONSTRAINT CK_HtmlMediaReference_OneSource CHECK ((HtmlPageID IS NOT NULL AND HtmlListID IS NULL) OR (HtmlPageID IS NULL AND HtmlListID IS NOT NULL))
    );
END;

IF EXISTS (SELECT 1 FROM sys.key_constraints WHERE parent_object_id=OBJECT_ID(N'dbo.HtmlMediaReference') AND name=N'UQ_HtmlMediaReference_PageUrl')
    ALTER TABLE dbo.HtmlMediaReference DROP CONSTRAINT UQ_HtmlMediaReference_PageUrl;
IF EXISTS (SELECT 1 FROM sys.key_constraints WHERE parent_object_id=OBJECT_ID(N'dbo.HtmlMediaReference') AND name=N'UQ_HtmlMediaReference_ListUrl')
    ALTER TABLE dbo.HtmlMediaReference DROP CONSTRAINT UQ_HtmlMediaReference_ListUrl;
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id=OBJECT_ID(N'dbo.HtmlMediaReference') AND name=N'UX_HtmlMediaReference_PageUrl')
    CREATE UNIQUE INDEX UX_HtmlMediaReference_PageUrl ON dbo.HtmlMediaReference(HtmlPageID,SourceUrl) WHERE HtmlPageID IS NOT NULL;
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id=OBJECT_ID(N'dbo.HtmlMediaReference') AND name=N'UX_HtmlMediaReference_ListUrl')
    CREATE UNIQUE INDEX UX_HtmlMediaReference_ListUrl ON dbo.HtmlMediaReference(HtmlListID,SourceUrl) WHERE HtmlListID IS NOT NULL;

COMMIT TRANSACTION;




