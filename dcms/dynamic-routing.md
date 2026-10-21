---
layout: page
title: Dynamic Routing
nav_label: DCMS
breadcrumb: DCMS > Dynamic Routing
description: How the custom DCMS route model sends menu selections to visitor experiences, content, application pages, or redirects.
permalink: /dcms/dynamic-routing/
---

<a id="top"></a>

# Dynamic Routing

Dynamic Routing describes the custom way DCMS menu records identify and direct visitors to destinations. It is an application-level design built on top of the web framework; it is not a replacement for standard ASP.NET Core request routing. ASP.NET Core receives a URL and selects a Razor handler. DCMS uses a menu item's `RouteType` and `RouteTarget` to decide what that selection means for the application.

## The four route types

The current `RouteType` lookup contains four values:

<table class="topic-table">
  <thead><tr><th>Code</th><th>Destination</th><th>Example RouteTarget</th></tr></thead>
  <tbody>
    <tr><td>V</td><td>Select a visitor experience.</td><td><code>/visitor?target=Patient</code></td></tr>
    <tr><td>C</td><td>Open a content document by its ContentDocumentID.</td><td><code>/content?target=18</code></td></tr>
    <tr><td>P</td><td>Open an application page.</td><td><code>/page?target=clinicfinder.cshtml</code></td></tr>
    <tr><td>R</td><td>Follow an internal or external redirect.</td><td><code>/redirect?target=https://example.org/</code></td></tr>
  </tbody>
</table>

## What the route fields mean

<table class="topic-table">
  <thead><tr><th>Field</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td><code>MenuItemID</code></td><td>Identifies one item in the menu.</td></tr>
    <tr><td><code>ParentMenuItemID</code></td><td>Connects a child item to its parent and establishes menu hierarchy.</td></tr>
    <tr><td><code>RouteType</code></td><td>Classifies the destination as Visitor, Content, Page, or Redirect.</td></tr>
    <tr><td><code>RouteTarget</code></td><td>Stores the route value the application follows. For content, it includes the endpoint and target identifier.</td></tr>
    <tr><td><code>ContentDocumentID</code></td><td>Identifies a content document. It is distinct from the menu item ID and from the complete route string.</td></tr>
  </tbody>
</table>

These values are related but not interchangeable. For example, a content route's `RouteTarget` may be `/content?target=18`; the value `18` is the document identifier carried by that route.

## How a menu selection is handled

1. DCMS selects the menu item for the current menu and visitor experience.
2. The menu item supplies its `RouteType` and stored `RouteTarget`.
3. The application handler interprets the target according to the route type.
4. For a content route, the content handler loads the `ContentDocument` identified by the target and reads its content elements.

The stored target is used to create the link. The destination handler is responsible for validating and interpreting its parameters. A menu's `VisitorMask` controls which menu items are shown for a selected visitor experience; it is not an authorization boundary for private information.

## Content identity does not depend on titles

DCMS uses identifiers instead of looking up content by its visible menu title. Titles can be repeated for different visitor experiences or changed later. A menu item has its own `MenuItemID`; its associated content document has a separate `ContentDocumentID`.

For a content menu item, the database can create a placeholder `ContentDocument` linked to the menu item and use that document's ID in the content route before the article has been written. A placeholder establishes the relationship; it is not authored or published PG information.

## Menu routing and standard web routing

Standard web routing matches an incoming request URL to an application endpoint. The DCMS route model adds meaning to database-driven menu selections: the route type classifies the destination and the route target tells the application what to handle.

Menu hierarchy is established by parent and child relationships. The route type describes where a selection leads; it does not describe how a menu expands on screen.

[Return to top](#top)
