<a id="top"></a>

# DCMS - Dynamic Routing

This document is the master reference for DCMS-specific routing. It explains how DCMS uses standard ASP.NET Core Razor Pages as the physical processing layer while the database determines what each menu item means and where it should go.

ASP.NET Core still performs the normal work:

1. The browser requests a URL.
2. Razor Pages routing finds a physical page.
3. The PageModel processes the request.
4. The page renders a response or redirects the browser.

DCMS adds database-driven meaning to the request. The database supplies the menu item, route type, and route target. The route-specific `Index` page interprets that target.

---

## Overview: Why DCMS Uses Dynamic Routing

AllThingsPG is intended to serve several audiences, including patients, caregivers, medical professionals, pharmaceutical representatives, and general visitors. The same visible title may need to lead to different content for different audiences.

DCMS keeps navigation and content relationships in the database instead of hard-coding every destination in Razor markup. A `MenuItem` can contain:

* a visible title;
* a visitor mask controlling who can see it;
* a route type describing the kind of destination;
* a route target describing the selected destination;
* a parent and sort order;
* an active state;
* an associated content document.

The application provides a small number of stable processing pages:

```text
/Visitor/Index
/Content/Index
/Page/Index
/Redirect/Index
/Register/Index
```

The database determines which one is used and what it should process. This supports a thin web application: adding or changing many menu destinations can be a data change rather than a new Razor Page.

The standard DCMS URL pattern is:

```text
/{RouteFolder}/Index?target={value}
```

Examples:

```text
/Visitor/Index?target=Patient
/Content/Index?target=2
/Page/Index?target=ClinicFinder
/Redirect/Index?target=https%3A%2F%2Fglobalskin.org%2F
```

The pattern is always the same. The meaning of `target` depends on the route type.

---

## 1. Standard ASP.NET Core Foundation

DCMS does not replace ASP.NET Core routing. It uses ordinary Razor Pages as controlled entry points.

For example:

```text
Pages/Visitor/Index.cshtml
Pages/Visitor/Index.cshtml.cs
```

The explicit URL is:

```text
/Visitor/Index
```

ASP.NET Core can also conventionally resolve that page as `/Visitor`, but DCMS uses the explicit `/Visitor/Index` form to keep every route consistent and unambiguous.

The PageModel can read the common `target` query-string value:

```csharp
public IActionResult OnGet(string? target)
{
    // Interpret target according to this page's route type.
    return Page();
}
```

The page does not assume that every target is the same kind of data. `Visitor/Index` interprets a visitor destination, while `Content/Index` interprets a content-document ID.

---

## 2. The DCMS Routing Pattern

Every database-generated route follows these rules:

1. `RouteType` selects the route folder.
2. The folder contains an `Index` page that owns the processing.
3. The URL uses the query-string name `target`.
4. `RouteTarget` supplies the route-specific value, except where a database relationship supplies a more appropriate value.
5. The `Index` page validates and processes the target.
6. The page renders a response or redirects to the next destination.

This gives DCMS one pattern to remember:

> **Folder, Index, target.**

The route does not bypass the route-specific `Index` page. That leaves a controlled place for validation, logging, analytics, session changes, content selection, and future business rules.

---

## 3. `MenuItem` Routing Data

The `MenuItem` table represents one navigation entry. Its database identity and its browser link have different purposes.

| Value | Purpose |
| :--- | :--- |
| `MenuItemID` | Unique database identity of the menu record |
| `Title` | Text displayed to the visitor |
| `RouteType` | Code that identifies the route processor |
| `RouteTarget` | Destination value interpreted by the selected processor |
| `VisitorMask` | Visitor types allowed to see the item |
| `ParentMenuItemID` | Parent in the menu hierarchy |
| `IsActive` | Whether the item is active |
| `SortOrder` | Position among items with the same parent |

`MenuItemID` is included in the rendered HTML even when it is not required for routing:

```html
<a id="menu-item-20"
   data-menu-item-id="20"
   href="/Visitor/Index?target=Patient">
    Patient
</a>
```

The values have distinct roles:

* `MenuItemID` identifies the database record.
* `RouteType` selects the route processor.
* `RouteTarget` describes what that processor should process.
* `href` tells the browser where to navigate.
* `data-menu-item-id` preserves the database identity in the rendered HTML.

The HTML attribute does not provide security. A visitor can inspect or change it, so the destination page must perform its own validation.

---

## 4. Route Types and Targets

The route-type lookup table currently contains `V`, `C`, `P`, and `R`.

