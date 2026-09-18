---
layout: page
title: Dynamic Content
updated: 2026-09-18
---

# DCMS - Dynamic Content and Menuing System

## Dynamic Content

This document defines the design, architecture, and specifications for data-driven **Dynamic Content** in ATPG Phase 2.

---

### Dynamic Content Overview

Dynamic Content allows curated content to be stored in a database and rendered at run-time as opposed to written static HTML created at design-time.  Instead of hardcoded pages created by a programmer, dynamic content can be curated outside of the system by anyone, and published to the database using tools and utlities.
This allows content to be securely stored in the database and preserved through routine backups.  The system stores content along with meta data that describes how the content is to be displayed.  The website uses **Conent Cards** on predefined web pages to retrieve and display the content with help from the meta data.  Content Cards act as placeholders, and will retrive the content from the database and display to the screen using a **Card Reader Architecture**. 

The system displays content stored in the database using content descriptors, or meta data, to help render the content.  , so that you have separate entities of *what* is displayed vs *how* to display it.  A content card on an HTML page is used to display content that is stored in the database.  Different types of content cards can display different types of content.  Each instance of a content element in the database is referred to as a BLOCK.  A Block has both content (stored as text or binary), and rendering instructions (stored as JSON in BlockInfo).  
and rendering instructionshas hboth the content to display and the instructions on how to display it using a content card reader.  The Card Reader simply follows instructions on how to display the content element.  There are many different types of content, referred to as MIME types, and each Card Reader type will support one MIME Type.  sorting weights—such as articles integrated with inline images, embedded clinical pamphlets, or gallery widgets.

---

## 1. Domain Concepts and Definitions

1. **Curated Content Workflows** - Tracks content maturity (Drafts, Refined, Approved, Live, or Archived statuses) through formal status fields.
2. **Content Staging** - 
3. **CONTENT Types** - Standardizes layout templates to render nested content sections using partial components based on MIME type specifications.
4. **FORMAT Types** - Standardizes layout templates to render nested content sections using partial components based on MIME type specifications.
5. **MIME Types ** - Isolates high-level details (titles, permissions, status records) into descriptors while delegating raw contents (HTML, markdown, files, filepaths) to child rows.
6. **BLOCK Info ** - Integrates layout parameters, captions, width specifications, and float positioning variables directly into localized JSON metadata bags.
7. **Content Cards** - Standardizes layout templates to render nested content sections using partial components based on MIME type specifications.
8. **Dynamic Menu Items** - Couples navigation directly to the content engine using the unique menu primary key (`MenuItemID`), shielding pages from broken URLs when titles are updated.
9. **Web Pages and Styles** - Couples navigation directly to the content engine using the unique menu primary key (`MenuItemID`), shielding pages from broken URLs when titles are updated.

---

## 2. Dynamic Content Relational Schemas

### Table: `Content` (Descriptor)
Houses metadata descriptors, page-level instructions, and core workflow statuses.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `ContentID` | int | NOT NULL | IDENTITY(1,1) PK | Unique ID of the content card. |
| `MenuItemID` | int | NOT NULL | FK -> `MenuItem.MenuItemID` | Direct reference to the menu item managing this view. |
| `ContentType`| char(3) | NOT NULL | FK -> `ContentType.Code` | Mapped category layout style index (e.g. `ART`). |
| `Description`| nvarchar(255) | NOT NULL | - | Headline title rendered dynamically in layout headers. |
| `Metadata` | nvarchar(max) | NULL | - | Page-wide JSON bag storing custom attributes (e.g., tags, summary). |
| `WorkflowStatus`| char(1) | NOT NULL | FK -> `WorkflowStatus.Code` | Lifecycle maturity tracking variable (e.g., Draft, Published). |
| `IsPublished`| bit | NOT NULL | DEFAULT 0 | Toggle showing if the content card is active and servable to clients. |
| `PublishedDate`| datetime2(7) | NULL | - | Timestamp reflecting when the content item was published. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit creation timestamp registry. |
| `ModifiedDate`| datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit updating timestamp registry. |

