# DCMS - Dynamic Content and Menuing System

## Database Schema

This document describes the implemented schema for the **AllThingsPG** SQL Server database project. The SQL project under `Database\AllThingsPG.Database` is the implementation baseline for table names, column definitions, constraints, relationships, views, functions, procedures, and deployment behavior.

The schema separates:

* lookup data that defines valid domain values;
* menu and route definitions used to build navigation;
* content documents and ordered content elements;
* staging records used before content is published;
* registration, communication, system, and test-support data.

---

## Database Project

| Property | Value |
| :--- | :--- |
| Project | `AllThingsPG.Database` |
| Project file | `AllThingsPG.Database.sqlproj` |
| Schema provider | `Microsoft.Data.Tools.Schema.Sql.Sql160DatabaseSchemaProvider` |
| Target | SQL Server database |
| Default schema | `dbo` |
| Deployment | SSDT build, pre-deployment, and post-deployment scripts |

### Implemented object inventory

| Object type | Location | Objects |
| :--- | :--- | :--- |
| Tables | `Tables` | 29 tables, including operational, lookup, staging, and test tables |
| Views | `Views` | `ContentDocumentList`, `ContentElementList`, `MenuItemList`, `MissingTableList`, `TableList` |
| Functions | `Functions` | 15 scalar/table-valued utility and validation functions |
| Stored procedures | `Stored Procedures` | 61 initialization, CRUD, validation, population, logging, and reporting procedures |
| Deployment scripts | Project root and `Scripts` | `Pre-Deployment.sql`, `Post-Deployment.sql`, backup and initial-data scripts |
| Test scripts | `Testing` | Non-build scripts for setup, normalization, population, validation, and test execution |

---

## 1. Lookup Tables

Lookup tables provide validated domain values referenced by transactional tables. Their codes are deliberately compact because they are used as foreign-key values in menu, content, registration, staging, and rendering records.

### Table: `VisitorType`

Defines visitor personas used by registration and menu visibility rules.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `Code` | `char(1)` | NOT NULL | Primary key |
| `Description` | `nvarchar(200)` | NOT NULL | Persona description |
| `SortOrder` | `int` | NOT NULL | Display order |
| `IsDefault` | `bit` | NOT NULL | Identifies the default persona |

**Current sample data:**

| Code | Description | SortOrder | IsDefault |
| :--- | :--- | ---: | :---: |
| `P` | Patient | 1 | 0 |
| `C` | Caregiver | 2 | 0 |
| `M` | Provider | 3 | 0 |
| `D` | Pharmaceutical | 4 | 0 |
| `V` | Visitor | 5 | 1 |
| `R` | Register | 6 | 0 |

### Table: `RouteType`

Defines how a menu item route is interpreted by the application.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `Code` | `char(1)` | NOT NULL | Primary key |
| `Description` | `nvarchar(200)` | NOT NULL | Route behavior description |
| `Folder` | `nvarchar(200)` | NOT NULL | Application folder or handler context |
| `SortOrder` | `int` | NOT NULL | Display or evaluation order |

**Current sample data:**

| Code | Description | Folder | SortOrder |
| :--- | :--- | :--- | ---: |
| `V` | Visitor | `Visitor` | 1 |
| `C` | Content | `Content` | 2 |
| `P` | Page | `Page` | 3 |
| `R` | Redirect | `Redirect` | 4 |

### Table: `ContentType`

Defines the document-level content classification or rendering template.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `Code` | `char(1)` | NOT NULL | Primary key |
| `Name` | `nvarchar(50)` | NOT NULL | Short type name |
| `Description` | `nvarchar(200)` | NOT NULL | Type description |
| `SortOrder` | `int` | NOT NULL | Display order |

**Current sample data:**

| Code | Name | Description | SortOrder |
| :--- | :--- | :--- | ---: |
| `A` | Article | Long-form educational content | 1 |
| `N` | NewsItem | News updates and announcements | 2 |
| `F` | FAQ | Question and answer pairs | 3 |
| `T` | Testimonial | Patient and caregiver stories | 4 |
| `P` | Profile | Board members, staff, medical experts | 5 |
| `E` | Event | Events, webinars, fundraisers | 6 |
| `L` | Link | External resource or reference | 8 |
| `R` | Research | Clinical trial or research study | 9 |
| `X` | External | External file | 10 |
| `G` | Gallery | Image gallery metadata | 11 |
| `D` | Document | PDF or downloadable file reference | 12 |
| `U` | Unknown | Content has not been populated | 99 |

### Table: `FormatType`