| RouteType | Folder | `RouteTarget` or target value | URL pattern | Processing purpose |
| :---: | :--- | :--- | :--- | :--- |
| `V` | `Visitor` | Visitor destination such as `Patient`, `Caregiver`, or `Register` | `/Visitor/Index?target=...` | Establishes visitor context or starts a Welcome workflow |
| `C` | `Content` | `ContentDocumentID` | `/Content/Index?target=...` | Loads and renders one content document |
| `P` | `Page` | Page target such as `ClinicFinder` | `/Page/Index?target=...` | Dispatches to a page or page-specific behavior |
| `R` | `Redirect` | External or internal destination URL | `/Redirect/Index?target=...` | Validates, logs, and performs a redirect |

The target value is intentionally typed by `RouteType`. All values can be stored in a string-compatible field, but they do not all mean the same thing.

### Visitor route (`V`)

For a visitor route, `RouteTarget` identifies the selected visitor or Welcome destination:

```text
RouteType   = V
RouteTarget = Patient
URL         = /Visitor/Index?target=Patient
```

`Visitor/Index` validates the value, finds the corresponding visitor type or Welcome workflow, establishes the visitor context, and redirects to the appropriate destination.

Examples:

```text
/Visitor/Index?target=Patient
/Visitor/Index?target=Caregiver
/Visitor/Index?target=Register
```

`Register` is handled as part of the Welcome flow. It does not need to become a separate route type:

```text
/Visitor/Index?target=Register
    -> /Register/Index
```

The stored value should use a stable database code when one exists. A friendly display name may change, while a stable code is intended to remain usable by routes.

### Content route (`C`)

For a content route, `RouteTarget` contains the `ContentDocumentID`:

```text
RouteType   = C
RouteTarget = 2
URL         = /Content/Index?target=2
```

`Content/Index` interprets `target=2` as `ContentDocumentID = 2`, loads the document directly, and then loads its `ContentElement` records.

This is deliberately not a title slug and not a reverse lookup from `MenuItemID`. The content document ID is the natural key for the content endpoint.

### Page route (`P`)

For a page route, `RouteTarget` identifies the page or page-specific destination:

```text
RouteType   = P
RouteTarget = ClinicFinder
URL         = /Page/Index?target=ClinicFinder
```

`Page/Index` remains the processing point. It can validate the target, record usage, apply common rules, and then dispatch to the requested page.

### Redirect route (`R`)

For a redirect route, `RouteTarget` contains the destination address:

```text
RouteType   = R
RouteTarget = https://globalskin.org/
URL         = /Redirect/Index?target=https%3A%2F%2Fglobalskin.org%2F
```

`Redirect/Index` must validate the destination before issuing a redirect. It can also log the request, apply an allow-list, reject unsafe schemes, and prevent unwanted open-redirect behavior.

The redirect value is URL-like because the route must ultimately reach another address. It still passes through `/Redirect/Index` so the application retains control of the operation.

---

## 5. Why Content Uses `ContentDocumentID`

The original content-routing idea was to use a readable title slug:

```text
/content?c=what%20is%20pg
```

That is not reliable as a primary key because:

* two menu items can have the same title;
* the same title can serve different visitor audiences;
* titles may be edited;
* punctuation, casing, and spacing require normalization;
* slug uniqueness would need to be enforced in the correct scope;
* renamed titles can break links unless aliases are maintained.

The final content route uses the database identity:

```text
/Content/Index?target={ContentDocumentID}
```

For example:

```text
ContentDocumentID = 2
URL               = /Content/Index?target=2
```

The ID remains stable when the title changes, and duplicate titles do not create ambiguous routes.

Readable slugs could be added later as optional aliases or search-engine-friendly addresses. They should not replace `ContentDocumentID` as the canonical internal content key.

---

## 6. Menu and Content Creation Lifecycle

Content menu items are created in an order that matters:

1. Create the `MenuItem`.
2. Create its placeholder `ContentDocument` using the new `MenuItemID`.
3. Capture the new `ContentDocumentID`.
4. Set `MenuItem.RouteTarget` to that `ContentDocumentID` for `RouteType = C`.
5. Return the generated identifiers to the caller.

The stored procedure that creates a content menu item should perform these operations in one transaction. Conceptually:

```text
Create MenuItem
    -> capture MenuItemID
Create placeholder ContentDocument
    -> capture ContentDocumentID
Update MenuItem.RouteTarget = ContentDocumentID
Return MenuItemID and ContentDocumentID
Commit
```

The placeholder is intentional. It means a new menu item always has a content document and therefore always has a valid content route, even when the real content has not been written or published.

The content document may initially be:

* empty;
* marked as a placeholder;
* unpublished;
* in a draft or newly created workflow state;
* configured to display default content.

`Content/Index` decides what to show based on the document's publication, workflow, and content state. A missing article is therefore treated as a controlled content state rather than as a broken menu link.