---

### Table: `ContentBody` (Payload)
Contains fragment payloads, file locations, formats, and rendering sequence weights.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `ContentBodyID`| int | NOT NULL | IDENTITY(1,1) PK | Unique reference of this body fragment segment. |
| `ContentID` | int | NOT NULL | FK -> `Content.ContentID` | Parent content descriptor container. |
| `FormatType` | char(3) | NOT NULL | FK -> `FormatType.Code` | Format of text segment (e.g. `RAW`, `RND`). |
| `MimeType` | varchar(100)  | NOT NULL | FK -> `MimeType.Code` | MIME type indicator dispatching partial renderers. |
| `SortOrder` | int | NOT NULL | DEFAULT 0 | Display priority sequence order within the parent card. |
| `Metadata` | nvarchar(max) | NULL | - | Body-specific JSON parameters (e.g., caption, floating, align). |
| `TextContent` | nvarchar(max) | NULL | - | Text fragment (Plain Text, HTML, or raw Markdown syntax block). |
| `BinaryContent`| varbinary(max)| NULL | - | Binary image or stream storage (when hosting assets directly). |
| `LocalFilePath`| nvarchar(500) | NULL | - | Relative path directory mapping to assets hosted on the web server. |
| `ExternalFilePath`| nvarchar(2000)| NULL | - | Full absolute path pointing to remote, external web assets. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit creation timestamp registry. |
| `ModifiedDate`| datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit updating timestamp registry. |

---

## 3. Core System Lookups

### Lookup Table: `ContentType`
Standardizes logical content categorization.

**Sample Records:**

| Code | Name | Folder / Layout Style | Purpose |
| :--- | :--- | :--- | :--- |
| `ART` | Article | Content | Renders text-heavy column sheets and images. |
| `GAL` | Gallery | Portals | Displays photo collections and thumbnail grids. |
| `DOC` | Document | Downloads | Direct linkages to clinical pamphlets. |
| `FAQ` | FAQ Sheet | Accords | Stacked expanding accordions. |

### Lookup Table: `FormatType`
Specifies preprocessing filters for text-based fragments.

**Sample Records:**

| Code | Name | Description |
| :--- | :--- | :--- |
| `RAW` | Raw Code | Delivered raw without layout processing. |
| `RND` | Pre-Rendered | Pre-generated HTML fragments rendered directly inside Razor. |
| `ENC` | Encoded Source | Compressed string formats requiring programmatic decoding. |

### Lookup Table: `MimeType`
Configures MIME indicators and dispatch variables.

**Sample Records:**

| Code (MimeType) | Description | IsText | IsBinary | IsRenderable |
| :--- | :--- | :--- | :--- | :--- |
| `text/html` | HTML Segment | 1 | 0 | 1 |
| `text/markdown` | Markdown Segment | 1 | 0 | 1 |
| `image/jpeg` | JPEG File | 0 | 1 | 1 |
| `application/pdf` | PDF Document | 0 | 1 | 0 |

---

## 4. Content Routing Lifecycle

Dynamic Routing maps visitor clicks directly to Page controllers via standard ID parameters:

```
[User Clicks Menu Link with RouteType = C]
                     |
                     v (URL: /Content?m=24)
         [Content/Index.cshtml.cs] OnGet(int m)
                     |
                     +-- Queries database for Content where MenuItemID = 24 AND IsPublished = 1
                     |   (Eager loads ContentBodies ordered by SortOrder)
                     |
                     v (If found, maps to layout variables)
             [Content/Index.cshtml]
                     |
                     +-- Maps ViewData["Title"] = Content.Description
                     |
                     v (Renders outer chrome wrapper)
           [Partials/_ContentCard.cshtml]
                     |
                     v (Loops through child ContentBody fragments)
           [Partials/_ContentBody.cshtml]
                     |
                     +---> Evaluates body.MimeType (Dispatches custom partial renderers)
                               |
                               +-- text/html       --> _Body_TextHtml.cshtml
                               +-- text/markdown   --> _Body_TextMarkdown.cshtml
                               +-- image/jpeg      --> _Body_Image.cshtml
                               +-- application/pdf --> _Body_AppPdf.cshtml
```