Defines the source or encoding format of a content element.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `Code` | `char(1)` | NOT NULL | Primary key |
| `Name` | `nvarchar(50)` | NOT NULL | Format name |
| `Description` | `nvarchar(200)` | NOT NULL | Format description |
| `FileTypes` | `nvarchar(200)` | NOT NULL | Associated file extensions or types |
| `SortOrder` | `int` | NOT NULL | Display or processing order |

**Current sample data:**

| Code | Name | Description | SortOrder |
| :--- | :--- | :--- | ---: |
| `T` | Text | Plain Text | 1 |
| `R` | RTF | Rich Text | 2 |
| `H` | HTML | Web Page Markup | 3 |
| `E` | EPUB | Electronic Pub | 4 |
| `P` | PDF | Portable Doc | 5 |
| `M` | MD | Markdown | 6 |
| `J` | JSON | JSON | 7 |
| `I` | IMAGE | Binary Image | 8 |
| `A` | AUDIO | Binary Audio | 9 |
| `W` | WORD | MS Word Document | 10 |
| `S` | EXCEL | MS Spreadsheet | 11 |
| `N` | PPT | Powerpoint | 12 |
| `G` | GDOC | Google Document | 13 |
| `D` | OPEN | Open Document | 14 |
| `?` | UNKNOWN | Unknown | 99 |

### Table: `MimeType`

Defines the media type and rendering characteristics of a content element.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `Code` | `char(1)` | NOT NULL | Primary key |
| `FormatType` | `char(1)` | NOT NULL | FK to `FormatType.Code` |
| `Name` | `nvarchar(50)` | NOT NULL | MIME type name |
| `Description` | `nvarchar(200)` | NOT NULL | Rendering description |
| `IsText` | `bit` | NOT NULL | Indicates text payload |
| `IsBinary` | `bit` | NOT NULL | Indicates binary payload |
| `IsRenderable` | `bit` | NOT NULL | Indicates whether the application can render it |
| `SortOrder` | `int` | NOT NULL | Processing or display order |

Constraint: `FK_MimeType_FormatType` references `FormatType(Code)`.

**Current sample data:**

| Code | FormatType | Name | Description | IsText | IsBinary | IsRenderable | SortOrder |
| :--- | :--- | :--- | :--- | ---: | ---: | ---: | ---: |
| `T` | `T` | TXT | `text/plain` | 1 | 0 | 1 | 1 |
| `M` | `M` | MD | `text/markdown` | 1 | 0 | 1 | 2 |
| `H` | `H` | HTML | `text/html` | 1 | 0 | 1 | 3 |
| `C` | `H` | HTM | `text/htm` | 1 | 0 | 1 | 4 |
| `R` | `R` | RTF | `application/rtf` | 1 | 0 | 1 | 5 |
| `J` | `J` | JSON | `application/json` | 1 | 0 | 1 | 6 |
| `E` | `E` | EPUB | `application/epub+zip` | 0 | 1 | 1 | 7 |
| `P` | `P` | PDF | `application/pdf` | 0 | 1 | 1 | 8 |
| `I` | `I` | JPG | `image/jpeg` | 0 | 1 | 1 | 9 |
| `N` | `I` | PNG | `image/png` | 0 | 1 | 1 | 10 |
| `F` | `I` | GIF | `image/gif` | 0 | 1 | 1 | 11 |
| `S` | `I` | SVG | `image/svg+xml` | 0 | 1 | 1 | 12 |
| `W` | `I` | WEBP | `image/webp` | 0 | 1 | 1 | 13 |
| `A` | `A` | MP3 | `audio/mpeg` | 0 | 1 | 1 | 14 |
| `U` | `A` | WAV | `audio/wav` | 0 | 1 | 1 | 15 |
| `Q` | `A` | OGG | `audio/ogg` | 0 | 1 | 1 | 16 |
| `D` | `W` | DOCX | `application/vnd.openxmlformats-officedocument.wordprocessingml.document` | 0 | 1 | 1 | 17 |
| `X` | `W` | DOCM | `application/vnd.ms-word.document.macroEnabled.12` | 0 | 1 | 1 | 18 |
| `Y` | `W` | DOTX | `application/vnd.openxmlformats-officedocument.wordprocessingml.template` | 0 | 1 | 1 | 19 |
| `Z` | `W` | DOTM | `application/vnd.ms-word.template.macroEnabled.12` | 0 | 1 | 1 | 20 |
| `L` | `S` | XLS | `application/vnd.ms-excel` | 0 | 1 | 1 | 21 |
| `K` | `S` | XLSX | `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` | 0 | 1 | 1 | 22 |
| `!` | `N` | PPT | `application/vnd.ms-powerpoint` | 0 | 1 | 1 | 23 |
| `@` | `N` | PPTX | `application/vnd.openxmlformats-officedocument.presentationml.presentation` | 0 | 1 | 1 | 24 |
| `#` | `N` | PPS | `application/vnd.ms-powerpoint` | 0 | 1 | 1 | 25 |
| `$` | `N` | PPSX | `application/vnd.openxmlformats-officedocument.presentationml.slideshow` | 0 | 1 | 1 | 26 |
| `%` | `N` | POT | `application/vnd.ms-powerpoint` | 0 | 1 | 1 | 27 |
| `^` | `N` | POTX | `application/vnd.openxmlformats-officedocument.presentationml.template` | 0 | 1 | 1 | 28 |
| `&` | `N` | PPTM | `application/vnd.ms-powerpoint.presentation.macroEnabled.12` | 0 | 1 | 1 | 29 |
| `*` | `N` | PPSM | `application/vnd.ms-powerpoint.slideshow.macroEnabled.12` | 0 | 1 | 1 | 30 |
| `+` | `N` | POTM | `application/vnd.ms-powerpoint.template.macroEnabled.12` | 0 | 1 | 1 | 31 |
| `G` | `G` | GDOC | `application/vnd.google-apps.document` | 0 | 1 | 1 | 32 |
| `O` | `D` | ODT | `application/vnd.oasis.opendocument.text` | 0 | 1 | 1 | 33 |
| `B` | `?` | BIN | `application/octet-stream` | 0 | 1 | 0 | 99 |

