<a id="top"></a>
# How ASP.NET Core Razor Pages Handles Requests

This document explains the standard request and page-processing behavior provided by [ASP.NET Core](#glossary) [Razor Pages](#glossary). It intentionally describes the framework without application-specific routing, database, menu, or content-management features.

The goal is to give a non-programmer enough context to understand what happens when a visitor enters a web address and receives a page.

---


## 1. The Big Picture

When someone visits a website, the application performs a sequence of steps:

1. The browser sends a [request](#glossary) containing an address, such as `/Products/List`.
2. ASP.NET Core receives the request.
3. Razor Pages routing finds the page that matches the address.
4. The page's [PageModel](#glossary) runs its request-handling method.
5. The PageModel obtains or prepares information for the page.
6. [Razor](#glossary) combines that information with the page's [HTML](#glossary) template.
7. ASP.NET Core sends the finished HTML back to the browser.

In simple terms:

```text
Browser request
      |
      v
ASP.NET Core request pipeline
      |
      v
Razor Pages routing
      |
      v
PageModel and page template
      |
      v
HTML response shown in the browser
```

ASP.NET Core is Microsoft's web framework. Razor Pages is a page-oriented way to build web applications within that framework.

---

## 2. What Is a [Razor Page](#glossary)?

A Razor Page normally has two related files:

| File | Purpose |
| :--- | :--- |
| `.cshtml` | The page template: HTML plus Razor markup describing what should be displayed |
| `.cshtml.cs` | The PageModel: C# code that loads data and responds to requests |

For example:

```text
Pages/Products/List.cshtml
Pages/Products/List.cshtml.cs
```

The `.cshtml` file describes the page's presentation. The `.cshtml.cs` file contains the supporting code. Keeping these responsibilities separate makes each file easier to understand and maintain.

A simple PageModel looks like this:

```csharp
public class ListModel : PageModel
{
    public void OnGet()
    {
        // Load or prepare information for the page here.
    }
}
```

[`OnGet`](#glossary) means “run this method when the page receives a normal GET request.” Other handlers, such as [`OnPost`](#glossary), can respond to form submissions.

---

## 3. The [`@page`](#glossary) Directive

A Razor Page normally begins with:

```cshtml
@page
```

This directive tells ASP.NET Core that the file can receive a direct browser request.

Without `@page`, a `.cshtml` file is normally a reusable view or partial rather than a page endpoint. A partial can be inserted into another page, but it is not normally reached directly through a browser address.

---

## 4. How ASP.NET Core Finds a Razor Page

Razor Pages uses the `Pages` folder as the starting point for page routing. The folder path and file name normally determine the URL:

| File | Normal URL |
| :--- | :--- |
| `Pages/Index.cshtml` | `/` or `/Index` |
| `Pages/Products/Index.cshtml` | `/Products` or `/Products/Index` |
| `Pages/Products/List.cshtml` | `/Products/List` |
| `Pages/Products/Details.cshtml` | `/Products/Details` |

The `Index` file is the default page for its folder. Therefore, `Pages/Products/Index.cshtml` is the default page for the `/Products` area.

The folder structure makes page addresses predictable:

* folders become parts of the URL;
* the file name becomes the final page name;
* `Index` represents the default page for a folder.

The `Pages` folder is a routing convention. It is not the same thing as a navigation menu. A menu is an interface that links to pages; [routing](#glossary) is the framework's process for matching an address to a page.

---

## 5. The Root or Home Page

The application normally starts at:

```text
Pages/Index.cshtml
```

This page responds to the root address:

```text
/
```

The root page can display the application's home page directly:

```csharp
public class IndexModel : PageModel
{
    public void OnGet()
    {
    }
}
```

It can also redirect the visitor to another page:

```csharp
public IActionResult OnGet()
{
    return RedirectToPage("/Products/Index");
}
```

The framework does not require the root page to redirect. That is simply one behavior an application may choose.

---

## 6. The Request Pipeline

The [request pipeline](#glossary) is the ordered set of application services that inspect or process every request. A typical ASP.NET Core application configures services and [middleware](#glossary) in `Program.cs`.

Typical service registration includes:

```csharp
builder.Services.AddRazorPages();
```

This makes Razor Pages available to the application.

A typical request pipeline includes steps such as:

```csharp
app.UseExceptionHandler("/Error");
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();
app.MapRazorPages();
```

In plain language:

| Pipeline step | What it does |
| :--- | :--- |
| Exception handler | Sends unexpected errors to a designated error page outside development |
| Static files | Serves CSS, JavaScript, images, and other files that do not require page code |
| Routing | Matches the request address to an endpoint |
| Authorization | Applies access rules when they have been configured |
| Map Razor Pages | Makes Razor Page endpoints available to the application |

The order matters. Middleware runs in sequence, so changing the order can change application behavior.

Some applications also add middleware for sessions, authentication, logging, caching, localization, or other services. Those features are optional; they are not required for basic Razor Pages routing.

---

## 7. What Happens When a Page Is Requested

Suppose a visitor requests:

```text
/Products/List
```

ASP.NET Core normally processes that request as follows:

1. The browser sends the request to the web server.
2. The request enters the ASP.NET Core pipeline.
3. Razor Pages routing looks under `Pages` for a matching page.
4. It finds `Pages/Products/List.cshtml`.
5. ASP.NET Core creates the matching `ListModel` PageModel.
6. The `OnGet` method runs.
7. The PageModel loads or prepares any information needed by the template.
8. The `.cshtml` file uses that information while producing HTML.
9. The response is sent back to the browser.

The browser does not receive the C# PageModel. It receives the rendered response, usually HTML.

---

## 8. Page Handlers

Page handlers are methods in the PageModel that respond to different types of requests.

### GET requests

A GET request normally asks to display a page:

```csharp
public void OnGet()
{
    // Prepare information for display.
}
```

### POST requests

A POST request commonly sends information from a form:

```csharp
public IActionResult OnPost()
{
    if (!ModelState.IsValid)
    {
        return Page();
    }

    return RedirectToPage("/Products/Confirmation");
}
```

The method can return the same page to show validation errors or redirect to another page after a successful operation.

Other [HTTP](#glossary) methods and named handlers are possible, but GET and POST are the most common in a basic Razor Pages application.

---

## 9. Query Strings and Route Parameters

A [query string](#glossary) is the part of a [URL](#glossary) after `?`:

```text
/Products/List?page=2
```

Here:

* `/Products/List` identifies the Razor Page;
* `page` is the parameter name;
* `2` is the parameter value.

A PageModel can read a query-string value with model binding:

```csharp
public class ListModel : PageModel
{
    public int PageNumber { get; set; }

    public void OnGet(int page = 1)
    {
        PageNumber = page;
    }
}
```

The URL can also contain a [route parameter](#glossary). A page can declare one with a [route](#glossary) template:

```cshtml
@page "{id:int}"
```

The corresponding URL might be:

```text
/Products/42
```

The PageModel can receive the value:

```csharp
public void OnGet(int id)
{
    // Use the product identifier here.
}
```

Query strings and route parameters both provide input to a page. They do not create a new physical page.

---

## 10. Links and Navigation

A link is a piece of HTML that lets the visitor request another address:

```html
<a href="/Products/List">View products</a>
```

Razor Pages also provides tag helpers for creating links:

```html
<a asp-page="/Products/List">View products</a>
```

With parameters:

```html
<a asp-page="/Products/Details" asp-route-id="42">
    View product
</a>
```

The link is part of the user interface. The routing system is the part that receives the resulting address and finds the page. These are related but separate responsibilities.

---

## 11. Redirects

A [redirect](#glossary) tells the browser to request a different address.

### Redirecting to another Razor Page

```csharp
return RedirectToPage("/Products/List");
```

### Redirecting to an external address

```csharp
return Redirect("https://example.com");
```

A redirect is different from rendering a page directly. The application first sends a redirect response, and the browser then makes another request to the new address.

---

## 12. Layouts and Partial Views

A [layout](#glossary) is a shared page frame. A common layout file is:

```text
Pages/Shared/_Layout.cshtml
```

The layout can contain the site header, navigation, footer, scripts, and the location where each individual page is inserted. This prevents every page from duplicating the same surrounding HTML.

A [partial view](#glossary) is a reusable piece of Razor markup. Examples include:

```text
Pages/Shared/_Header.cshtml
Pages/Shared/_Menu.cshtml
```

A partial is included by another Razor file. It is not normally a directly addressable page because it does not normally contain the `@page` directive.

---

## 13. Static Files

[Static files](#glossary) are sent to the browser without running PageModel code. Common examples include:

* CSS files that control appearance;
* JavaScript files that add browser behavior;
* images and icons;
* downloadable files;
* web fonts.

These files are commonly stored under a [`wwwroot`](#glossary) folder:

```text
wwwroot/css/site.css
wwwroot/js/site.js
wwwroot/img/logo.png
```

The `UseStaticFiles` middleware makes these files available to the browser. Razor Pages and static files work together, but they are handled differently.

---

## 14. Errors and Not-Found Pages

An application can provide an error page such as:

```text
Pages/Error.cshtml
Pages/Error.cshtml.cs
```

An exception handler can redirect unexpected failures to that page when the application is not running in development.

If no Razor Page matches the requested address, ASP.NET Core returns a not-found response, commonly called a `404`. The application can customize how that response is displayed.

Development environments often show more diagnostic information. Production environments should avoid displaying internal details to visitors.

---

## 15. What ASP.NET Core Does Not Do Automatically

Default Razor Pages behavior does not automatically:

* create a visual navigation menu;
* read application content from a particular database;
* decide which pages a particular visitor may see;
* convert arbitrary database rows into web pages;
* infer business rules from page names;
* create links for every file in the project;
* replace application-specific authorization rules.

The framework provides the request, routing, page, and rendering foundations. An application adds its own data, business rules, navigation, and specialized behavior on top of those foundations.

---

## 16. A Complete Example

Consider this file pair:

```text
Pages/Products/Details.cshtml
Pages/Products/Details.cshtml.cs
```

The page template might contain:

```cshtml
@page "{id:int}"
@model DetailsModel

<h1>@Model.Name</h1>
<p>@Model.Description</p>
```

The PageModel might contain:

```csharp
public class DetailsModel : PageModel
{
    public string Name { get; private set; } = string.Empty;
    public string Description { get; private set; } = string.Empty;

    public void OnGet(int id)
    {
        // Find the product identified by id.
        Name = "Example product";
        Description = "Example description";
    }
}
```

When the browser requests `/Products/Details/42`:

1. The route template matches the URL.
2. `42` is supplied to the `id` parameter.
3. `OnGet` runs.
4. The PageModel prepares the product information.
5. Razor substitutes the property values into the template.
6. The browser receives the resulting HTML.

The example uses placeholder data, but the same process can load information from a database, a file, an API, or another service.

---

## Glossary

[Return to top](#top)

| Term | Non-programmer explanation |
| :--- | :--- |
| ASP.NET Core | Microsoft's framework for building web applications that receive browser requests and return pages, data, or other responses. |
| Application pipeline | The ordered set of steps every request passes through, such as error handling, static-file handling, routing, and authorization. |
| Browser request | A message sent by a browser asking a web application for a page, image, data, or another resource. |
| Code-behind | The C# file paired with a Razor template. It contains instructions for loading information and responding to user actions. |
| Endpoint | A destination the application knows how to handle, such as a Razor Page at `/Products/List`. |
| HTML | The markup sent to the browser that describes headings, links, forms, images, and other page structure. |
| HTTP | The standard communication language used between a browser and a web server. |
| Layout | A shared page frame containing common elements such as a header, navigation area, footer, and scripts. |
| Middleware | A pipeline component that performs one job for requests, such as serving static files, handling errors, or enabling authorization. |
| Page handler | A PageModel method that responds to a request, such as `OnGet` for displaying a page or `OnPost` for processing a form. |
| PageModel | The C# class that supplies data and behavior for one Razor Page. It is the page's request-handling code. |
| Partial view | A reusable piece of Razor markup, such as a header or menu, that can be inserted into several pages. |
| Query string | Optional name-and-value information after `?` in a URL, such as `?page=2`. |
| Razor | A syntax that lets an HTML template include C# values and simple logic. |
| Razor Page | A web page made from a `.cshtml` template and usually a matching `.cshtml.cs` PageModel. |
| Razor Pages routing | ASP.NET Core's convention for matching files under `Pages` to web addresses based on folders and file names. |
| Redirect | A response telling the browser to make another request at a different address. |
| Route | The address and matching rules used to reach a page or other application endpoint. |
| Route parameter | A value included as part of a URL path, such as `42` in `/Products/Details/42`. |
| Static file | A file such as CSS, JavaScript, an image, or an icon that can be sent to the browser without running PageModel code. |
| URL | The address used to locate a page or resource on the web. |
| `@page` directive | The instruction that makes a Razor template directly reachable as a page endpoint. |
| `OnGet` | The PageModel method normally called when a page is requested with the HTTP GET method. |
| `OnPost` | The PageModel method commonly used when a form sends information back to the application. |
| `wwwroot` | The conventional folder for files that should be served directly to browsers, such as stylesheets, scripts, and images. |

---

## Summary

ASP.NET Core receives the browser request, Razor Pages routing finds the matching page under `Pages`, and the PageModel prepares the information needed by that page. Razor combines the information with the `.cshtml` template, applies the shared layout, and produces the HTML sent back to the browser.

The framework supplies the standard request, routing, handler, and rendering behavior. Applications add their own data sources, business rules, navigation, security, and other features on top of that foundation.
