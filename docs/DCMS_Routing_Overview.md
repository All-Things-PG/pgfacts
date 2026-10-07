# DCMS Routing Overview

The **Dynamic Content Management System (DCMS)** provides a unified routing and rendering pipeline for all menu‑driven navigation within the application. Every menu click resolves to a route type, and most route types ultimately lead to content stored in the database. This document summarizes how routing, content documents, content elements, and format types work together.

---

## 1. Menu Routing Model

Every `MenuItem` record defines how navigation should behave through its `RouteType` and `RouteTarget`.

### RouteType → Behavior

A menu click resolves according to the route type:

| Code | Name        | Description                                 |
|------|-------------|-----------------------------------------------|
| C    | Content     | Loads a `ContentDocument` and renders it      |
| P    | Page        | Routes to a Razor Page or controller action   |
| M    | Menu        | Expands a submenu                             |
| R    | Redirect    | External or internal redirect                 |
| V    | Visitor     | Switches visitor persona                      |

The **Content** route type (`C`) is the core of DCMS. Most menu items ultimately route to content.

---

## 2. ContentDocument Model

Every `MenuItem` associated with content has a corresponding `ContentDocument`.  
Even if the content is empty, a placeholder document is created automatically.

### Content Types

Content types define the *purpose* and *layout* of a document.

| Code | Name        | Description                                 | SortOrder |
|------|-------------|-----------------------------------------------|-----------|
| A    | Article     | Long-form educational content                 | 1         |
| N    | NewsItem    | News updates and announcements                | 2         |
| F    | FAQ         | Question and answer pairs                     | 3         |
| G    | Gallery     | Image gallery metadata                        | 11        |
| P    | Profile     | Staff, board, or expert profiles              | 5         |
| R    | Research    | Clinical trial or research study              | 9         |
| T    | Testimonial | Patient and caregiver stories                 | 4         |
| D    | Document    | PDF or downloadable file reference            | 12        |
| L    | Link        | External resource or reference                | 8         |
| E    | Event       | Events, webinars, fundraisers                 | 6         |
| X    | External    | External file                                 | 10        |
| U    | Unknown     | Placeholder content                           | 99        |

The default type for new content is **U (Unknown)**.

---

## 3. ContentElement Model

A `ContentDocument` may contain multiple `ContentElement` records.  
Each element represents a block of content — text, HTML, image, audio, PDF, etc.

### Format Types

Format types describe the *source file type* of the element.

| Code | Name   | Description              | FileTypes                 | SortOrder |
|------|--------|--------------------------|---------------------------|-----------|
| T    | Text   | Plain text               | .txt                      | 1         |
| M    | MD     | Markdown                 | .md                       | 6         |
| H    | HTML   | Web page markup          | .html, .htm               | 3         |
| I    | Image  | Binary image             | .jpg, .png, .gif, .svg    | 8–12      |
| A    | Audio  | Audio formats            | .mp3, .wav, .ogg          | 9–16      |
| P    | PDF    | Portable Document Format | .pdf                      | 8         |
| W    | Word   | Microsoft Word           | .docx, .docm, .dotx       | 17–20     |
| S    | Excel  | Spreadsheet              | .xls, .xlsx               | 21–22     |
| N    | PPT    | PowerPoint               | .ppt, .pptx, .pps         | 23–31     |
| E    | EPUB   | Electronic publication   | .epub                     | 7         |
| J    | JSON   | JSON data                | .json                     | 6         |
| D    | ODT    | OpenDocument Text        | .odt                      | 33        |
| G    | GDoc   | Google Document          | .gdoc                     | 32        |
| ?    | Unknown| Unknown binary           | .bin                      | 99        |

---

## 4. MimeType Rendering Model

Each `ContentElement` has a `MimeType` that determines how it is rendered.

### Rendering Flags

| Flag        | Meaning                                  |
|-------------|-------------------------------------------|
| IsText      | Render as text or markup                  |
| IsBinary    | Binary file requiring download or viewer  |
| IsRenderable| Can be displayed inline in the browser    |

This allows DCMS to support:

- Inline HTML  
- Markdown rendering  
- Image display  
- Audio playback  
- PDF embedding  
- Downloadable files  
- External document links  

---

## 5. Unified Routing Pipeline

The full DCMS routing pipeline looks like this:

Each folder becomes a routing domain, and each `.cshtml` file becomes a routable endpoint.

### Key ASP.NET Core Routing Concepts

- **Razor Pages routing is folder-based**  
  `/Pages/Visitor/Patient.cshtml` → `/Visitor/Patient`

- **PageModel classes handle requests**  
  `Patient.cshtml.cs` receives the request and loads data.

- **RedirectToPage()** is used for internal navigation  
  `RedirectToPage("/Visitor/Patient")`

- **Redirect()** is used for external URLs  
  `Redirect("https://globalskin.org")`

- **Route parameters** are passed via `asp-route-*` or query strings  
  `/Content/Index?id=123`

ASP.NET Core does not require controllers for Razor Pages; routing is handled automatically based on folder structure.

---

# DCMS Routing Architecture (Full Summary)

This document provides a complete, unified overview of DCMS routing design, how ASP.NET Core implements routing, how content is retrieved and displayed, and how each RouteType behaves in the modern semantic architecture. It is intended as a full-length reference document for the DCMS system.

## a. ASP.NET Core Routing (Razor Pages)

ASP.NET Core Razor Pages uses folder-based routing. The physical folder and filename determine the URL. Examples:

/Pages/Visitor/Patient.cshtml → /Visitor/Patient  
/Pages/Page/ClinicFinder.cshtml → /Page/ClinicFinder  
/Pages/Content/Index.cshtml → /Content/Index

Key behaviors:
- Razor Pages automatically map routes based on folder structure.
- Each .cshtml.cs PageModel handles the request.
- RedirectToPage() is used for internal navigation.
- Redirect() is used for external URLs.
- Route parameters are passed via asp-route-* or query strings.
- No controllers are required for Razor Pages.

This routing model aligns naturally with DCMS’s RouteType-driven architecture and makes folder-based organization a first-class routing mechanism.

## b. DCMS Routing Model (Semantic Routing)

DCMS uses semantic routing rather than URL parsing. Every menu click sends a single value: MenuItemID. This eliminates legacy URL fragments such as /redirect?r= or /visitor?v=.

All navigation flows through one entry point:

/Menu/Index?id=<MenuItemID>

Flow of a MenuItem click:
1. User clicks a menu item.
2. /Menu/Index.cshtml.cs receives the MenuItemID.
3. The routing engine loads the MenuItem from the database.
4. The routing engine inspects RouteType, RouteTarget, ContentDocumentID, VisitorMask, and CurrentVisitor.
5. The routing engine redirects to the correct folder/page.
6. The destination page loads and renders.

This creates a centralized routing hub and ensures consistent behavior across all navigation paths.

## c. RouteEngine (Central Routing Logic)

The routing engine lives in /Services/Routing/RouteEngine.cs. It converts a MenuItem into a navigation action. The routing engine is responsible for interpreting RouteType and RouteTarget and returning the correct redirect.

Example logic:

switch (item.RouteType.Code)
{
    case "C":
        return RedirectToPage("/Content/Index", new { id = item.ContentDocumentID });
    case "V":
        return RedirectToPage($"/Visitor/{item.RouteTarget}");
    case "P":
        return RedirectToPage($"/Page/{item.RouteTarget}");
    case "R":
        return Redirect(item.RouteTarget);
    case "M":
        return RedirectToPage("/Menu/Index", new { id = item.MenuItemID });
}

RouteTarget contains only the meaningful target (URL, page name, visitor type). Prefixes are not used.

Benefits of centralized routing:
- All routing logic is in one place.
- Razor Pages remain focused on rendering.
- RouteTypes become fully extensible.
- No parsing of query-string-based routing fragments.
- MenuItemID becomes the universal navigation token.

## d. RouteTypes and Their Behavior

DCMS defines several RouteTypes, each representing a routing domain.