---

## 5. Card Reader Partial Dispatcher Architecture

This hierarchical nesting ensures and isolates display responsibilities cleanly:

```
_ContentCard.cshtml              <-- Container Card: Renders card margins, title header, sharing tags, footer metadata
    |_ _ContentBody.cshtml       <-- Engine Loop: Iterates children sequentially by SortOrder and routes layout dispatches
         |_ _Body_TextHtml.cshtml       <-- Output: Injects raw HTML fragments securely via Html.Raw()
         |_ _Body_TextMarkdown.cshtml   <-- Output: Processes Markdown text into HTML at runtime
         |_ _Body_Image.cshtml          <-- Output: Evaluates files (Local, Binary, or Remote) and places layout boundaries
         |_ _Body_AppPdf.cshtml         <-- Output: Embedding PDF components directly inside layouts
         |_ _Body_Default.cshtml        <-- Output: Fallback safe rendering for unknown formats
```

### Dispatch Engine Implementation (`_ContentBody.cshtml`)

Evaluates MIME records sequentially to invoke dedicated rendering engines:

```csharp
@model IEnumerable<ContentBody>

@foreach (var body in Model.OrderBy(b => b.SortOrder))
{
    switch (body.MimeType)
    {
        case "text/html":
            @await Html.PartialAsync("_Body_TextHtml", body)
            break;
        case "text/markdown":
            @await Html.PartialAsync("_Body_TextMarkdown", body)
            break;
        case "image/jpeg":
        case "image/png":
        case "image/gif":
        case "image/webp":
            @await Html.PartialAsync("_Body_Image", body)
            break;
        case "application/pdf":
            @await Html.PartialAsync("_Body_AppPdf", body)
            break;
        default:
            @await Html.PartialAsync("_Body_Default", body)
            break;
    }
}
```

### Structured Formatting via Metadata JSON

Each page and body table record contains unstructured JSON metadata to offer fine-grain layout constraints (such as float parameters, caption descriptions, and structural width overrides) dynamically:

**Example Metadata Document representing an Image Fragment:**
```json
{
  "placement": "right",
  "width": "40%",
  "caption": "Figure 1: Common clinical representation of a PG lesion.",
  "styleClass": "img-thumbnail shadows"
}
```

The dedicated wrapper template (`_Body_Image.cshtml`) extracts these fields dynamically on execution to inject layout-specific CSS boundaries safely:

```csharp
@model ContentBody
@using System.Text.Json

@{
    var meta = JsonSerializer.Deserialize<ImageMetadata>(Model.Metadata ?? "{}");
    var alignClass = meta.Placement == "right" ? "float-end ms-3" : meta.Placement == "left" ? "float-start me-3" : "mx-auto d-block";
}

<div class="image-body-card @alignClass" style="width: @(meta.Width ?? "100%")">
    <img src="@(Model.ExternalFilePath ?? Model.LocalFilePath)" class="img-fluid @meta.StyleClass" alt="@meta.Caption" />
    @if (!string.IsNullOrEmpty(meta.Caption))
    {
        <p class="caption text-muted small text-center mt-1">@meta.Caption</p>
    }
</div>
```

---

## 6. Curations and Workflow Status Lifecycle

Content transitions are governed strictly through structured lookup fields:

| Code (Status) | Name | Interpretation / Access Rules |
| :--- | :--- | :--- |
| **`D`** | Draft | Initial creation phase. Restrained to authors and curators. |
| **`R`** | Review | Complete and locked. Pending review evaluations. |
| **`A`** | Approved | Fully signed off. Available for scheduling releases. |
| **`P`** | Published | Live and active. Servable to public users (`IsPublished = 1`). |
| **`X`** | Archived | Retired. Safe database retention, permanently hidden from layouts. |