# DCMS - Dynamic Content and Menuing System

## Dynamic Menus

This document outlines the design, architecture, and structural components of the data-driven **Dynamic Menus** subsystem in ATPG Phase 2.

---

### Dynamic Menus Overview

The Dynamic Content and Menuing System (DCMS) delivers a persona-driven navigation experience. Every menu item carries a `VisitorMask` attribute that controls the visibility based on the user type.  The mask controls which items are visible for patients, which items are visible for caregivers and so forth.
Dynamic menus are data-driven, meaning stored in the database and rendered at run-time. Content is also data-driven and closely associated with dynamic menus.  Content is stored in the database and linked to a menu item, so when a patient clicks an item, it displays content specific to a patient.  Content for a caregiver might be different than a patient, or it could be the same.  
By adding a database to Phase 2, web pages can now by dynamic and not static.  This helps to create a highly flexible, scalable, and responsive website designed with the user type in mind.  
Content is curated outside of the development environment by first identifying content, copying it to a staging database, making changes, linking to a menu item, and then publishing the content to the database.  The new content and menu item automatically display without the need to make changes to the website or to do deployments.

---

## 1. VisitorType Mapping

Visitors to the website can select their user type, which adjusts the menu items and content shown.  We can save their selection with their user profile if they register their email address. By default, an unidentified guest receives the Visitor (**`V`**) persona code.

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

| Code | Description | SortOrder | IsDefault |
| :--- | :--- | :--- | :--- |
| P | Patient | 1 | 0 |
| C | Caregiver | 2 | 0 |
| M | Provider | 3 | 0 |
| D | Pharmaceutical | 4 | 0 |
| V | Visitor | 5 | 1 |

---

## 2. Dynamic Routing (RouteType)

The `RouteType` indicates how the routing table processes navigation triggers. It resolves absolute local folders, processes bookmarks, or forwards users directly to logical database layouts.

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

| Code | Name | Folder | Purpose |
| :--- | :--- | :--- | :--- |
| V | Visitor | Visitor | Persona selection / session switching |
| C | Content | Content | Dynamically loads database-curated articles |
| P | Portal | Visitor | Direct route to dedicated portal homepages |
| R | Redirect | NULL | Outer relative or absolute external link |
| T | Tag | NULL | Anchor jump / internal bookmark within page |

---

### Command String URL Routing

Every `MenuItem.Url` is parsed as a complete command string, delegating processing to specific handlers via standard Razor patterns.

**Schema:**

| RouteType | URL Pattern | Example | Handler |
| :--- | :--- | :--- | :--- |
| **V** | `/Visitor?V={code}` | `/Visitor?V=P` | `Visitor/Index` Page Handler |
| **C** | `/Content?m={menuItemID}` | `/Content?m=8` | `Content/Index` Layout Loader |
| **P** | `/Page?p={pageName}` | `/Page?p=Clinic%20Finder` | `Page/Index` Partial Parser |
| **R** | `{full URL}` | `https://external.org` | Standard Browser Redirect |
| **T** | `#{anchor}` | `#research` | Local Client Bookmark |

*Design Decision:* Slug-based URL matches were discarded as menu titles are not globally unique (e.g. `Patient` and `Caregiver` portals both host "Emotional Journey" links with fully decoupled content bodies). Incorporating `MenuItemID` inside the URL (`?m={menuItemID}`) maintains robust, high-performance physical indexing.

---

## 3. Visitor Access System (VisitorMask)

The `VisitorMask` column stores a list of single-character persona codes authorized to view a specific item. Visibility is validated dynamically on load by analyzing if the active persona code is contained within the mask parameter.

**Schema:**

| Mask String | Authorized Users | Logical Behavior |
| :--- | :--- | :--- |
| **PCMDV** | Everyone (equivalent to ALL) | Always visible. |
| **P** | Patients only | Restricts visibility strictly to code 'P'. |
| **PC** | Patients and Caregivers | Matches codes 'P' or 'C'. |
| **MD** | Providers and Pharmaceutical representatives | matches codes 'M' or 'D'. |

