# DCMS - Dynamic Content and Menuing System

## Database Schema

This is the master document to describe the database schema for the **'AllThingsPG'** database.  

---

### Database Tables and Views

The following inventory lists all physical tables, logical database views, stored procedures, and operational scripts.

| Name | Type | Category | Purpose |
| :--- | :--- | :--- | :--- |
| **`SystemSettings`** | Table | System | Stores all global system settings. |
| **`SystemSettings_Audit`** | Table | System | Records changes to SystemSettings. |
| **`TableList`** | Table | System | Stores list of tables and purpose in the system. |
| **`ErrorLog`** | Table | System | Records database runtime errors, exception parameters, and logging states. |
| **`Numbers`** | Table | System | Utility table of numbers from 1 - 1000, used for looping. |
| **`VisitorType`** | Table | Lookup | Stores user personas to customize display (Patient, Caregiver, Provider, etc.). |
| **`RouteType`** | Table | Lookup | Defines the navigation behavior for a MenuItem (Visitor switch, content display, html page etc ). |
| **`ContentType`** | Table | Lookup | Specifies the type of the content, why its being displayed (Article, FAQ, Gallery, etc). |
| **`FormatType`** | Table | Lookup | Indicates the file format of the source content (.TXT, .HTML, .MD etc ). |
| **`MimeType`** | Table | Lookup | Indicates what the content is and how to render it (WORD, JPEG, PDF etc) |
| **`WorkflowStatus`** | Table | Lookup | Manages content approval milestones (Draft, Review, Published). |
| **`MenuItem`** | Table | Menu | Provides the list of all parent and child menu items in the system. |
| **`ContentDocument`** | Table | Content | Provides a top-level descrition and meta data of a document as parent to child elements. |
| **`ContentElement`** | Table | Content | Individual content pieces of the parent document. |
| **`StagingDocument`** | Table | Staging | Work in progress definition of a document. |
| **`StagingElement`** | Table | Staging | Work in progress definition of a document. |
| **`MenuItemList`** | View | Menu | Flat structure showing child and parent menu attributes along with their child and parent Content. |
| **`ContentDocumentList`** | View | Content | Flat structure showing child and parent content document, element and menu. |
| **`ContentElementList`** | View | Content | Flat structure showing child element records of a document. |

---

## 1. Lookup Tables

Static dictionary tables that classify system settings. They are read-only at runtime and populated when creating the database.

### Table: `VisitorType`
Classifies the type of user visiting the website.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `Code` | char(1) | NOT NULL | PRIMARY KEY | Short single-letter unique identifier for personas (e.g., 'P'). |
| `Description` | nvarchar(50) | NOT NULL | - | User-friendly title displayed throughout headers and portals. |
| `SortOrder` | int | NOT NULL | - | Sequence index sorting menus/tabs from left-to-right. |
| `IsDefault` | bit | NOT NULL | DEFAULT 0 | Fallback flag designating standard un-identified visitor experiences. |

**Sample Data:**

| Code | Description    | SortOrder | IsDefault |
| :--- | :--- | :--- | :--- |
| P    | Patient        | 1         | 0         |
| C    | Caregiver      | 2         | 0         |
| M    | Provider       | 3         | 0         |
| D    | Pharmaceutical | 4         | 0         |
| V    | Visitor        | 5         | 1         |

---

### Table: `RouteType`
Defines how the navigation engine interprets a selected menu item's target path.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `Code` | char(1) | NOT NULL | PRIMARY KEY | Unique routing action descriptor identifier. |
| `Name` | nvarchar(50) | NOT NULL | - | UI display label describing navigation styles. |
| `Folder` | nvarchar(100) | NULL | - | Directory pathway mapping context handlers dynamically. |
| `Purpose` | nvarchar(500) | NULL | - | Technical operational usage guidelines. |

**Sample Data:**

| Code | Name     | Folder  | Purpose |
| :--- | :--- | :--- | :--- |
| V    | Visitor  | Visitor | Persona selection / session switching |
| C    | Content  | Content | Dynamically loads database-curated articles |
| P    | Portal   | Visitor | Direct route to dedicated portal homepages |
| R    | Redirect | NULL    | Outer relative or absolute external link |
| T    | Tag      | NULL    | Anchor jump / internal bookmark within page |

---

### Table: `ContentType`
Defines the overall visual rendering template layout used by the card viewer to load outer frameworks.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `Code` | char(3) | NOT NULL | PRIMARY KEY | Code specifying dynamic wrappers (e.g., 'ART', 'FAQ'). |
| `Description` | nvarchar(255) | NOT NULL | - | Render layout description label. |
| `SortOrder` | int | NOT NULL | - | Grid loading order variables. |

