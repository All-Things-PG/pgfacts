---
layout: page
title: Dynamic Menus
updated: 2026-09-18
---

<a id="top"></a>

# DCMS - Dynamic Content and Menuing System

## Dynamic Menus

This document explains how the proof-of-concept menu is loaded from the `AllThingsPG` database and displayed through the shared Razor partial view named `_Menu.cshtml`.

The menu is called a [dynamic menu](#glossary) because its labels, [hierarchy](#glossary), visibility, order, and links come from [database](#glossary) records. The application does not need a separate hard-coded `<li>` element for every menu entry. When the database records change, the menu can change the next time the application loads the records.

---

## Overview: Why Use Dynamic Menus?

A static menu can provide reliable navigation, but a dynamic menu can provide a more personal and useful experience. AllThingsPG is intended to serve several audiences, including patients, caregivers, medical professionals, pharmaceutical representatives, and general visitors. Those audiences may need different information, different levels of detail, and different paths through the site.

The first step is to identify who is visiting. Once a visitor selects, or is otherwise associated with, a [visitor type](#glossary), the site can tailor both the **navigation** and the **content** shown to that audience. A patient may need practical information about living with the condition, a caregiver may need guidance on supporting someone else, and a medical professional may need more detailed clinical or diagnostic information. Pharmaceutical representatives may need a different set of resources again.

Each [menu item](#glossary) can be associated with its own content. The same subject can therefore appear more than once in the database with the same visible `Title`, while each record points to a different audience, location in the menu, or content document. The `VisitorMask` determines which visitor types can see each item:

```text
Current visitor: Medical professional
    "Diagnosis" -> detailed clinical diagnosis content

Current visitor: Caregiver
    "Diagnosis" -> caregiver-oriented explanation

Current visitor: Patient
    "Diagnosis" -> patient-oriented explanation
```

The title may be the same because it is familiar and meaningful to every audience. The underlying `MenuItemID`, [visitor mask](#glossary), [URL](#glossary), and associated content distinguish the records. This lets the application reuse clear navigation language without forcing every audience to receive the same material.

Dynamic menus therefore support two related goals:

1. **Enhanced user experience:** visitors see navigation that is relevant to their role instead of a large, one-size-fits-all menu.
2. **Audience-specific content:** each visible menu item can lead to content selected for that audience, including more specialized or detailed information where appropriate.

The menu is not the only part of this design, but it is the visible point where audience-aware navigation begins. The database stores the relationships, `VisitorMask` controls visibility, and the shared [`_Menu.cshtml`](#glossary) [partial view](#glossary) renders the appropriate result.

This approach also keeps the application flexible. Adding or changing audience-specific navigation and content can often be done by changing data and content records rather than rewriting the menu's HTML structure.

---

The menu system has four main parts:

1. The [`MenuItem`](#glossary) table stores the menu records.
2. [`PageBase`](#glossary) loads active menu records for a request.
3. [`_Layout.cshtml`](#glossary) prepares a [`MenuViewModel`](#glossary) and calls `_Menu.cshtml`.
4. `_Menu.cshtml` filters, orders, and recursively renders the menu hierarchy.

---

## 1. What “Dynamic Menu” Means

A traditional static menu might contain the complete menu directly in a Razor file:

```html
<ul>
    <li><a href="/Visitor?V=Patient">Patient</a></li>
    <li><a href="/Visitor?V=Caregiver">Caregiver</a></li>
</ul>
```

That approach requires a developer to edit the page whenever a menu item is added, removed, renamed, reordered, or redirected.

The proof-of-concept menu instead obtains the same information from `MenuItem` rows:

| MenuItem value | What it controls |
| :--- | :--- |
| `Title` | Text displayed to the visitor |
| `ParentMenuItemID` | Where the item appears in the hierarchy |
| `Url` | Address followed when the item is selected |
| [`RouteType`](#glossary) | Application classification for the destination |
| `VisitorMask` | Visitor types allowed to see the item |
| [`SortOrder`](#glossary) | Position among items with the same parent |
| `IsActive` | Whether the item is available to the menu |

The database supplies the menu data. Razor supplies the HTML structure.

---

## 2. The `MenuItem` Table

The runtime menu is stored in `dbo.MenuItem`.

| Column | Meaning |
| :--- | :--- |
| `MenuItemID` | Unique identifier for the menu record |
| `ParentMenuItemID` | The identifier of this item's parent; `NULL` means top-level |
| `Title` | Label shown to the visitor |
| `Url` | Complete destination address |
| `RouteType` | One-character classification such as Visitor, Content, Page, or Redirect |
| `VisitorMask` | Concatenated visitor codes allowed to see the item |
| `SortOrder` | Relative order among items with the same parent |
| `IsActive` | Soft on/off switch for the menu item |
| `CreatedDate` | Creation timestamp |
| `ModifiedDate` | Last modification timestamp |

The self-reference through `ParentMenuItemID` creates the tree. A record with no parent is a top-level menu item. A record whose parent is item `8` is displayed underneath item `8`.

### Example hierarchy

```text
Welcome
    Patient
    Caregiver
    Provider

About PG
    What is PG
    Clinical Topics
        Symptoms
        Diagnosis
        Treatment
```

The hierarchy is stored as IDs, not as indentation or hard-coded HTML.

---

## 3. Loading the Menu from the Database

Pages that use the shared [layout](#glossary) inherit from `PageBase`. `PageBase` receives an `AllThingsPgContext`, which is the [Entity Framework Core](#glossary) connection to the database.

Before a page handler runs, `PageBase.OnPageHandlerExecuting` prepares shared information:

```csharp
public override void OnPageHandlerExecuting(PageHandlerExecutingContext context)
{
    _ = VisitorTypes;
    _ = RouteTypes;
    MenuTree = BuildMenuTree();
    base.OnPageHandlerExecuting(context);
}
```

The menu query is:

```csharp
protected List<MenuItem> BuildMenuTree()
{
    return _db.MenuItems
        .AsNoTracking()
        .Where(m => m.IsActive)
        .OrderBy(m => m.SortOrder)
        .ToList();
}
```

In plain language, the query:

1. Reads from `MenuItem`.
2. Uses `AsNoTracking()` because the menu is being displayed, not edited in this request.
3. Keeps only records where `IsActive` is true.
4. Loads the records into `MenuTree`.
5. Sorts the initial list by `SortOrder`.

The parent-child relationships are not flattened into separate HTML rows by the database. The complete active set is loaded into memory, and `_Menu.cshtml` uses `ParentMenuItemID` to build the visible [hierarchy](#glossary).

---

## 4. Passing Menu Data to the Layout

The shared layout is:

```text
Pages/Shared/_Layout.cshtml
```

The layout expects the current page model to be a `PageBase`, because it needs access to the shared menu and visitor information:

```csharp
var model = (PageBase)ViewContext.ViewData.Model;
```

It then creates a `MenuViewModel`:

```csharp
var menuViewModel = new MenuViewModel
{
    MenuTree = model.MenuTree,
    CurrentVisitor = model.CurrentVisitor,
    RouteTypes = model.RouteTypes,
    VisitorTypes = model.VisitorTypes
};
```

`MenuViewModel` is a small object that carries the information the partial needs:

| Property | Purpose |
| :--- | :--- |
| `MenuTree` | Active menu records loaded from the database |
| `CurrentVisitor` | The visitor persona currently selected |
| `RouteTypes` | Route-type lookup values available to the page |
| `VisitorTypes` | Visitor-persona lookup values used by the layout |

The layout displays the visitor-persona tabs and then calls the menu partial:

```cshtml
@await Html.PartialAsync("_Menu", menuViewModel)
```

This means the menu is part of the common page frame. Pages do not each need to repeat the menu markup.

---

## 5. The `_Menu.cshtml` Partial

The partial is located at:

```text
Pages/Shared/_Menu.cshtml
```

It receives a `MenuViewModel`:

```cshtml
@model Proof_of_Concept.Models.MenuViewModel
```

The partial performs four jobs:

1. Obtains the menu records.
2. Finds the top-level records.
3. Filters records for the current visitor.
4. Recursively renders children and grandchildren.

The resulting HTML is an unordered list:

```html
<ul class="pg-nav-links">
    ...
</ul>
```

The CSS classes control appearance. The partial controls which items exist and how they are nested.

---

## 6. Visitor Filtering

The current visitor is obtained by `PageBase.CurrentVisitor`. The selected visitor code is stored in [session](#glossary) under `PersonaCode`. If there is no valid session value, `PageBase` falls back to the lookup row whose `IsDefault` value is true.

The menu extension method checks a visitor mask:

```csharp
public bool IsVisibleTo(string visitorCode) =>
    !string.IsNullOrEmpty(VisitorMask) &&
    !string.IsNullOrEmpty(visitorCode) &&
    VisitorMask.Contains(visitorCode);
```

The mask is a compact list of allowed visitor codes:

| VisitorMask | Meaning |
| :--- | :--- |
| `PCMDVR` | Visible to all current visitor types |
| `P` | Visible to Patients |
| `PC` | Visible to Patients and Caregivers |
| `MD` | Visible to Providers and Pharmaceutical visitors |

For example, if the current visitor code is `P`, an item with mask `PCMDVR` is visible and an item with mask `C` is not.

The current implementation uses `string.Contains`. Because visitor codes are single characters, each code is treated as one character in the mask.

---

## 7. Finding Top-Level Items

Top-level items have no parent:

```csharp
GetTree()
    .Where(m => m.ParentMenuItemId == null &&
                m.IsVisibleTo(visitor!.Code))
    .OrderBy(m => m.SortOrder)
```

Each qualifying record becomes an item in the main navigation bar.

The partial then checks whether the item has visible children:

```csharp
var hasChildren = GetTree().Any(
    m => m.ParentMenuItemId == item.MenuItemId &&
         m.IsVisibleTo(visitor!.Code));
```

If children exist, the top-level item is displayed as a parent label:

```html
<span class="pg-nav-parent">About PG</span>
```

If there are no children, it is displayed as a link:

```html
<a href="/somewhere">Somewhere</a>
```

This allows a parent menu item to act as a category heading while child records provide the selectable destinations.

---

## 8. Rendering Child Menus Recursively

Child records are found by matching their [`ParentMenuItemID`](#glossary) to the current parent's `MenuItemId`:

```csharp
var children = items
    .Where(m => m.ParentMenuItemId == parentId &&
                m.IsVisibleTo(visitor!.Code))
    .OrderBy(m => m.SortOrder)
    .ToList();
```

The partial renders each child as a link:

```cshtml
<ul class="pg-submenu">
    @foreach (var child in children)
    {
        <li>
            <a href="@child.GetUrl()">@child.Title</a>
            @{ RenderChildren(items, child.MenuItemId); }
        </li>
    }
</ul>
```

The call to `RenderChildren` inside itself is [recursive rendering](#glossary). It means:

1. Render this item's children.
2. For each child, look for grandchildren.
3. Continue until an item has no children.

This is what allows the same code to display a menu with one level or several levels.

---

## 9. Building the Link

The `MenuItem.Extensions.cs` file contains the [`GetUrl()`](#glossary) URL helper:

```csharp
public string GetUrl() =>
    !string.IsNullOrEmpty(Url)
        ? Url
        : throw new InvalidOperationException(
            $"MenuItem '{Title}' (ID: {MenuItemId}) has no Url defined.");
```

The current proof of concept stores the complete URL in `MenuItem.Url`. `GetUrl()` returns that URL without rebuilding it from `RouteType`.

Examples from the current data include:

| RouteType | Example URL | Behavior represented |
| :---: | :--- | :--- |
| `V` | `/visitor?v=Patient` | Selects a visitor type |
| `C` | `/content?c=about%20pg` | Requests content |
| `P` | `/page?p=clinicfinder.html` | Requests a page |
| `R` | `/redirect?r=https://globalskin.org/` | Requests a redirect |

`RouteType` is available as metadata for the destination behavior, but URL construction is not currently performed by `GetUrl()`.

If `Url` is empty, the helper throws an exception instead of silently creating a broken link. This makes missing menu data visible during development.

---

## 10. Caching the Menu

The partial uses [`IMemoryCache`](#glossary) and a [cache](#glossary):

```csharp
List<MenuItem> GetTree() =>
    MemoryCache.GetOrCreate("MenuTree_" + visitor?.Code, entry =>
    {
        entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(30);
        return Model.MenuTree?.ToList() ?? new List<MenuItem>();
    })!;
```

The cache key includes the visitor code:

```text
MenuTree_P
MenuTree_C
MenuTree_V
```

The intended result is a separate cached menu set for each visitor persona, with a thirty-minute expiration. Caching reduces repeated preparation of the same menu data during that period.

The cache stores the `MenuTree` supplied by the current page model. The actual database query occurs in `PageBase`; the partial's cache does not query the database by itself.

When menu records are changed, an already-cached menu can remain visible until its cache entry expires or is explicitly removed. A production implementation should decide how menu updates invalidate or refresh cached entries.

---

## 11. End-to-End Processing Flow

The complete current flow is:

```text
Browser requests a Razor Page
        |
        v
PageModel is created
        |
        v
PageBase loads visitor and route lookup data
        |
        v
PageBase queries active MenuItem records
        |
        v
PageBase stores records in MenuTree
        |
        v
_Layout.cshtml receives the PageBase model
        |
        v
_Layout.cshtml creates MenuViewModel
        |
        v
_Layout.cshtml invokes _Menu.cshtml
        |
        v
_Menu.cshtml caches the supplied tree
        |
        v
_Menu.cshtml filters by VisitorMask
        |
        v
_Menu.cshtml orders by SortOrder
        |
        v
_Menu.cshtml recursively renders parent and child <ul>/<li> elements
        |
        v
Browser receives the completed page
```

### Example: Patient visitor

1. The visitor selects Patient.
2. The visitor page resolves the Patient record.
3. The selected code is stored in session.
4. `PageBase` loads active `MenuItem` records.
5. `_Menu.cshtml` uses visitor code `P`.
6. Items whose `VisitorMask` contains `P` remain visible.
7. The remaining records are grouped by `ParentMenuItemID`.
8. Each group is ordered by `SortOrder`.
9. The partial writes the menu HTML.
10. The visitor sees the Patient-appropriate navigation.

---

## 12. Responsibilities by File

| File | Responsibility |
| :--- | :--- |
| `Models/MenuItem.cs` | Entity Framework model representing a database menu row |
| `Models/MenuItem.Extensions.cs` | Returns the stored URL and evaluates visitor visibility |
| `Models/MenuViewModel.cs` | Carries menu, visitor, route, and persona data into the partial |
| `Models/AllThingsPGContext.cs` | Maps the application to the database and exposes `MenuItems` |
| `Pages/Page/PageBase.cs` | Loads lookup data, resolves the current visitor, and queries active menu rows |
| `Pages/Shared/_Layout.cshtml` | Builds the view model and invokes the shared menu partial |
| `Pages/Shared/_Menu.cshtml` | Filters, orders, nests, caches, and renders menu records |
| `wwwroot/css/site.css` | Site styling used by the rendered menu |
| `wwwroot/css/pg-components.css` | Component styling used by the rendered menu and page layout |

---

## 13. Current Design Boundaries

The current proof of concept intentionally keeps responsibilities separate:

| Responsibility | Current implementation |
| :--- | :--- |
| Store menu definitions | `dbo.MenuItem` |
| Load active menu records | `PageBase.BuildMenuTree()` |
| Remember selected visitor | ASP.NET Core session |
| Decide visitor visibility | `MenuItem.IsVisibleTo()` |
| Build the hierarchy | `_Menu.cshtml` and `ParentMenuItemID` |
| Order siblings | `_Menu.cshtml` and `SortOrder` |
| Produce the destination link | `MenuItem.GetUrl()` |
| Render common navigation on pages | `_Layout.cshtml` and `_Menu.cshtml` |

The partial does not create content, query content documents, or decide how a destination page processes its URL. It only displays the menu and emits the stored link.

---

## 14. Future Considerations

These are design considerations rather than claims about the current implementation:

* A centralized route service could build URLs from `RouteType` and a separate route target.
* Menu cache invalidation could refresh cached trees immediately after an administrative change.
* A dedicated menu service could move database loading out of `PageBase`.
* A view model could contain an already-built tree if the application needs more complex rendering rules.
* URL generation could use framework link helpers when route parameters need encoding or validation.
* Additional safeguards could detect cycles in parent-child data before recursive rendering.

These changes would extend the current approach; they are not required to understand how the current proof-of-concept menu works.

---

## Summary

The dynamic menu is a database-backed navigation component. `PageBase` loads active `MenuItem` rows into `MenuTree`, `_Layout.cshtml` packages that data into a `MenuViewModel`, and `_Menu.cshtml` renders the visible hierarchy.

The partial uses the current visitor code to apply `VisitorMask`, uses `ParentMenuItemID` to find children, uses `SortOrder` to arrange siblings, and uses `GetUrl()` to create links. The result is a menu that can be changed through data rather than by rewriting the page's HTML.

---

## Glossary

[Return to top](#top)

| Term | Non-programmer explanation |
| :--- | :--- |
| Active menu item | A menu record whose `IsActive` value is true, meaning it is currently eligible to appear in the menu. |
| Application | The running website and the code that receives requests, loads information, and produces responses. |
| Cache | Temporary stored information used so the application does not have to prepare or retrieve the same information repeatedly. |
| Child menu item | A menu record displayed underneath another menu item. Its `ParentMenuItemID` points to the parent record. |
| Content | Information shown to a visitor, such as an article, diagnosis explanation, image, or other material associated with a menu item. |
| Database | An organized storage system containing the records used by the application, including menu, visitor, route, and content information. |
| Dynamic menu | A menu whose labels, hierarchy, visibility, order, and links are supplied by data rather than being written as fixed HTML. |
| Entity Framework Core | A .NET library that lets C# code read database records through objects and queries. |
| Hierarchy | The parent-and-child arrangement that determines which menu items appear beneath other items. |
| `IMemoryCache` | The .NET service used by the partial to temporarily retain a menu tree in the web application's memory. |
| Layout | A shared page template that provides common elements such as the header, visitor tabs, menu, and page body. |
| `MenuItem` | One database record representing a possible navigation entry. It contains the title, parent, URL, visibility mask, order, and active status. |
| `MenuItemID` | The unique number identifying one menu record. |
| `MenuTree` | The in-memory collection of active `MenuItem` records passed from the page model to the layout and menu partial. |
| `MenuViewModel` | A small C# object that carries menu and visitor information into `_Menu.cshtml`. |
| Parent menu item | A menu record that can contain child records beneath it. A top-level parent has no `ParentMenuItemID`. |
| Partial view | A reusable Razor template, such as `_Menu.cshtml`, that can be inserted into a layout or page. |
| Persona | The visitor's selected audience or role, such as Patient, Caregiver, Provider, Pharmaceutical, or Visitor. |
| `PageBase` | The shared page-model class that loads common lookup data, resolves the current visitor, and loads active menu records. |
| `ParentMenuItemID` | The database value connecting a child menu item to its parent. A blank value means the item is at the top level. |
| Recursive rendering | A technique where the menu renderer calls the same child-rendering logic again for each child, allowing multiple levels of nested menus. |
| `RouteType` | A database classification describing the general kind of destination, such as Visitor, Content, Page, or Redirect. |
| `SortOrder` | The number used to arrange menu items among other items with the same parent. |
| Session | Short-lived server-side information associated with one visitor's browser. This proof of concept uses it to remember the selected visitor code. |
| `Url` | The web address stored on a menu item and followed when that link is selected. |
| Visitor code | The short code representing a visitor type, such as `P` for Patient or `C` for Caregiver. |
| Visitor mask | A compact string listing the visitor codes allowed to see a menu item, such as `PC` or `PCMDVR`. |
| Visitor type | A database lookup record describing an audience category and its display order. |
| `_Layout.cshtml` | The shared Razor layout that prepares the menu view model and invokes `_Menu.cshtml`. |
| `_Menu.cshtml` | The shared Razor partial that filters, orders, nests, caches, and renders the menu records as HTML. |
| `GetUrl()` | The helper that returns the stored URL for a menu item and reports an error when the URL is missing. |