---

## 4. Operational Schemas (MenuItem Table)

Houses dynamic parent-child menu trees and maps routing pathways.

### Table: `MenuItem`
Models the hierarchy and maps navigation destinations.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `MenuItemID` | int | NOT NULL | IDENTITY(1,1) PK | Primary key identifier for the menu node. |
| `ParentMenuItemID` | int | NULL | FK -> `MenuItem.MenuItemID` | Identifies parent node. NULL implies top-level tab. |
| `Title` | nvarchar(255) | NOT NULL | - | Text label rendered dynamically inside menu list items. |
| `RouteType` | char(1) | NOT NULL | FK -> `RouteType.Code` | Dictates the routing execution strategy (e.g., Portal, Content). |
| `Url` | nvarchar(1000) | NOT NULL | - | Destination path context of the item. |
| `VisitorMask` | nvarchar(20) | NOT NULL | DEFAULT 'PCMDV' | Bit-mask character segment validating persona discovery (e.g. 'PC'). |
| `SortOrder` | int | NOT NULL | DEFAULT 0 | Ordering index within parent scope. |
| `IsActive` | bit | NOT NULL | DEFAULT 1 | Soft-delete switch hiding items when inactive. |
| `CreatedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit creation timestamp registry. |
| `ModifiedDate` | datetime2(7) | NOT NULL | DEFAULT sysdatetime() | Audit updating timestamp registry. |

**Indexes:**
*   `IX_MenuItem_ParentMenuItemID` (Non-clustered Index)
*   `IX_MenuItem_RouteType` (Non-clustered Index)
*   `IX_MenuItem_IsActive_SortOrder` (Performance Index for Layout Queries)

---

## 5. View Definitions (vw_MenuItemContent View)

Joins MenuItem to itself (parent/child) and to Content descriptors, resolving content allocations directly.

### View: `vw_MenuItemContent`

**Schema:**

| Column Name | Data Type | Source Table | Purpose / Remarks |
| :--- | :--- | :--- | :--- |
| `MenuItemID` | int | `MenuItem` (cm) | Identifies child menu node primary key. |
| `ParentMenuItemID` | int | `MenuItem` (cm) | Identifies parent menu node. |
| `Title` | nvarchar(255) | `MenuItem` (cm) | Display label of the child menu item. |
| `RouteType` | char(1) | `MenuItem` (cm) | Routing strategy reference code of the child. |
| `Url` | nvarchar(1000) | `MenuItem` (cm) | Destination path context of the child. |
| `VisitorMask` | nvarchar(20) | `MenuItem` (cm) | Authorized personas mask string of the child. |
| `SortOrder` | int | `MenuItem` (cm) | Hierarchy sorting key of the child. |
| `IsActive` | bit | `MenuItem` (cm) | Soft-delete status flag of the child. |
| `IsParent` | int (derived) | `MenuItem` (cm) | Expressions check showing if item has no parent. |
| `ParentTitle` | nvarchar(255) | `MenuItem` (pm) | Menu title label value of parent item. |
| `ParentVisitorMask` | nvarchar(20) | `MenuItem` (pm) | Authorized personas mask string of the parent. |
| `ChildContentID` | int | `Content` (cc) | Descriptor card key associated with child. |
| `ChildContentType` | char(3) | `Content` (cc) | Core presentation structure layout of child content. |
| `ChildContentDescription`| nvarchar(500) | `Content` (cc)| User-friendly description of child content. |
| `ChildIsPublished` | bit | `Content` (cc) | Toggle representing child visibility state. |
| `ParentContentID` | int | `Content` (pc) | Descriptor card key associated with parent. |
| `ParentContentType` | char(3) | `Content` (pc) | Core presentation structure layout of parent content. |
| `ParentContentDescription`| nvarchar(500) | `Content` (pc)| User-friendly description of parent content. |
| `ParentIsPublished` | bit | `Content` (pc) | Toggle representing parent visibility state. |

**SQL Definition:**

```sql
SELECT
    cm.MenuItemID, cm.ParentMenuItemID, cm.Title,
    cm.RouteType, cm.Url, cm.VisitorMask, cm.SortOrder, cm.IsActive,
    CASE WHEN cm.ParentMenuItemID IS NULL THEN 1 ELSE 0 END AS IsParent,
    pm.Title            AS ParentTitle,
    pm.VisitorMask      AS ParentVisitorMask,
    cc.ContentID        AS ChildContentID,
    cc.ContentType      AS ChildContentType,
    cc.Description      AS ChildContentDescription,
    cc.IsPublished      AS ChildIsPublished,
    pc.ContentID        AS ParentContentID,
    pc.ContentType      AS ParentContentType,
    pc.Description      AS ParentContentDescription,
    pc.IsPublished      AS ParentIsPublished