Although `ContentDocument.MenuItemID` points back to the menu item, `RouteTarget` intentionally answers a different question:

> **For this content route, which content document should be processed?**

The duplicate-looking value is a deliberate routing denormalization. The stored procedure owns the synchronization so the application does not need to perform a second discovery query or guess which document belongs to the menu item.

---

## 7. `MenuItemList` and URL Generation

`MenuItemList` is a database view that combines menu information with related content information. It exposes values such as:

* `MenuItemID`;
* `RouteType`;
* `RouteTarget`;
* visitor and menu-state fields;
* `ContentDocumentID`;
* content type, description, publication, and workflow fields;
* parent menu information.

The view is the appropriate place to derive the final menu URL because it already knows the route type and the related content data. A calculated URL column can expose the final `href` to the application:

| RouteType | Source value | Generated URL |
| :---: | :--- | :--- |
| `V` | `RouteTarget = Patient` | `/Visitor/Index?target=Patient` |
| `C` | `RouteTarget = 2` | `/Content/Index?target=2` |
| `P` | `RouteTarget = ClinicFinder` | `/Page/Index?target=ClinicFinder` |
| `R` | `RouteTarget = https://globalskin.org/` | `/Redirect/Index?target=...` |

The exact calculated column name can be `Href`, `MenuUrl`, or `GeneratedUrl`. Its purpose is to give the web application one final link value without putting route-construction rules in `_Menu.cshtml`.

The partial then has a simple responsibility:

```cshtml
<a id="menu-item-@item.MenuItemID"
   data-menu-item-id="@item.MenuItemID"
   href="@item.Href">
    @item.Title
</a>
```

The database view should URL-encode query-string values when constructing the URL. The application should still HTML-encode the final attribute, and route endpoints must validate the meaning of the target rather than trusting the browser.

This division keeps the layers clear:

```text
MenuItemList:
    combine data
    interpret route type
    derive target URL

_Menu.cshtml:
    filter visible items
    order and recurse
    render the anchor

Route-specific Index page:
    validate target
    query data
    render or redirect
```

---

## 8. Content Processing

The content relationship is:

```text
MenuItem
    |
    | MenuItemID
    v
ContentDocument
    |
    | ContentDocumentID
    v
ContentElement
```

For a content request:

1. The menu supplies the generated URL.
2. The URL carries the `ContentDocumentID` as `target`.
3. `Content/Index` reads and validates the ID.
4. The PageModel loads the matching `ContentDocument`.
5. The PageModel checks active, publication, and workflow rules.
6. The PageModel loads the document's `ContentElement` rows.
7. Content type, format type, MIME type, and metadata determine how the elements are rendered.
8. The page displays real, placeholder, default, or unavailable content as appropriate.

If menu context is needed, `Content/Index` can use `MenuItemList` or the `ContentDocument.MenuItemID` relationship to obtain the associated menu information. The content lookup itself remains direct because the request already contains `ContentDocumentID`.

---

## 9. Visitor-Aware Routing

Routing and menu visibility work together but have separate responsibilities:

* `VisitorMask` decides whether a menu item is shown.
* `RouteType` identifies the route processor.
* `RouteTarget` supplies that processor's value.
* The destination `Index` page performs final validation and processing.

Several menu records may use the title `Diagnosis`:

| Audience | MenuItemID | RouteType | RouteTarget | Result |
| :--- | ---: | :---: | :---: | :--- |
| Patient | 201 | `C` | 3101 | `/Content/Index?target=3101` |
| Caregiver | 202 | `C` | 3102 | `/Content/Index?target=3102` |
| Medical professional | 203 | `C` | 3103 | `/Content/Index?target=3103` |

The menu can show the same familiar title while taking each audience to different content. `VisitorMask` controls which record is visible.

Visibility is not authorization. The destination page must still validate the current visitor against the menu item's allowed audience and the content's publication state.

---

## 10. Current Implementation Versus Target Design

| Area | Current proof of concept | Target DCMS routing design |
| :--- | :--- | :--- |
| Menu loading | `PageBase` loads active `MenuItem` rows | Continue using database-driven menu data |
| Menu rendering | `_Menu.cshtml` uses the current stored URL behavior | Render a URL supplied by `MenuItemList` |
| HTML identity | Menu links do not yet consistently expose `MenuItemID` | Add `id` and `data-menu-item-id` to each anchor |
| Visitor route | Existing data uses URL-style visitor targets | Store the visitor destination and generate `/Visitor/Index?target=...` |
| Content route | Existing data may contain title-based URLs | Store `ContentDocumentID` in `RouteTarget` and generate `/Content/Index?target=...` |
| Page route | Existing data may contain a complete page URL | Store the page target and route through `/Page/Index` |
| Redirect route | Existing data may contain a complete redirect URL | Route through `/Redirect/Index` for validation and logging |
| Content creation | Stored procedure creates a menu item and placeholder content | Also set and return the content document target in one transaction |
| URL construction | Some construction is currently handled by application code or stored URL values | Derive the final URL in `MenuItemList` |
| Slug lookup | Earlier content examples used title text | Do not use a title slug as the canonical content key |

