# DCMS - Dynamic Content and Menuing System

## Dynamic Routing

This document defines the design, architecture, and specifications for the data-driven **Dynamic Routing** engine in ATPG Phase 2.

---

### Dynamic Routing Overview

Dynamic Routing maps physical requests to logical database layouts at runtime. Rather than hosting decoupled physical Razor sub-directories with separate configuration hooks, the dynamic routing engine parses visitor personas, extracts routing codes from lookup tables, and points consumers directly to context-specific portal models.

---

## 1. Domain Specifications & Design Objectives

1. **Logical Pathway Mapping** - Dynamic URLs resolved at runtime based on the lookup configurations within the database.
2. **Decoupled Contents** - Decoupling the title string from URL rendering eliminates breaking links when titles are modified.
3. **Persona Portal Architectures** - Homebase layout interfaces deliver customized landing experiences (e.g. Patients, Caregivers, Providers, Pharma) out of isolated controllers.
4. **Autonomous Management** - Automated creation and linking of placeholder contents when new menu nodes are generated.
5. **Hybrid Architecture Support** - Accommodates dynamic layouts (Content portal loading) side-by-side with physical static Razor models, redirect pathways, and local anchoring.

---

## 2. Dynamic Routing Relational Schemas

### Table: `MenuItem` (Routing Focus)
Controls parent-child menu trees and specifies active routing targets.

**Schema:**

| Column Name | Data Type | Nullability | Constraints | Purpose / Remarks |
| :--- | :--- | :--- | :--- | :--- |
| `MenuItemID` | int | NOT NULL | PRIMARY KEY | Unique ID of the dynamic menu node. |
| `ParentMenuItemID` | int | NULL | FK -> `MenuItem.MenuItemID` | Parent menu item in the multi-tier navigation chain. |
| `Title` | nvarchar(255) | NOT NULL | - | Label displayed on the UI. |
| `RouteType` | char(1) | NOT NULL | FK -> `RouteType.Code` | Dictates how the route is resolved (V, C, P, R, T). |
| `RouteTarget` | nvarchar(1000)| NOT NULL | - | Target argument dynamically resolved relative to `RouteType`. |
| `VisitorMask` | nvarchar(20) | NOT NULL | DEFAULT 'PCMDV' | Set of custom single-character persona codes allowed to render this node. |
| `SortOrder` | int | NOT NULL | DEFAULT 0 | Display priority ranking inside the sibling subset. |
| `IsActive` | bit | NOT NULL | DEFAULT 1 | Soft-disable switch hiding route nodes from the UI menu. |
| `EffectiveDate` | datetime2(7) | NULL | - | Optional delay date after which the menu route becomes active. |
| `ExpiryDate` | datetime2(7) | NULL | - | Optional expiration date when the menu route automatically deactivates. |

---

## 3. Routing Engine Interpretations

The Dynamic Routing engine evaluates the `RouteType` code against `RouteTarget` to dynamically resolve target URLs:

| RouteType | Description | RouteTarget Format | Resolved URL | Target Engine / Controller Handler |
| :--- | :--- | :--- | :--- | :--- |
| **V** | Visitor Modifier | `{code}` (e.g. `P`) | `/Visitor?v={code}` | Sets persona context inside session backings. |
| **C** | Content Loader | `{menuItemID}` | `/Content?m={menuItemID}` | Resolves companion article inside `Content` matching the ID. |
| **P** | Portal Landing | `{code}` (e.g. `C`) | `/Visitor/{PageName}` | Routes directly to persona-dedicated homebase controllers. |
| **R** | Outer Redirect | `{URL}` | Fully qualified URL | Delegates anchor targets to standard internet redirects. |
| **T** | Page Tag Jump | `#{anchor}` | `#anchor` | Standard document anchor jumping inside client viewport. |

---

## 4. Routing Processing Examples

### Visitor Switch Route (RouteType = V)
- **Database Values**: `Title: "Patient Selection"`, `RouteType: 'V'`, `RouteTarget: "P"`
- **Resulting Element**: `<a href="/Visitor?v=P">Patient Selection</a>`
- **Controller Action**:
  ```csharp
  // Visitor/Index.cshtml.cs OnGet
  public IActionResult OnGet(string v) {
      Session["PersonaCode"] = v;
      return RedirectToPage("/Index");
  }
  ```

### Content Article Loader (RouteType = C)
- **Database Values**: `Title: "Symptoms of PG"`, `RouteType: 'C'`, `RouteTarget: "32"`
- **Resulting Element**: `<a href="/Content?m=32">Symptoms of PG</a>`
- **Controller Action**:
  ```csharp
  // Content/Index.cshtml.cs OnGet
  public IActionResult OnGet(int m) {
      var article = _db.Contents.FirstOrDefault(c => c.MenuItemID == m && c.IsPublished);
      return Page();
  }
  ```