FROM MenuItem cm
LEFT JOIN MenuItem pm ON pm.MenuItemID = cm.ParentMenuItemID
LEFT JOIN Content  cc ON cc.MenuItemID = cm.MenuItemID
LEFT JOIN Content  pc ON pc.MenuItemID = pm.MenuItemID
```

---

## 6. Code Architecture & Pipeline

### Rendering Pipeline

Describes the chronological life-cycle rendering navigation elements at run-time:

```
PageBase.OnPageHandlerExecuting
    +-- VisitorTypes loaded    (lazy, cached in backing field)
    +-- RouteTypes loaded      (lazy, cached in backing field)
    +-- MenuTree loaded        (AsNoTracking, active items, sorted)
    +-- CurrentVisitor resolved from session -> PersonaSessionKey

_Layout.cshtml
    +-- Persona tabs  -> one per VisitorType, active tab highlighted orange
    +-- _Menu.cshtml partial  (receives MenuViewModel)

_Menu.cshtml
    +-- GetTree()          -> IMemoryCache keyed by persona code (30 min TTL)
    +-- IsVisibleTo(code)  -> VisitorMask.Contains(code)
    +-- GetUrl()           -> returns Url as-is (complete command string)
```

### Key Files

| File | Type | Responsibility |
| :--- | :--- | :--- |
| `PageBase.cs` | Controller / Infrastructure | Lazy lookup tables, persona session caching, menu tree management. |
| `MenuItem.Extensions.cs` | Domain Extensions | Implements `GetUrl()` logic and active `IsVisibleTo(code)` calculations. |
| `MenuViewModel.cs`| View DTO | Core Data Transfer Object mapped into navigation views (`_Menu.cshtml`). |
| `Visitor/Index.cshtml.cs` | Page Controller | Evaluates switches (`?V=`) and caches selections inside session variables. |
| `Content/Index.cshtml.cs` | Page Controller | Evaluates keys (`?m=`) parsing specific ContentBody segments. |
| `Page/Index.cshtml.cs` | Page Controller | Parses static folder parameters (`?p=`) and returns fallback pages. |

---

## 7. Operational Scripts and Seeding Procedures

Seeding menu architecture is loaded by executing the stored procedures listed below.

### Stored Procedure: `Insert_MenuItem_Parent`
Registers absolute parent tab parameters and optional placeholder content rows.

**SQL Definition:**

```sql
exec Insert_MenuItem_Parent
    @MenuItemID        int output,           -- ID of new MenuItem
    @ContentID         int output,           -- ID of new Content placeholder
    @Title             nvarchar(100),        -- MenuItem title
    @RouteType         char(1),              -- V / C / P / R / T
    @Url               nvarchar(200) = null, -- null = auto-generate from RouteType + Title
    @VisitorMask       varchar(10)   = 'ALL',
    @SortOrder         int           = 0,    -- auto-increment if 0
    @IsActive          bit           = 1,
    @NormalizeTitle    bit           = 1,    -- normalizes title into URL segment
    @InsertPlaceholder bit           = 1,    -- creates a Content placeholder row
    @IsDebug           bit           = 0