### Content (C)
- RouteTarget ignored.
- ContentDocumentID determines what to load.
- Redirects to /Content/Index?id=<ContentDocumentID>.
- ContentType selects the template.
- ContentElements provide the blocks to render.
- Supports articles, FAQs, news items, profiles, galleries, research, and more.

### Visitor (V)
- RouteTarget = VisitorTypeCode (e.g., Patient, Caregiver, Provider).
- Redirects to /Visitor/<VisitorTypeCode>.
- Each visitor type can have its own home page.
- Supports persona-specific UX and content filtering.

### Page (P)
- RouteTarget = PageName (e.g., ClinicFinder, About, Contact).
- Redirects to /Page/<PageName>.
- Used for static or utility pages.
- Allows custom layouts and specialized functionality.

### Redirect (R)
- RouteTarget = external URL.
- Redirects using Redirect(RouteTarget).
- Allows optional logic in /Redirect/Index for analytics or tracking.
- Supports external navigation without internal rendering.


## e. Content Retrieval and Display

DCMS stores content using two core models: ContentDocument and ContentElements.

### ContentDocument
Defines purpose and layout via ContentType. Examples include Article, FAQ, NewsItem, Profile, Gallery, Research, and others.

### ContentElements
Define blocks of content:
- Markdown
- HTML
- Images
- Audio
- PDF
- Word
- JSON
- Binary files
- Structured data blocks

Rendering flow:
1. /Content/Index?id=<ContentDocumentID> loads the document.
2. ContentType selects the template (Article, FAQ, NewsItem, etc.).
3. Template loads ContentElements.
4. Each element is rendered based on FormatType, MimeType, and SortOrder.

This creates a block-based CMS similar to modern systems like WordPress Gutenberg or Drupal Paragraphs.

## f. Folder-Based Routing Structure

DCMS organizes RouteTypes into folders:

/Pages/Content  
/Pages/Visitor  
/Pages/Page  
/Pages/Redirect  
/Pages/Menu

Each folder contains:
- Index.cshtml (home page for the route type)
- Specialized pages (e.g., Patient.cshtml, Article.cshtml)
- PageModel classes for loading and rendering data

This structure matches ASP.NET Core’s routing model and keeps the solution clean, predictable, and easy to maintain.

## g. PageBase and Global Context

PageBase.cs is used to load global context such as:
- Visitor selection
- Menu tree
- RouteTypes
- ContentTypes
- Lookup tables

In the modern architecture:
- PageBase loads context only.
- RouteEngine performs routing.
- Pages focus on rendering.

This separation of concerns improves maintainability and clarity.

## h. Default Index Behavior

The default /Index page can redirect to:
- /Visitor/Index (visitor selection)
- /Menu/Index?id=<rootMenuItem>
- /Content/Index?id=<homepageContentDocument>
- /Visitor/Welcome (persona-based landing)

The routing engine allows flexible homepage behavior.

## i. Summary

ASP.NET Core routing is folder-based and works perfectly with DCMS’s RouteType architecture. DCMS uses semantic routing: MenuItemID → RouteEngine → Folder/Page. RouteTarget contains only the meaningful target. Content routing is database-driven and template-based. Visitor routing supports persona-specific home pages. Redirect routing is centralized and clean. Page routing handles static/utility pages. Menu routing supports hierarchical navigation. PageBase loads global context while RouteEngine handles routing. The architecture is consistent, maintainable, and future-proof.

This full-length summary provides a comprehensive reference for routing, content, and RouteTypes in DCMS.

User Clicks Menu Item
        |
        v
Menu Partial View
(Every href = /Menu/Index?id=###)
        |
        v
/Pages/Menu/Index.cshtml.cs
(Loads MenuItem, sets CurrentMenuItem)
        |
        v
RouteEngine.Route(MenuItem)
        |
        +------------------------------+
        |                              |
        v                              v
RouteType = C                    RouteType = V
(Content)                        (Visitor)
        |                              |
        v                              v
RedirectToPage(                RedirectToPage(
  "/Content/Index",              "/Visitor/<Type>"
  id = ContentDocumentID )     )
        |
        v
Content/Index.cshtml.cs
(Loads ContentDocument + Elements)
        |
        v
Renders Template