The target design is intentionally more database-driven, but the web application still owns request validation, authorization, rendering, and HTTP responses.

---

## 11. Design Rules

1. Use standard ASP.NET Core Razor Pages as the physical processing layer.
2. Use the explicit pattern `/{RouteFolder}/Index?target={value}` for every route.
3. Let `RouteType` select the route folder and processing page.
4. Treat `RouteTarget` as a semantic value, not merely an arbitrary URL string.
5. Use visitor values such as `Patient`, `Caregiver`, or `Register` for `V`.
6. Use `ContentDocumentID` for `C`.
7. Use a page target for `P`.
8. Use a destination address for `R`, but always process it through `/Redirect/Index`.
9. Create content menu items and their placeholder documents in one stored-procedure transaction.
10. Set and return the `ContentDocumentID` after the placeholder is created.
11. Use `MenuItemList` to derive the final menu URL when the database has all required information.
12. Include `MenuItemID` in every rendered anchor as HTML identity metadata.
13. Do not use a content title or slug as the canonical content identity.
14. Apply visitor visibility before presenting a link, then validate again at the destination.
15. Validate content publication and workflow state before rendering.
16. Validate redirect destinations before issuing redirects.
17. Keep route construction and route interpretation synchronized between the database and the application.

---

## Glossary

[Return to top](#top)

| Term | Non-programmer explanation |
| :--- | :--- |
| Canonical | The official value the application treats as the primary and reliable one. |
| Content document | The database record representing one complete piece of content and its relationship to a menu item. |
| Content element | A block belonging to a content document, such as text, Markdown, HTML, an image, or a file. |
| Content ID | The unique number identifying a content document. In this design it is the `ContentDocumentID`. |
| Content slug | A readable title-based value used in a URL, such as `what-is-pg`. This design does not use it as the primary content key. |
| Denormalization | Intentionally storing related information in more than one place to make a common operation easier. The stored procedure must keep the values synchronized. |
| Destination | The page, content record, workflow, or external address reached after a menu item is selected. |
| `href` | The HTML attribute containing the address a browser follows when a visitor selects a link. |
| `Index` page | The standard entry page in a route folder. It receives the request and decides what processing should happen next. |
| `MenuItem` | A database record representing one navigation entry. |
| `MenuItemID` | The database number that uniquely identifies one menu item. |
| `MenuItemList` | A database view that combines menu information with related content and can derive the final menu URL. |
| PageModel | The C# class behind a Razor Page. It reads request values, loads data, and prepares the response. |
| Placeholder content | A content document created before the real content is ready, allowing a menu item to have a valid controlled destination. |
| Query string | The name-and-value portion after `?` in a URL, such as `?target=2`. |
| Razor Page | A web page made from a `.cshtml` template and usually a matching `.cshtml.cs` PageModel. |
| Route target | The value a route processor needs in order to reach or process its destination. |
| Route type | A short database code describing how a route target should be interpreted, such as `V`, `C`, `P`, or `R`. |
| Routing | The process of deciding which page or handler should process a requested URL. |
| Visitor mask | A compact list of visitor codes controlling which audiences can see a menu item. |
| `ContentDocumentID` | The primary key for a content document. It is the canonical target for content routes. |
| `RouteTarget` | The database value interpreted by `RouteType`; for `C`, it is the `ContentDocumentID`. |
| `RouteType` | The database code that selects the route folder and processing behavior. |
| URL | The web address requested by a browser. |
| `VisitorType` | A database record describing an audience such as Patient, Caregiver, Provider, or Visitor. |

---

## Summary

DCMS uses standard ASP.NET Core Razor Pages as a thin, stable processing layer. Database records determine the meaning of menu selections.

The consistent route pattern is:

```text
/{RouteFolder}/Index?target={value}
```

The target is interpreted by route type:

```text
V -> visitor destination
C -> ContentDocumentID
P -> page target
R -> redirect destination
```

For content, the menu-item stored procedure creates the menu item first, creates its placeholder `ContentDocument`, stores the resulting `ContentDocumentID` in `RouteTarget`, and returns the identifiers to the caller. `MenuItemList` can then derive the final URL, while the rendered anchor also carries `MenuItemID` as HTML metadata.

This gives DCMS a consistent browser pattern, direct content lookup, controlled route processing, and a database-driven thin client.