### Table: `WorkflowStatus`

Defines the editorial state of content and staged content.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `Code` | `char(1)` | NOT NULL | Primary key |
| `Title` | `nvarchar(50)` | NOT NULL | Short status title |
| `Description` | `nvarchar(200)` | NULL | Status explanation |
| `SortOrder` | `int` | NOT NULL | Workflow order |

**Current sample data:**

| Code | Title | Description | SortOrder |
| :--- | :--- | :--- | ---: |
| `D` | Draft | Content is newly curated or created | 1 |
| `R` | Review | Content needs review | 2 |
| `A` | Approved | Content has been approved but not published | 3 |
| `X` | Rejected | Content has been rejected | 4 |
| `P` | Published | Content has been published | 5 |

---

## 2. Menu and Routing Tables

### Table: `MenuItem`

`MenuItem` is the runtime menu model. A row represents one menu node. Parent-child relationships are represented by the self-referencing `ParentMenuItemID`; a `NULL` parent identifies a top-level item.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `MenuItemID` | `int identity(1,1)` | NOT NULL | Clustered primary key |
| `ParentMenuItemID` | `int` | NULL | Self-FK to `MenuItem.MenuItemID` |
| `Title` | `nvarchar(200)` | NOT NULL | Menu label |
| `RouteType` | `char(1)` | NOT NULL | FK to `RouteType.Code` |
| `RouteTarget` | `nvarchar(200)` | NOT NULL | Route-specific target value |
| `VisitorMask` | `varchar(10)` | NOT NULL | Allowed visitor-type codes |
| `SortOrder` | `int` | NOT NULL | Defaults to `0`; must be non-negative |
| `IsActive` | `bit` | NOT NULL | Defaults to `1`; controls visibility |
| `CreatedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |
| `ModifiedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |

Constraints:

* `FK_MenuItem_Parent` references the same table through `ParentMenuItemID`.
* `FK_MenuItem_RouteType` references `RouteType(Code)`.
* `CK_MenuItem_SortOrder` requires `SortOrder >= 0`.
* `CK_MenuItem_Title_Normalized` rejects reserved URL, markup, and query characters.
* `CK_MenuItem_VisitorMask` permits only `P`, `C`, `M`, `D`, `V`, and `R`, and requires a non-empty mask.

### Visitor Types (`RouteType = V`)

The visitor route selects or changes the visitor persona. The current Welcome branch contains seven active records: one parent and six visitor choices.