**Sample Data:**

| Code | Description    | SortOrder |
| :--- | :--- | :--- |
| ART  | Standard Article Layout | 10 |
| GAL  | Embedded Image Gallery | 20 |
| FAQ  | Accordion Question list| 30 |

---

## Lookup Tables

Lookup tables are code-keyed reference tables. The primary key is always `Code char(1)`, clustered. They provide validated domain values for `char(1)` foreign-key columns throughout the schema. All lookup tables follow the same four-column pattern: `Code`, `Name` (or `Title`), `Description`, and `SortOrder`.

---

### ContentType

Defines the types of content a `ContentDocument` can represent (e.g., article, page, file download).

**Columns**

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| `Code` | `char(1)` | NOT NULL | PK |
| `Name` | `nvarchar(50)` | NOT NULL | |
| `Description` | `nvarchar(200)` | NOT NULL | |
| `SortOrder` | `int` | NOT NULL | |

**Constraints**

| Name | Type | Detail |
|------|------|--------|
| `PK_ContentType` | PRIMARY KEY | (Code) |

**Indexes**

| Name | Columns | Type | Unique |
|------|---------|------|--------|
| `PK_ContentType` | Code | CLUSTERED | Yes |

---

### Table: `FormatType`
Specifies how the raw payload body text has been encoded for presentation.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `Code` | char(3) | NOT NULL | PRIMARY KEY | Indicator designating source types (e.g., 'RAW', 'MD'). |
| `Description` | nvarchar(255) | NOT NULL | - | Friendly translation format name. |

**Sample Data:**

| Code | Description |
| :--- | :--- |
| RAW  | Plain Unicode / unprocessed content |
| HTML | Clean elements ready for rendering |
| MD   | Markdown syntax |

---

### Table: `MimeType`
Defines standard media/Internet types, signaling to the card body dispatcher which Razor partial should parse a record.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `Code` | nvarchar(100) | NOT NULL | PRIMARY KEY | Official MIME identifier string (e.g., 'text/html'). |
| `Description` | nvarchar(255) | NOT NULL | - | Human-friendly layout classification notes. |
| `IsText` | bit | NOT NULL | DEFAULT 1 | Switch targeting plain string structures. |
| `IsBinary` | bit | NOT NULL | DEFAULT 0 | Switch targeting serialized array assets in databases. |

**Sample Data:**

| Code | Description | IsText | IsBinary |
| :--- | :--- | :--- | :--- |
| text/html | Raw HTML markup | 1 | 0 |
| text/markdown | Markdown file body | 1 | 0 |
| image/jpeg | Standard JPEG image | 0 | 1 |
| application/pdf | Embedded PDF document | 0 | 1 |

---

### Table: `WorkflowStatus`
The editorial lifecycle flag of a curated item. Only published content is visible to public visitors.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `Code` | char(1) | NOT NULL | PRIMARY KEY | Content stage code (e.g., 'D', 'P'). |
| `Description` | nvarchar(50) | NOT NULL | - | Human-review label translating status streams. |

**Sample Data:**

| Code | Description |
| :--- | :--- |
| D    | Draft (Work in progress) |
| R    | Review (Pending approval) |
| P    | Published (Live on site) |
| X    | Archived (Retired) |

---

## 2. Transactional Tables

These tables construct navigation hierarchies and route targets dynamically on load, separating high-level descriptor structures from the active sequence payloads.

