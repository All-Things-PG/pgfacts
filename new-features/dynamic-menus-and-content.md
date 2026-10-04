---
layout: page
title: Dynamic Menus and Content
nav_label: New Features in Phase 2
breadcrumb: New Features in Phase 2 > Dynamic Menus and Content
description: Menus and content that can be updated as the site evolves.
permalink: /new-features-in-phase-2/dynamic-menus-and-content/
---

# Dynamic Menus and Content

Dynamic menus and content are the operational side of the Phase 2 knowledge-base story. They are what let us build the site from curated pieces instead of hard-coding every page and navigation link by hand.

DCMS is the mechanism that makes this work. It lets us define topics, menu items, content records, and supporting metadata so the site can change as the content grows. In practice, that means a page can be added to a topic, a menu item can be exposed, and a tile can appear in the right place without redesigning the whole site.

### What this means

The point is not just "dynamic" for its own sake. The point is to support a site that can grow while staying organized.

That gives us a few important benefits:

- menu items can be curated instead of hand-edited everywhere
- content can be grouped by topic and audience
- new pages can be published without breaking the existing structure
- the same content can be shown in menus, tiles, and search results

### How it fits the site

The current site already uses shared topic data for tiles and topic page lists. Dynamic menus and content extend that pattern so the source of truth is more structured and easier to maintain.

In the intended model:

1. a topic or menu item is defined in the content system
2. the site renders that item into navigation and supporting lists
3. content records can be attached to the menu item
4. the same record can later be reused in search, pages, or other displays

That is why this belongs with the new features. It is the bridge between the editorial model and the user-facing knowledge base.

### Why it matters

Dynamic menus and content make it possible to do three things well at once:

- keep the site easy to navigate
- keep the content organized for maintenance
- keep the structure flexible enough for future growth

Without that structure, the site becomes a pile of disconnected pages. With it, the site becomes a curated information system.

### Example uses

Dynamic menus and content can support:

- adding a new caregiver resource page and exposing it in the right menu
- placing a provider or research reference into a relevant topic
- surfacing related content under a tile set
- keeping the knowledge base tied to the same structure as the rest of the site

### Phase 2 direction

The long-term goal is a site where content is not just published, but curated and connected.

That means the same underlying content model should support:

- navigation
- topic pages
- tile groups
- search results
- visitor-specific presentation

This is one of the foundations that makes the knowledge base possible.