| MenuItemID | ParentMenuItemID | Title | RouteTarget | VisitorMask | SortOrder | IsActive |
| ---: | ---: | :--- | :--- | :--- | ---: | ---: |
| 1 | NULL | Welcome | `/visitor?v=Register` | `PCMDVR` | 1 | 1 |
| 2 | 1 | &nbsp;&nbsp;Patient | `/visitor?v=Patient` | `PCMDVR` | 1 | 1 |
| 3 | 1 | &nbsp;&nbsp;Caregiver | `/visitor?v=Caregiver` | `PCMDVR` | 2 | 1 |
| 4 | 1 | &nbsp;&nbsp;Provider | `/visitor?v=Provider` | `PCMDVR` | 3 | 1 |
| 5 | 1 | &nbsp;&nbsp;Pharmaceutical | `/visitor?v=Pharmaceutical` | `PCMDVR` | 4 | 1 |
| 6 | 1 | &nbsp;&nbsp;Visitor | `/visitor?v=Visitor` | `PCMDVR` | 5 | 1 |
| 7 | 1 | &nbsp;&nbsp;Register | `/visitor?v=Register` | `PCMDVR` | 6 | 1 |

All seven rows have `RouteType = 'V'`.

### Content Example (`RouteType = C`)

`About PG` demonstrates a content route with a root menu item, child menu items, and third-level submenu items. The hierarchy below is the complete active descendant tree for `MenuItemID = 8`.

| MenuItemID | ParentMenuItemID | Level | Title | RouteTarget | VisitorMask | SortOrder | IsActive |
| ---: | ---: | ---: | :--- | :--- | :--- | ---: | ---: |
| 8 | NULL | 0 | About PG | `/content?c=about%20pg` | `PCMDVR` | 2 | 1 |
| 9 | 8 | 1 | &nbsp;&nbsp;What is PG | `/content?c=what%20is%20pg` | `PCMDVR` | 1 | 1 |
| 10 | 8 | 1 | &nbsp;&nbsp;Clinical Topics | `/content?c=clinical%20topics` | `PCMDVR` | 2 | 1 |
| 17 | 8 | 1 | &nbsp;&nbsp;Living With PG | `/content?c=living%20with%20pg` | `PCMDVR` | 3 | 1 |
| 11 | 10 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Symptoms | `/content?c=symptoms` | `PCMDVR` | 1 | 1 |
| 12 | 10 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Diagnosis | `/content?c=diagnosis` | `PCMDVR` | 2 | 1 |
| 13 | 10 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Treatment | `/content?c=treatment` | `PCMDVR` | 3 | 1 |
| 14 | 10 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Wound Care | `/content?c=wound%20care` | `PCMDVR` | 4 | 1 |
| 15 | 10 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Pain Management | `/content?c=pain%20management` | `PCMDVR` | 5 | 1 |
| 16 | 10 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Outcomes | `/content?c=outcomes` | `PCMDVR` | 6 | 1 |
| 18 | 17 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Emotional Journey | `/content?c=emotional%20journey` | `PCMDVR` | 1 | 1 |
| 19 | 17 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Loss of Mobility | `/content?c=loss%20of%20mobility` | `PCMDVR` | 2 | 1 |
| 20 | 17 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Loss of Identity | `/content?c=loss%20of%20identity` | `PCMDVR` | 3 | 1 |
| 21 | 17 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Avoiding Mistakes | `/content?c=avoiding%20mistakes` | `PCMDVR` | 4 | 1 |
| 22 | 17 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Managing Disability | `/content?c=managing%20disability` | `PCMDVR` | 5 | 1 |
| 23 | 17 | 2 | &nbsp;&nbsp;&nbsp;&nbsp;Comorbidities | `/content?c=comorbidities` | `PCMDVR` | 6 | 1 |

All rows in this example have `RouteType = 'C'`.

### Other RouteTypes (`P` and `R`)

The remaining route types currently represented in `MenuItem` are page routes (`P`) and redirects (`R`).

| MenuItemID | ParentMenuItemID | Title | RouteType | RouteTarget | VisitorMask | SortOrder | IsActive |
| ---: | ---: | :--- | :---: | :--- | :--- | ---: | ---: |
| 64 | 59 | Clinic Finder | `P` (Page) | `/page?p=clinicfinder.html` | `PCMD` | 5 | 1 |
| 66 | 65 | All Things Pyoderma 4.2k members | `R` (Redirect) | `/redirect?r=https://www.facebook.com/groups/368163159232` | `PCMD` | 1 | 1 |
| 67 | 65 | PG Support Group 2.6k member | `R` (Redirect) | `/redirect?r=https://www.facebook.com/groups/56007379235` | `PCMD` | 2 | 1 |
| 68 | 65 | PG Support and Advocacy 1.4k members | `R` (Redirect) | `/redirect?r=https://www.facebook.com/groups/345212721641027` | `PCMD` | 3 | 1 |
| 84 | 80 | Global Skin Alliance | `R` (Redirect) | `/redirect?r=https://globalskin.org/` | `PCMDVR` | 4 | 1 |