### Table: `MenuItem`
Models the hierarchy and maps navigation destinations.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `MenuItemID` | int | NOT NULL | IDENTITY(1,1) PK | Primary key identifier for the menu node. |
| `ParentMenuItemID` | int | NULL | FK -> `MenuItem.MenuItemID` | Identifies parent node. NULL implies top-level tab. |
| `Title` | nvarchar(255) | NOT NULL | - | Text label rendered dynamically inside menu list items. |
| `RouteType` | char(1) | NOT NULL | FK -> `RouteType.Code` | Dictates the routing execution strategy (e.g., Portal, Content). |
| `RouteTarget` | nvarchar(1000) | NOT NULL | - | Direct payload parameter (Persona code, MenuItemID, static URL string). |
| `VisitorMask` | nvarchar(20) | NOT NULL | DEFAULT 'PCMDV' | Bit-mask character segment validating persona discovery (e.g. 'PC'). |
| `SortOrder` | int | NOT NULL | DEFAULT 0 | Ordering index within parent scope. |
| `IsActive` | bit | NOT NULL | DEFAULT 1 | Soft-delete switch hiding items when inactive. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit creation timestamp registry. |
| `ModifiedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit updating timestamp registry. |

**Indexes:**
*   `IX_MenuItem_ParentMenuItemID` (Non-clustered Index)
*   `IX_MenuItem_RouteType` (Non-clustered Index)
*   `IX_MenuItem_IsActive_SortOrder` (Performance Index for Layout Queries)

**Sample Data:**

*   *Persona Switch:*
    `{ MenuItemID: 1, ParentMenuItemID: NULL, Title: "Patient Info", RouteType: "V", RouteTarget: "P", VisitorMask: "PCMDV", SortOrder: 1 }`
*   *Dynamic Database Article:*
    `{ MenuItemID: 8, ParentMenuItemID: 1, Title: "Wound Guidelines", RouteType: "C", RouteTarget: "8", VisitorMask: "PM", SortOrder: 2 }`
*   *Manual Route to separate Portal Page:*
    `{ MenuItemID: 2, ParentMenuItemID: NULL, Title: "Provider Portal", RouteType: "P", RouteTarget: "M", VisitorMask: "PCMDV", SortOrder: 1 }`

---

### Table: `Content`
Holds high-level info describing a curated content module.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `ContentID` | int | NOT NULL | IDENTITY(1,1) PK | Primary key identifier for the curated record. |
| `MenuItemID` | int | NOT NULL | FK -> `MenuItem.MenuItemID` | Links this piece of content to its corresponding menu trigger. |
| `ContentType` | char(3) | NOT NULL | FK -> `ContentType.Code` | Dictates outer layout/template constraints (e.g. FAQ). |
| `Description` | nvarchar(500) | NULL | - | Human-readable title segment or display name. |
| `Metadata` | nvarchar(max) | NULL | - | JSON object holding page-level configurations (e.g., Author, scroll tags). |
| `WorkflowStatus` | char(1) | NOT NULL | FK -> `WorkflowStatus.Code` DEFAULT 'D' | Lifecycle approvals tracker flag. |
| `IsPublished` | bit NOT NULL | DEFAULT 0 | - | Direct indicator of visibility on public portals. |
| `PublishedDate` | datetime2(7) | NULL | - | Timestamp recording when workflow moved to published state. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log. |
| `ModifiedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log. |

**Indexes:**
*   `IX_Content_MenuItemID` (Clustered / Foreign Key Optimization Index)
*   `IX_Content_IsPublished_WorkflowStatus` (Fast visitor filter index)

**Sample Data:**

`{ ContentID: 23, MenuItemID: 8, ContentType: "ART", Description: "Wound Management in Patient Portal", Metadata: "{\"Author\":\"Alavi\",\"ReadTime\":5}", WorkflowStatus: "P", IsPublished: 1 }`

---

### Table: `ContentBody`
Splits content streams into sequence blocks rendering in order via partial view segments.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `ContentBodyID` | int | NOT NULL | IDENTITY(1,1) PK | Primary key of this payload sequence block. |
| `ContentID` | int | NOT NULL | FK -> `Content.ContentID` | Links body segment to its parent descriptor card. |
| `FormatType` | char(3) | NOT NULL | FK -> `FormatType.Code` | Dictates encoding layout (HTML, Markdown). |
| `MimeType` | nvarchar(100) | NOT NULL | FK -> `MimeType.Code` | Selects dynamic Razor partial dispatcher reader templates. |
| `SortOrder` | int | NOT NULL | DEFAULT 10 | Sequential display order of these parts within the Content parent. |
| `Metadata` | nvarchar(max) | NULL | - | JSON object rendering block directives (e.g. floating, captioning). |
| `TextContent` | nvarchar(max) | NULL | - | Main string storage (e.g. raw HTML segments, Markdown text). |
| `BinaryContent` | varbinary(max) | NULL | - | Local secure database file streams (images, files). |
| `LocalFilePath` | nvarchar(500) | NULL | - | Referral linkage pointers tracking local working files on server. |
| `ExternalFilePath` | nvarchar(1000) | NULL | - | Referral linkage tracking external URL targets. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log. |
| `ModifiedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log. |

**Indexes:**
*   `IX_ContentBody_ContentID_SortOrder` (Clustered retrieve optimization index)

**Sample Data:**

`{ ContentBodyID: 44, ContentID: 23, FormatType: "MD", MimeType: "text/markdown", SortOrder: 10, Metadata: "{\"placement\":\"inline\"}", TextContent: "### Overview\nPyoderma gangrenosum features rapidly progressing wounds..." }`

---

## 3. Staging Tables

These tables decouple incoming, curated content projects (such as bulk uploads, external text files, or markdown guides drafted off-site) from live operational tables, allowing editors to review layout elements in a workspace before committing them to production.

### Table: `StagingDocument`
Serves as the high-level staging envelope to group and preview upcoming curation deliverables.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `StagingDocumentID` | int | NOT NULL | IDENTITY(1,1) PK | Primary key identifier for the staged document envelope. |
| `Title` | nvarchar(255) | NOT NULL | - | Intended title segment. |
| `Description` | nvarchar(500) | NOT NULL | - | Descriptive introduction parameters. |
| `ContentType` | char(1) | NOT NULL | - | Layout target reference code (e.g. 'A' for Article, 'G' for Gallery). |
| `Metadata` | nvarchar(max) | NOT NULL | - | JSON parameter tag mapping layout properties and variables. |
| `WorkflowStatus` | char(1) | NOT NULL | - | Decoupled workflow state marker tracking approvals. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log creation register. |
| `ModifiedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log revision register. |

