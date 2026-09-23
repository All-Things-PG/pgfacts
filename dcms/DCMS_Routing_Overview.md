# DCMS Routing Overview

This document describes the current POC routing model and the broader DCMS ideas that still inform it. The proof-of-concept application uses Razor Pages directly for visible endpoints, with `RouteType` and `RouteTarget` acting as routing inputs rather than a single central `/Menu/Index` dispatcher.

---

## 1. Current POC routing model

Every `MenuItem` record still carries a `RouteType` and `RouteTarget`, but the POC resolves them through page-specific handlers:

| RouteType | Current POC behavior |
|---|---|
| `V` | `/Visitor/Index?target=<visitor>` selects a persona and redirects to that visitor home page |
| `P` | `/Page/Index?target=<page>` dispatches to a dedicated page such as `BoardMembers` |
| `C` | `/Content/Index?...` resolves a content target when content pages are used |
| `R` | External redirect |
| `M` | Menu expansion / submenu behavior |

The menu system generates links from `MenuItem.GetUrl()` and `GetUrlWithMenu()`. The route target is semantic input, not a hard-coded browser path.

---

## 2. Visitor routing

Visitor routing is persona selection, not a content lookup.

The current behavior is:

- `/Visitor/Index?target=Patient`
- `/Visitor/Index?target=Caregiver`
- `/Visitor/Index?target=Provider`
- `/Visitor/Index?target=Pharmaceutical`

`Visitor/Index.cshtml.cs` reads the `target` query parameter, resolves the matching visitor, and redirects to the appropriate persona page.

---

## 3. Page routing

`RouteType = 'P'` is used for semantic page targets.

In the current POC:

- `RouteTarget = 'BoardMembers.html'`
- `Page/Index.cshtml.cs` interprets the target and redirects to the correct page

This keeps the stored route target semantic while still allowing the page dispatcher to decide the final Razor Page.

---

## 4. Content routing

Content routing remains the database-driven path for content pages when used.

The broad content model is still:

- `ContentDocument` defines the content record
- `ContentElement` defines the renderable blocks
- `FormatType` and `MimeType` determine how a block renders

The POC is currently using direct page content for some areas, while the migration effort is preparing real content for later publication.

---

## 5. Shared page infrastructure

The current shared page layers are:

- `PageBase` for common page infrastructure
- `PortalBase` for portal-specific data and behavior
- `_Layout.cshtml` for the site shell
- `_PortalCommon.cshtml` for the shared portal title/tile strip

The portal title and tile strip are now portal-specific shared chrome, not home-page-specific content.

---

## 6. Summary

The current POC keeps the routing model simple and explicit:

- `Visitor/Index` handles persona selection
- `Page/Index` handles semantic utility pages
- `Content/Index` handles content when content pages are used
- `MenuItem.RouteType` and `RouteTarget` remain semantic values
- shared portal behavior lives in `PortalBase` and `_PortalCommon`

The older centralized `/Menu/Index` / `RouteEngine` model is still a useful DCMS concept, but it is not the current POC implementation.