```

### Stored Procedure: `Insert_MenuItem_Child`
Constructs a sub-directory node linked to its parent, with optional inheritance of parent specifications.

**SQL Definition:**

```sql
exec Insert_MenuItem_Child
    @MenuItemID        int output,           -- ID of new MenuItem
    @ContentID         int output,           -- ID of new Content placeholder
    @ParentMenuItemID  int,                  -- ID of parent
    @Title             nvarchar(100),
    @RouteType         char(1) = null,       -- null = inherit from parent
    @Url               nvarchar(200) = null, -- null = auto-generate from RouteType folder + Title
    @VisitorMask       varchar(10) = 'ALL',
    @SortOrder         int = 0,              -- auto-increment within parent
    @IsActive          bit = 0,
    @NormalizeTitle    bit = 1,
    @InsertPlaceholder bit = 1,
    @IsDebug           bit = 0
```

### Script: `Populate_MenuItems` (Sample Excerpt)
Initializes standard Phase 2 navigational architecture tree structures.

**SQL Seeding Scripts:**

```sql
-- Example: Welcome Menu
exec Insert_MenuItem_Parent  @parentMenuItemID output, @parentContentID output,
     @Title = 'Welcome', @RouteType = 'V'

exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Patient'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Caregiver'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Provider'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Pharmaceutical'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Visitor'

-- Example: Persona-specific menu (Being a Patient - visible to P only)
exec Insert_MenuItem_Parent  @parentMenuItemID output, @parentContentID output,
     @Title = 'Being a Patient', @RouteType = 'C', @VisitorMask = 'P'

exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Emotional Journey',    @VisitorMask = 'P'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Living with the Pain', @VisitorMask = 'P'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Success Stories',      @VisitorMask = 'P'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Testimonials',         @VisitorMask = 'P'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Being a Warrior',      @VisitorMask = 'P'
exec Insert_MenuItem_Child   @childMenuItemID output, @childContentID output, @parentMenuItemID, 'Getting Help',         @VisitorMask = 'P'
```

*Auto-generation Remarks:*
*   **URL Parameterization:** When `@Url` parameter is null, the procedures construct path layouts matching `RouteType.Folder + normalized title` context (e.g. `/{Folder}?m={MenuItemID}`).
*   **Sort Order Evaluation:** Zero-based `@SortOrder` values auto-allocate next sequential indices within regional scope.
*   **Placeholder Creation:** When `@InsertPlaceholder = 1`, creates a companion record inside `Content` mapped to `MenuItemID` to accommodate future content curation.

---

## 8. Initial Menu Structure (POC Tree)

Standard tree representation outlining target routing, visitor mask permissions, and generated Uniform Resource Indicators (URIs):

```
Title                           RT   Mask  URL
-----------------------------------------------------------------------------
Welcome                         V    ALL   /visitor
    Patient                     V    ALL   /visitor?V=P
    Caregiver                   V    ALL   /visitor?V=C
    Provider                    V    ALL   /visitor?V=M
    Pharmaceutical              V    ALL   /visitor?V=D
    Visitor                     V    ALL   /visitor?V=V

About PG                        C    ALL   /content?m={id}
    What is PG?                 C    ALL   /content?m={id}
    Clinical                    C    ALL   /content?m={id}
        Symptoms                C    ALL   /content?m={id}
        Comorbidities           C    ALL   /content?m={id}
        Diagnosis               C    ALL   /content?m={id}
        Treatment               C    ALL   /content?m={id}
        Wound Care              C    ALL   /content?m={id}
        Pain Management         C    ALL   /content?m={id}
        Outcomes                C    ALL   /content?m={id}
    Living With PG              C    ALL   /content?m={id}
        Emotional Journey       C    ALL   /content?m={id}
        Loss of Mobility        C    ALL   /content?m={id}
        Loss of Identity        C    ALL   /content?m={id}
        Avoiding Mistakes       C    ALL   /content?m={id}
        Managing Disability     C    ALL   /content?m={id}