These rows demonstrate that page and redirect targets can appear beneath other menu items while retaining their own route-specific behavior.

### Table: `MasterMenu`

`MasterMenu` stores the descriptive master-menu representation used by import, population, or legacy menu workflows. It is separate from the normalized runtime `MenuItem` hierarchy.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `MenuID` | `int identity(1,1)` | NOT NULL | Identity identifier |
| `ParentMenuID` | `int` | NULL | Parent reference value |
| `Parent` | `nvarchar(100)` | NOT NULL | Parent menu label |
| `Child` | `nvarchar(100)` | NOT NULL | Child menu label |
| `SubMenu` | `nvarchar(100)` | NOT NULL | Submenu label |
| `MenuType` | `nvarchar(10)` | NOT NULL | Menu classification |
| `VisitorMask` | `nvarchar(20)` | NULL | Visitor visibility mask |
| `RouteType` | `nvarchar(10)` | NULL | Route classification |
| `RouteTarget` | `nvarchar(200)` | NULL | Route target |
| `Description` | `nvarchar(200)` | NOT NULL | Menu description |
| `Notes` | `nvarchar(200)` | NULL | Additional notes |

### Tables: `MasterMenuStage` and `MasterMenu_Stage`

These tables support staged or imported master-menu data. They retain the parent, child, submenu, menu type, visitor, routing, description, and notes fields before or during menu population.

`MasterMenuStage` has an identity `MenuID` and uses `MenuType`. `MasterMenu_Stage` has an identity `LoadOrder` and uses `Type`; it does not define a primary key or foreign keys.

---

## 3. Content Tables

### Table: `ContentDocument`

Stores the document-level descriptor associated with a menu item. A content document is the parent of one or more ordered `ContentElement` rows.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `ContentDocumentID` | `int identity(1,1)` | NOT NULL | Clustered primary key |
| `MenuItemID` | `int` | NOT NULL | FK to `MenuItem.MenuItemID` |
| `ContentType` | `char(1)` | NOT NULL | FK to `ContentType.Code` |
| `Description` | `nvarchar(500)` | NOT NULL | Document description |
| `MetaData` | `nvarchar(max)` | NOT NULL | JSON document metadata |
| `WorkflowStatus` | `char(1)` | NOT NULL | Defaults to `D`; FK to `WorkflowStatus.Code` |
| `IsPublished` | `bit` | NOT NULL | Public visibility flag |
| `PublishedDate` | `datetime2(0)` | NULL | Publication timestamp |
| `CreatedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |
| `ModifiedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |

Constraints:

* `CK_ContentDocument_MetaData_IsJSON` requires valid JSON in `MetaData`.
* `FK_ContentDocument_MenuItem` cascades deletion from a menu item.
* `FK_ContentDocument_ContentType` and `FK_ContentDocument_WorkflowStatus` enforce valid classifications.

### Table: `ContentElement`

Stores an ordered or independently addressable content block belonging to a document.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `ContentElementID` | `int identity(1,1)` | NOT NULL | Clustered primary key |
| `ContentDocumentID` | `int` | NOT NULL | FK to `ContentDocument.ContentDocumentID` |
| `FormatType` | `char(1)` | NOT NULL | FK to `FormatType.Code` |
| `MimeType` | `char(1)` | NOT NULL | FK to `MimeType.Code` |
| `BlockInfo` | `nvarchar(max)` | NOT NULL | JSON block metadata |
| `TextContent` | `nvarchar(max)` | NULL | Text, HTML, or other textual payload |
| `BinaryContent` | `varbinary(max)` | NULL | Binary payload |
| `LocalFilePath` | `nvarchar(255)` | NULL | Local server file reference |
| `ExternalFilePath` | `nvarchar(255)` | NULL | External file reference |
| `CreatedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |
| `ModifiedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |

Constraint: `CK_ContentElement_BlockInfo_IsJSON` requires valid JSON in `BlockInfo`. Deleting a document cascades to its elements.

---

## 4. Staging Tables

Staging tables represent content before it is promoted to the operational content tables.

### Table: `StagingDocument`

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `StagingDocumentID` | `int identity(1,1)` | NOT NULL | Clustered primary key |
| `MenuItemID` | `int` | NULL | Optional FK to `MenuItem.MenuItemID` |
| `Title` | `nvarchar(255)` | NOT NULL | Staged document title |
| `Description` | `nvarchar(500)` | NOT NULL | Staged document description |
| `ContentType` | `char(1)` | NOT NULL | FK to `ContentType.Code` |
| `Metadata` | `nvarchar(max)` | NOT NULL | JSON staging metadata |
| `WorkflowStatus` | `char(1)` | NOT NULL | Staging workflow state |
| `CreatedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |
| `ModifiedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |

`CK_StagingDocument_Metadata_IsJSON` validates `Metadata`. The menu-item relationship is optional so a staged document can exist before it is assigned to navigation.

### Table: `StagingElement`

Stores staged content blocks associated with a staged document.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `StagingElementID` | `int identity(1,1)` | NOT NULL | Clustered primary key |
| `StagingDocumentID` | `int` | NOT NULL | FK to `StagingDocument.StagingDocumentID` |
| `WorkflowStatus` | `char(1)` | NOT NULL | Element workflow state; FK to `WorkflowStatus.Code` |
| `FormatType` | `char(1)` | NOT NULL | FK to `FormatType.Code` |
| `MimeType` | `char(1)` | NOT NULL | FK to `MimeType.Code` |
| `Metadata` | `nvarchar(max)` | NOT NULL | JSON rendering metadata |
| `TextContent` | `nvarchar(max)` | NULL | Staged text payload |
| `BinaryContent` | `varbinary(max)` | NULL | Staged binary payload |
| `LocalFilePath` | `nvarchar(255)` | NULL | Local file reference |
| `ExternalFilePath` | `nvarchar(255)` | NULL | External file reference |
| `CreatedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |
| `ModifiedDate` | `datetime2(0)` | NOT NULL | Defaults to `sysdatetime()` |

`CK_StagingElement_Metadata_IsJSON` validates `Metadata`. The staging document relationship is not configured with cascade delete.

---

## 5. Registration and Communication Tables

### Table: `Registration`

Stores registered users and visitor-persona preferences.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `RegistrationID` | `int identity(1,1)` | NOT NULL | Clustered primary key |
| `Email` | `nvarchar(500)` | NOT NULL | Unique login/contact address |
| `PasswordHash` | `varbinary(256)` | NULL | Password hash |
| `PasswordSalt` | `varbinary(256)` | NULL | Password salt |
| `VisitorType` | `char(1)` | NOT NULL | FK to `VisitorType.Code` |
| `IsMember` | `bit` | NOT NULL | Membership flag |
| `IsVolunteer` | `bit` | NOT NULL | Volunteer flag |
| `IsNewsLetter` | `bit` | NOT NULL | Newsletter subscription flag |
| `IsFundraising` | `bit` | NOT NULL | Fundraising communication flag |
| `IsActive` | `bit` | NOT NULL | Account-active flag |
| `CreatedDate`, `ModifiedDate` | `datetime2(0)` | NOT NULL | Audit timestamps |

`UQ_Registration_Email` enforces unique email addresses.

### Table: `Contact`

Stores contact and address details for a registration.

| Column | Type | Nullability | Purpose |
| :--- | :--- | :--- | :--- |
| `ContactID` | `int identity(1,1)` | NOT NULL | Primary key |
| `RegistrationID` | `int` | NOT NULL | FK to `Registration.RegistrationID` |
| `FirstName`, `LastName`, `MiddleName` | `varchar(100)` | First/last NOT NULL; middle NULL | Name fields |
| `MobilePhone`, `HomePhone`, `WorkPhone` | `varchar(20)` | NULL | Phone fields |
| `WorkEmail` | `varchar(500)` | NULL | Work email |
| `AddressLine1`, `AddressLine2` | `varchar(200)` | NULL | Address fields |
| `ForeignAddress` | `varchar(500)` | NULL | Non-domestic address |
| `City`, `StateProvince`, `Country` | `varchar(100)` | NULL | Location fields |
| `PostalCode` | `varchar(20)` | NULL | Postal code |
| `DateOfBirth` | `date` | NULL | Birth date |
| `CreatedDate`, `ModifiedDate` | `datetime2(0)` | NOT NULL | Audit timestamps |

### Table: `Email`

Stores outbound email messages.

| Column | Type | Nullability | Purpose |
| :--- | :--- | :--- | :--- |
| `EmailID` | `int identity(1,1)` | NOT NULL | Primary key |
| `Subject` | `varchar(200)` | NOT NULL | Subject |
| `BodyText` | `nvarchar(max)` | NULL | Message body |
| `SentDate` | `datetime2(7)` | NOT NULL | Defaults to `sysutcdatetime()` |
| `CreatedDate`, `ModifiedDate` | `datetime2(0)` | NOT NULL | Audit timestamps |

### Table: `EmailRecipient`

Associates an email with a registered recipient.

| Column | Type | Nullability | Purpose |
| :--- | :--- | :--- | :--- |
| `EmailRecipientID` | `int identity(1,1)` | NOT NULL | Primary key |
| `EmailID` | `int` | NOT NULL | FK to `Email.EmailID`; cascade delete |
| `RegistrationID` | `int` | NOT NULL | FK to `Registration.RegistrationID`; cascade delete |
| `DateSent` | `datetime2(7)` | NULL | Delivery timestamp |
| `CreatedDate` | `datetime2(0)` | NOT NULL | Creation timestamp |

### Table: `EmailAttachment`

Stores binary files attached to an email.

| Column | Type | Nullability | Purpose |
| :--- | :--- | :--- | :--- |
| `EmailAttachmentID` | `int identity(1,1)` | NOT NULL | Primary key |
| `EmailID` | `int` | NOT NULL | FK to `Email.EmailID`; cascade delete |
| `FileName` | `varchar(255)` | NOT NULL | File name |
| `FileType` | `varchar(50)` | NOT NULL | File type |
| `FileData` | `varbinary(max)` | NOT NULL | File contents |
| `CreatedDate` | `datetime2(0)` | NOT NULL | Creation timestamp |

### Tables: `Newsletter` and `PublishedNewsletter`

`Newsletter` associates a `ContentDocument` with distribution and publication dates. `PublishedNewsletter` stores published delivery representations, including optional email recipient and URL references, with flags for email, HTML, and flyer forms.

---

## 6. System and Utility Tables

### Table: `SystemSettings`

Stores typed application and database configuration values.

| Column | Type | Nullability | Purpose |
| :--- | :--- | :--- | :--- |
| `SettingID` | `int identity(1,1)` | NOT NULL | Primary key |
| `SettingKey` | `varchar(50)` | NOT NULL | Unique uppercase setting key |
| `SettingType` | `varchar(50)` | NOT NULL | Uppercase type such as `STRING`, `JSON`, `GUID`, `INTEGER`, or `BOOLEAN` |
| `SettingGroup` | `varchar(50)` | NOT NULL | Uppercase group: `GLOBALVAR`, `APPLICATION`, `DATABASE`, or `SYSTEM` |
| `SettingValue` | `sql_variant` | NULL | Typed setting value |
| `LastUpdated` | `datetime2(7)` | NOT NULL | Defaults to `sysdatetime()` |

The table enforces uppercase keys, types, and groups; valid setting types and groups; JSON and GUID validity where applicable; required values for non-string/list types; and a unique setting key.

### Table: `SystemSettings_Audit`

Stores historical setting values and update timestamps. It contains `AuditID`, the original setting identity and key/type/group/value fields, `LastUpdated`, and `AuditDate`.

### Table: `SystemTables`

Registers database tables for system discovery and diagnostics.

| Column | Type | Nullability | Constraints / purpose |
| :--- | :--- | :--- | :--- |
| `TableID` | `int identity(1,1)` | NOT NULL | Primary key |
| `TableName` | `varchar(50)` | NOT NULL | Unique table name |
| `TableType` | `varchar(15)` | NOT NULL | `Registration`, `Menu`, `Staging`, `Content`, `Lookup`, or `System` |
| `SortOrder` | `int` | NOT NULL | Display order |

### Table: `Numbers`

Stores integer values used by database loops and set-based utility procedures. `Number` is the clustered primary key.

### Table: `ErrorLog`

Stores database diagnostics. It includes `ProcedureName`, error details, serialized `Parameters`, executing `UserName` and `HostName`, a constrained `LogLevel` (`DEBUG`, `INFO`, `WARNING`, or `ERROR`), and `LogDate`.

---

## 7. Test-Support Tables

These tables support database validation and test harness execution. They are included in the database project but are not part of the public runtime content model.

### Table: `TestHarness`

Stores test cases and execution results, including test hierarchy, category, expected and actual values, menu/content identifiers, processing state, and error details.

### Table: `MenuItemTestHarness`

Stores menu-specific test definitions and outcomes, including parent test relationships, expected results, menu title, route values, visitor mask, sort order, active state, processing state, and notes.

---

## 8. Views

### `MenuItemList`

Provides a flattened menu reporting and validation view. It includes the current menu item, parent menu attributes, route metadata, associated content-document metadata, parent content metadata, parent/child indicators, and a `MissingPlaceholder` flag when a content route lacks a document.

### `ContentDocumentList`

Joins `ContentDocument` to its menu item, route type, content type, and workflow status. It is intended for content validation, administration, and reporting.

### `ContentElementList`

Joins each `ContentElement` to its document, menu item, route type, content type, format type, MIME type, and workflow status. It exposes both element data and inherited document/menu metadata.

### `TableList`

Provides database table inventory information for system discovery.

### `MissingTableList`

Reports expected or registered tables that are missing from the database.

---

## 9. Functions

The project defines the following reusable functions:

* `Create_MetaData`
* `Get_SystemSetting`
* `Get_TableList`
* `Normalize_ErrorMessage`
* `Normalize_RouteTarget`
* `Normalize_RouteType`
* `Normalize_SettingKey`
* `Normalize_Slug`
* `Normalize_Title`
* `Normalize_Token`
* `Normalize_VisitorMask`
* `SplitCSVRow`
* `TableExists`
* `TablesExists`
* `Validate_Url`

Normalization functions enforce consistent values before validation or persistence. Discovery functions expose settings and table metadata. Existence and validation functions support deployment and database-health checks.

---

## 10. Stored Procedures

Stored procedures are organized by responsibility:

| Responsibility | Procedures |
| :--- | :--- |
| Initialization and deployment | `Initialize_Database`, `Create_Tables`, `Create_Lookup_Tables`, `Create_Content_Tables`, `Create_Staging_Tables`, `Create_System_Tables`, `Create_Registration_Tables`, `Create_Numbers_Table`, `Create_MenuItem_Table`, `Create_MasterMenu_Table`, `Create_ErrorLog_Table`, `Create_SystemSettings_Table`, `Create_SystemTables_Table`, `Create_TableList_Table` |
| Content | `Insert_ContentDocument`, `Insert_ContentElement`, `Insert_Content_Placeholder`, `Delete_Content`, `Populate_ContentDocument` |
| Menu | `Insert_MenuItem`, `Insert_MenuItem_Parent`, `Insert_MenuItem_Child`, `Delete_MenuItem`, `Populate_MenuItems`, `Populate_MasterMenu`, `Perform_MenuItem_Validation` |
| Staging | `Populate_Staging`, `Delete_Staging`, `Validate_Staging` |
| Lookup population | `Populate_ContentType`, `Populate_FormatType`, `Populate_MimeType`, `Populate_RouteType`, `Populate_VisitorType`, `Populate_WorkflowStatus`, `Populate_Lookup_Tables` |
| System data | `Populate_SystemSettings`, `Populate_SystemTables`, `Populate_Numbers_Table`, `Set_SystemSetting`, `Get_SystemInfo` |
| Validation and inspection | `Validate_Database`, `Validate_Content`, `Validate_MenuItem`, `Perform_Table_Check`, `Show_Tables`, `Show_Schema`, `Show_Foreign_Keys` |
| Logging and messaging | `Log_Error`, `Log_Debug`, `Clear_ErrorLog`, `Print_Messages`, `Opening_Message`, `Success_Message` |
| Test support | `Create_TestHarness`, `Populate_TestHarness`, `Execute_TestHarness`, `Create_TempTable_FromCSV` |

The `Testing` folder contains non-build versions and focused scripts for setup, population, normalization, URL validation, menu validation, schema display, and test execution.

---

## 11. Deployment and Data Flow

1. SSDT builds the schema objects listed in the project file.
2. `Pre-Deployment.sql` and `Scripts\PreDeploy\01_Backup.sql` provide pre-deployment preparation and backup behavior.
3. Lookup, system, menu, and initial content data are populated through post-deployment scripts and population procedures.
4. Imported or authored content enters `StagingDocument` and `StagingElement`.
5. Validation procedures check staged menu, content, workflow, route, format, and metadata values.
6. Approved content is represented by `ContentDocument` and its `ContentElement` children.
7. Runtime menu queries use active `MenuItem` rows, visitor masks, route metadata, and sort order.
8. Runtime content queries use published `ContentDocument` rows and their associated elements.
9. Views provide flattened data for administration, diagnostics, and validation.

### Runtime relationship summary

```text
VisitorType
    |
Registration ---- Contact
    |
Email ---- EmailRecipient ---- Registration
  |
  +---- EmailAttachment

RouteType ---- MenuItem ---- ContentDocument ---- ContentElement
                  |                 |
                  |                 +---- ContentType
                  +---- parent MenuItem
                  +---- VisitorMask
                  +---- WorkflowStatus

ContentType ---- StagingDocument ---- StagingElement
FormatType ---- ContentElement / StagingElement
MimeType   ---- ContentElement / StagingElement
WorkflowStatus ---- ContentDocument / StagingElement
```

## 12. Source of Truth

This document describes the current SQL project, but the `.sql` object definitions remain authoritative when a description and implementation differ. Any future schema change should update the corresponding SQL object and this document in the same change.