**Indexes:**
*   `IX_StagingDocument_WorkflowStatus` (Non-clustered filter optimization index)

**Sample Data:**

`{ StagingDocumentId: 5, Title: "Associated Conditions", Description: "Drafting Comorbidities List", ContentType: "A", Metadata: "{\"Author\":\"Alavi\"}", WorkflowStatus: "R" }`

---

### Table: `StagingContent`
Binds individual body sequence sections to a staged parent envelope, matching the target content schema.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `StagingContentID` | int | NOT NULL | IDENTITY(1,1) PK | Primary key of this staged body block. |
| `StagingDocumentID` | int | NOT NULL | FK -> `StagingDocument` | Associates sequence body blocks to their stage document parent. |
| `WorkflowStatus` | char(1) | NOT NULL | - | Dynamic inner state code tracker flag. |
| `FormatType` | char(1) | NOT NULL | - | Encoding target code specifying layout formats. |
| `MimeType` | char(1) | NOT NULL | - | Multi-media file identifier target. |
| `Metadata` | nvarchar(max) | NOT NULL | - | JSON parameter rendering segment positions and modifications. |
| `TextContent` | nvarchar(max) | NULL | - | Staged unicode snippets, raw HTML alignments, or markdown content. |
| `BinaryContent` | varbinary(max) | NULL | - | Staged file block array streams (images, files). |
| `LocalFilePath` | nvarchar(255) | NULL | - | Linkage reference to local files on backend server. |
| `ExternalFilePath` | nvarchar(255) | NULL | - | Linkage reference mapping external absolute targets. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log. |
| `ModifiedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit log. |

**Indexes:**
*   `IX_StagingContent_StagingDocumentId` (Clustered join index)

**Sample Data:**

`{ StagingContentId: 12, StagingDocumentId: 5, WorkflowStatus: "D", FormatType: "M", MimeType: "M", Metadata: "{\"placement\":\"right\"}", TextContent: "### Associated Wounds\nMany PG patients present with comorbidities..." }`

---

## 4. System Tables

System logging and tracking models designed to record operational audits, transaction performance logs, and error metrics captured at runtime.

### Table: `ErrorLog`
Records database runtime errors, exception parameters, and logging states.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `ErrorLogID` | int | NOT NULL | IDENTITY(1,1) PRIMARY KEY | Primary key logging sequence identifier. |
| `ProcedureName` | sysname | NOT NULL | - | Tracks the T-SQL procedure or module registering the incident. |
| `ErrorMessage` | nvarchar(4000) | NULL | - | Raw diagnostic descriptive exception body statement. |
| `ErrorNumber` | int | NULL | - | Database engine exception classification number. |
| `ErrorSeverity` | int | NULL | - | Logical threat rating severity metric. |
| `ErrorState` | int | NULL | - | Operational state tracking exception code. |
| `Parameters` | nvarchar(max) | NULL | - | Input parameter payload values serialized on failure. |
| `UserName` | nvarchar(128) | NOT NULL | DEFAULT (suser_sname()) | Identity of user executing the instruction. |
| `HostName` | nvarchar(128) | NOT NULL | DEFAULT (host_name()) | Client context network name trace origin. |
| `LogLevel` | varchar(10) | NOT NULL | DEFAULT ('ERROR') check CK | Message priority indicator check-restricted constraint (ERROR, WARNING, INFO, DEBUG). |
| `LogDate` | datetime2(7) | NOT NULL | DEFAULT (sysdatetime()) | Clock timestamp logging register index. |