Being a Patient                 C    P     /content?m={id}
    Emotional Journey           C    P     /content?m={id}
    Living with the Pain        C    P     /content?m={id}
    Success Stories             C    P     /content?m={id}
    Testimonials                C    P     /content?m={id}
    Being a Warrior             C    P     /content?m={id}
    Getting Help                C    P     /content?m={id}

Being a Caregiver               C    C     /content?m={id}
    Emotional Journey           C    C     /content?m={id}
    Living with the Pain        C    C     /content?m={id}
    Success Stories             C    C     /content?m={id}
    Testimonials                C    C     /content?m={id}
    Supporting a Warrior        C    C     /content?m={id}
    Getting Help                C    C     /content?m={id}

Provider Information            C    M     /content?m={id}
    Patient Registry            C    M     /content?m={id}
    Early Diagnosis             C    M     /content?m={id}
    Treating the Wound          C    M     /content?m={id}
    Treating the Pain           C    M     /content?m={id}
    Latest Research             C    M     /content?m={id}
    Clinical Trials             C    M     /content?m={id}

Pharmaceutical Information      C    D     /content?m={id}
    Current Treatments          C    D     /content?m={id}
    FDA Approved Drugs          C    D     /content?m={id}
    Latest Research             C    D     /content?m={id}
    Clinical Trials             C    D     /content?m={id}
    Fundraising                 C    D     /content?m={id}

Understanding PG                C    V     /content?m={id}
    Emotional Journey           C    V     /content?m={id}
    Living with the Pain        C    V     /content?m={id}
    Success Stories             C    V     /content?m={id}
    Testimonials                C    V     /content?m={id}
    Current Treatments          C    V     /content?m={id}

Resources                       C    ALL   /content?m={id}
    News and Events             C    ALL   /content?m={id}
    Research Studies            C    ALL   /content?m={id}
    Clinical Trials             C    ALL   /content?m={id}
    Clinic Finder               P    ALL   /page?p=Clinic%20Finder
    Picture Gallery             C    ALL   /content?m={id}
    Support Groups              C    ALL   /content?m={id}

Fundraising                     C    ALL   /content?m={id}
    Why Donate                  C    ALL   /content?m={id}
    Fundraising Events          C    ALL   /content?m={id}
    Corporate Sponsorships      C    ALL   /content?m={id}
    Volunteer Opportunities     C    ALL   /content?m={id}
    Get Involved                C    ALL   /content?m={id}
    Make a Donation             C    ALL   /content?m={id}

Our Organization                C    ALL   /content?m={id}
    Mission Statement           C    ALL   /content?m={id}
    Board of Directors          C    ALL   /content?m={id}
    Partners                    C    ALL   /content?m={id}
    Contact Us                  C    ALL   /content?m={id}
```

---

## 9. Email Capture & Persona Restoration

### Feature Concept & Design
1. **Persona Selection Trigger:** Subsequent to a guest manually selecting/changing their persona code, an optional, non-blocking email collection prompt is presented.
2. **Schema Definition (`Profile` Table):**
   - `Email` (nvarchar(255), PRIMARY KEY)
   - `PersonaCode` (char(1), NOT NULL, FK -> `VisitorType.Code`)
   - `CreatedDate` (datetime2, NOT NULL, DEFAULT sysdatetime())
3. **Session Rehydration:** Upon returning to the site, if an email exists/is resolved, the mapped `PersonaCode` is automatically loaded into active session memory (`PageBase.PersonaSessionKey`), bypassing the default Visitor (`V`) fallback route.
4. **Access Security:** Explicit login flows are reserved strictly for highly protected action items, keeping standard content customization Frictionless (No password require to toggle visibility views).