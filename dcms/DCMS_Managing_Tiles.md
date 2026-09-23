---
layout: page
title: Managing Tiles
breadcrumb: DCMS > Managing Tiles
description: Reusable visual shortcut layer for contextual navigation.
updated: 2026-09-18
---

# DCMS - Managing Tiles

## Managing Tiles

The tile system is a reusable way to present contextual navigation, shortcuts, and featured links anywhere in the site.

The important idea is that tiles are not just for portals. A tile bar can appear on the home page, on persona pages, on content pages, or on any other Razor page that benefits from a compact set of linked choices.

---

## 1. Why tiles matter

Tiles give the site a visual shortcut layer.

They can be used to:

- help a visitor choose a persona;
- show portal-specific navigation;
- expose related actions on a content page;
- create a compact shortcut bar;
- reinforce the current context without forcing the user back to the main menu.

That makes tiles a powerful complement to the main menu rather than a replacement for it.

---

## 2. TileMenu as the reusable concept

The cleanest model is to treat the tile system as a reusable container called **TileMenu**.

That is more general than **PortalMenu** because the same tile bar concept can be used on:

- the home page;
- visitor/persona pages;
- utility pages;
- content pages;
- any other page that needs contextual shortcuts.

In other words:

- **TileMenu** = the data container;
- **TileMenuItem** = a row inside the container;
- **_TileMenu** = the partial that renders one tile bar.

This keeps the system flexible and avoids creating separate concepts for portal tiles, page tiles, and home tiles when they are really the same idea.

---

## 3. How the page uses tiles

The page or layout decides whether a tile bar should appear.

The partial itself should not be the source of truth. The page knows:

- what kind of page it is;
- what context it is in;
- whether a tile bar is needed;
- whether one or more tile bars should appear.

The partial simply renders the tile data it is given.

That means a Razor page can include tiles like this:

```cshtml
@await Html.PartialAsync("_TileMenu", tileMenuViewModel)
```

The view model carries the tile list and the context needed to render it.

---

## 4. View model responsibility

The tile partial should be fed by a tile-specific view model.

That view model can contain:

- the tile menu identity;
- the list of tiles;
- a display title or caption;
- the current page key;
- the rendering size or style;
- any flags needed by the partial.

This keeps the partial simple and keeps the data shape explicit.

The page can load a model with a factory, helper, constructor, or service method. The key point is that the model is created before the partial is rendered.

---

## 5. The TileID idea

The database should have a tile identity field, such as **TileID** or **TileMenuID**, so each tile menu can be loaded deterministically.

That gives the application a way to say:

- this page uses tile menu 10;
- that region on the page uses tile menu 11;
- these two pages share the same tile menu;
- this page has no tile menu at all.

The tile identity does not belong to the partial itself. It belongs to the model that the partial receives.

That makes it possible to reuse the same `_TileMenu` partial multiple times on the same page with different data.

---

## 6. One tile menu or many

The system should allow multiple tile bars on the same page.

Examples:

- a top tile bar;
- an inline tile bar;
- a bottom tile bar;
- a page-specific shortcut bar;
- a persona tile bar and a content tile bar on the same page.

That is why the page should not be limited to a single hidden tile menu concept. The page should be able to call `_TileMenu` more than once if needed, each time with a different tile menu identity.

So the general rule is:

- **page** = the container/context;
- **TileMenu** = the named tile set;
- **_TileMenu** = the renderer;
- **tile menu ID/key** = how a specific instance is loaded.

---

## 7. TileMenu and page identity

To decide whether a page has tiles, the system needs a stable page identity.

That identity can be:

- a page key;
- a route target;
- a route family plus page name;
- another stable identifier that the page loader understands.

For example, the system could ask:

```text
Does this page key have a TileMenu?
```

If yes, the page loads the matching tile menu data and renders it.
If not, it renders the standard layout without a tile bar.

---

## 8. Route families and tile usage

The site already has four route families:

- **Content** pages such as Article and Gallery;
- **Page** pages such as BoardMembers and other utility pages;
- **Visitor** pages for persona portals and Guest;
- **Redirect** pages that only forward to another target.

That makes tile handling clearer:

- **Redirect** pages should not render a tile bar;
- the destination page may render tiles if it has a TileMenu;
- **Visitor** pages may render portal-style tiles;
- **Page** and **Content** pages may also render tile bars when useful.

This keeps the tile system attached to the actual destination experience, not the redirect wrapper.

---

## 9. Home page tiles

The home page tile bar is really a persona chooser.

It reflects the same idea as:

- the welcome menu;
- the persona dropdown;
- the persona portal links.

The tiles are not a different kind of action. They are another presentation of the same persona-switching concept.

That means the home tiles should use the same underlying persona logic as the welcome menu and dropdown, including the Guest option.

---

## 10. Tile style and size

Tiles should support different visual sizes or styles.

A practical first pass is:

- **small** for shortcut bars;
- **medium** for standard portal tiles;
- **large** for featured tiles.

This lets the same tile system support very different page treatments without needing a separate concept for each one.

---

## 11. Icons, images, and gallery boundaries

Tiles can carry visual assets.

They may have:

- an icon;
- a label;
- a short caption;
- optionally an image.

But once the image becomes the main point, the design is drifting toward gallery or feature-card behavior rather than a simple tile.

That suggests a good rule:

- icon/text first = tile;
- image-led and content-heavy = gallery or feature card.

Large tiles can still be image-led if they remain navigational and short-form.

---

## 12. Reuse across pages

One TileMenu can be reused on multiple pages.

That is one of the strongest reasons to use a generic tile system:

- page A can share the same tile menu as page B;
- a tile menu can be reused in more than one region;
- a future redesign can change the tile set in one place;
- a shared tile bar can remain visually consistent across the site.

This is especially useful for:

- persona portals;
- related links;
- content hubs;
- board or committee pages;
- future shortcut bars.

---

## 13. Suggested implementation shape

A clean implementation would be:

- **TileMenu** table for the tile container;
- **TileMenuItem** table for the items;
- **TileID** or **TileMenuID** as the identity field;
- a tile-specific view model;
- a helper or factory that loads the view model;
- a shared `_TileMenu` partial that renders the tiles.

Example usage:

```cshtml
@await Html.PartialAsync("_TileMenu", topTiles)
```

Where `topTiles` was created earlier by a helper or factory method that took a tile menu ID or page key.

---

## 14. Factory or constructor pattern

The view model can be created in a few different ways.

Examples:

- a factory method that returns a ready-to-render tile model;
- a constructor that accepts the tile menu ID;
- a service method that loads tiles by page key;
- a helper that builds the model from the current page context.

The choice does not matter as much as the discipline:

- the page asks for the tile data;
- the data is loaded before rendering;
- the partial receives a complete model.

That keeps the view layer predictable.

---

## 15. Why this is better than hard-coding

The tile system becomes far more useful when it is data-driven.

That means the site can:

- add tile bars without rewriting page markup;
- reuse tile bars across pages;
- change tile content centrally;
- support different tile sizes and styles;
- keep the design clean as the site grows.

That is a much stronger model than hard-coding tiles into each page by hand.

---

## Summary

Tiles should be treated as a reusable site feature, not a portal-only feature.

The best model is:

- **TileMenu** = reusable tile container;
- **TileMenuItem** = one tile row;
- **_TileMenu** = shared renderer;
- **page key or tile menu ID** = how the correct tile set is loaded;
- **view model or factory** = how the page prepares the tiles before rendering.

That gives the site a flexible shortcut bar system that can support home pages, portal pages, utility pages, and future content pages without inventing a new concept every time.