### Portal Homebase Landing (RouteType = P)
- **Database Values**: `Title: "My Caregiver Hub"`, `RouteType: 'P'`, `RouteTarget: "C"`
- **Resulting Element**: `<a href="/Visitor/Caregiver">My Caregiver Hub</a>`
- **Controller Action**: Matches the dedicated physical Razor page `/Visitor/Caregiver.cshtml`.

---

## 5. Persona Portals Architecture

To keep views highly clean, testable, and maintainable, each portal has its own PageModel inheriting from a shared base. This avoids nesting massive conditional switches inside a single Page controller.

```
       +---------------------------------------------+
       |                  HomeBase                   |
       |  - LoadCommonHomeContent()                  |
       |  - FeaturedContent, WelcomeMessage, etc.    |
       +----------------------+----------------------+
                              |
       +----------------------+----------------------+
       |                                             |
+------+------+                              +-------+-----+
| PatientModel|                              |  Caregiver  |
| (Patient)   |                              |  (Caregiver)|
+-------------+                              +-------------+
```

### Shared Controller base: `HomeBase.cs`
Encapsulates central layout operations, rendering widgets, and shared asset loaders:

```csharp
public abstract class HomeBase : PageModel
{
    protected readonly AllThingsPgContext _db;

    public string WelcomeMessage { get; set; }
    public string HeroTitle { get; set; }
    public VisitorType CurrentVisitor { get; set; }

    protected HomeBase(AllThingsPgContext db)
    {
        _db = db;
    }

    protected void LoadCommonHomeContent()
    {
        // Common portal setup logic goes here...
    }
}
```

### Portal Landing Sample implementation: `Patient.cshtml.cs`
Integrates dedicated patient-specific variables directly into the base context:

```csharp
public class PatientModel : HomeBase
{
    public PatientModel(AllThingsPgContext db) : base(db) { }

    public void OnGet()
    {
        CurrentVisitor = VisitorTypes.First(v => v.Code == "P");
        LoadCommonHomeContent();

        HeroTitle = "Patient Portal & Workspace";
        WelcomeMessage = "Your curated informational portal and clinical guide to living with PG.";
        ViewData["Title"] = "Patient Portal";
    }
}
```

---

## 6. Menu UI Rendering Engine (`_Menu.cshtml`)

Dynamic menu layouts evaluate `RouteType` values to generate the proper target URIs:

```csharp
@{
    var href = GetHrefFromMenuItem(child);
}
<a href="@href">@child.Title</a>

@functions {
    public string GetHrefFromMenuItem(MenuItem item)
    {
        return item.RouteType switch
        {
            'V' => $"/Visitor?v={item.RouteTarget}",
            'C' => $"/Content?m={item.RouteTarget}",
            'P' => $"/Visitor/{GetPortalPageName(item.RouteTarget)}",
            'R' => item.RouteTarget,
            'T' => item.RouteTarget,
            _   => "#"
        };
    }

    private string GetPortalPageName(string code)
    {
        return code switch
        {
            "P" => "Patient",
            "C" => "Caregiver",
            "M" => "Provider",
            "D" => "Pharmaceutical",
            "V" => "Visitor",
            _   => "Index"
        };
    }
}
```

---

## 7. Key Design Decisions

### ID-Based Content Keys (`?m={id}`) over Title Slugs
- **Uniqueness Protection:** Multiple separate nodes can feature identical titles (e.g. "Emotional Journey" can live within both Patient and Caregiver navigation folders) under unique MenuItemIDs. Slug patterns are fragile in such situations.
- **Reference Robustness:** If a page label is renamed, all references remain intact inside SQL.
- **Direct Relational Joins:** The MenuItemID acts as a primary key that maps directly to associated `Content` tables without requiring expensive string indexing.

### Isolation of Persona Portal PageModels
- **High Debuggability:** Keeps breakpoint paths isolated in clean, short files like `PatientModel.cs`.
- **Easy Maintenance:** Updates to Patient-specific cards can be made without touching Caregiver code.
- **Performance Optimization:** Bypasses complex switch-blocks on page initializes and lets MVC select native handlers natively.

### Polymorphic target column (`RouteTarget`)
- **Extensibility:** The string wrapper accommodates IDs, absolute URLs, bookmark hashes, and single character codes. Adding future `RouteType` variations requires no database schema changes.

---

## 8. Target Phase 2 Operational Highlights

To implement this design, the system utilizes:
- A custom `HomeBase` interface to serve as a shared Razor controller base class.
- Dynamic layouts configured via `_Menu.cshtml` assessing type switches.
- Automatic routing redirects and fallback parameters embedded into Pagebase models.
