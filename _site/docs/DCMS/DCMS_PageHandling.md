# How Razor Pages Routing Works  
### And How DCMS Builds on Top of It

This section explains, in clear and non‑technical terms, how ASP.NET Core Razor Pages handles navigation and routing, and how the DCMS system extends this behavior in a clean, predictable, and maintainable way.

---

# 1. Default Routing in Razor Pages (Plain‑Language Explanation)

ASP.NET Core Razor Pages is built around a simple idea:

**“The location of a page in the project determines the website address used to reach it.”**

There is no complicated routing table.  
There is no custom configuration required.  
The folder structure *is* the navigation structure.

Below are the key concepts in everyday language.

---

## 1.1 The `@page` Directive: “This file is a web page.”

Every Razor Page begins with a small instruction at the top:

```cshtml
@page
```

This tells the system:

- “This file should be reachable in a web browser.”
- “This file responds when someone visits its address.”
- “This file is part of the website’s navigation.”

Without this instruction, the file is treated as a reusable template or partial, not a page.

---

## 1.2 The Page’s Location Determines Its Web Address

If a page is located at:

```
Pages/About.cshtml
```

then the website address to reach it is:

```
/About
```

If a page is located deeper in folders:

```
Pages/Products/List.cshtml
```

the address becomes:

```
/Products/List
```

In other words:

**Folders become parts of the URL.  
The file name becomes the page name.**

This makes navigation predictable and easy to understand.

---

## 1.3 The Code‑Behind File Defines the Page’s Behavior

Every page has two parts:

1. The **visual part** (`.cshtml`)  
2. The **logic part** (`.cshtml.cs`)

The logic file:

- loads data  
- prepares information for display  
- responds to user actions  
- controls what the page does  

This is called the **PageModel**, and it acts like the “brain” behind the page.

---

## 1.4 Folders Become Navigation Sections

If you create folders under the main `Pages` folder, they automatically become navigation sections.

Example:

```
Pages/Services/Consulting.cshtml
```

Website address:

```
/Services/Consulting
```

This is how Razor Pages organizes navigation without needing a separate routing system.

---

## 1.5 Query Strings Work the Same as Any Website

Any page can receive extra information through the address bar, such as:

```
/Products/List?page=2
```

This is standard web behavior and Razor Pages supports it naturally.

---

# 2. How DCMS Routing Builds on Razor Pages

DCMS does **not** replace Razor Pages routing.  
DCMS does **not** override the platform.  
DCMS does **not** introduce custom routing rules.

Instead, DCMS uses Razor Pages exactly as designed, and adds a **database‑driven layer** that determines *which* Razor Page should be used for each menu item.

This keeps the system:

- predictable  
- maintainable  
- easy to understand  
- aligned with Microsoft’s architecture  

Below is how DCMS extends the default behavior.

---

## 2.1 Menu Items Contain Routing Information

Each menu item in DCMS stores two pieces of information:

- **RouteType** — the kind of page to show  
- **RouteTarget** — the specific content or value to load  

Examples:

| RouteType | RouteTarget | Resulting Address |
|----------|-------------|-------------------|
| Content  | c=1234      | `/content?c=1234` |
| Page     | p=about     | `/page?p=about` |
| Visitor  | v=Patient   | `/visitor?v=Patient` |
| Redirect | r=https://globalskin.org | `/redirect?r=https://globalskin.org` |

DCMS simply **generates the correct URL** based on the menu item.

Razor Pages handles the rest.

---

## 2.2 DCMS Uses Four Standard Razor Pages

DCMS uses four normal Razor Pages to display content:

```
Pages/Content/Index.cshtml
Pages/Page/Index.cshtml
Pages/Visitor/Index.cshtml
Pages/Redirect/Index.cshtml
```

Each page:

- contains the `@page` directive  
- is a valid Razor Page endpoint  
- has a PageModel that loads the correct data  
- uses the same layout and menu system  

DCMS does not create custom routing engines.  
It simply uses Razor Pages in a structured way.

---

## 2.3 DCMS Routing Flow (Plain‑Language)

1. A user clicks a menu item.  
2. The menu item contains routing information (RouteType + RouteTarget).  
3. DCMS generates the correct website address.  
4. Razor Pages receives the request and navigates to the correct page.  
5. The PageModel loads the correct content from the database.  
6. The layout and menu are applied.  
7. The final page is displayed.

DCMS routing is **data‑driven**, not code‑driven.

---

# 3. How the Two Systems Work Together

### Razor Pages provides:
- the navigation system  
- the page structure  
- the layout system  
- the code‑behind model  
- the folder‑based routing  
- the ability to load data and respond to user actions  

### DCMS provides:
- the menu structure  
- the content documents  
- the visitor persona system  
- the routing information stored in the database  
- the logic that determines which Razor Page to use  

DCMS does **not** change how Razor Pages works.  
DCMS simply tells Razor Pages *which page to show* and *what content to load*.

This creates a clean, modern, and maintainable architecture that is easy for both technical and non‑technical stakeholders to understand.

---
