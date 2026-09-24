---
layout: page
title: PG Facts Site Guide
nav_label: Welcome
description: How the site is structured and maintained.
permalink: /docs/pgfacts-site-guide/
---

# PG Facts Site Guide

This is the working guide for maintaining the PG Facts site. It explains where the navigation comes from, which files control page content, how topic tiles are built, and what to edit when you want to add or change descriptions.

## What the front matter means

At the top of many Markdown files you will see a block like this:

| field | purpose |
| --- | --- |
| `layout` | Which layout the page uses. |
| `title` | The page title shown in the browser and on the page. |
| `nav_label` | The top-level menu/topic label used in the breadcrumb/title bar. |
| `description` | The short description shown in the title bar. |
| `permalink` | The URL for the page. |

These fields are Jekyll metadata. They are not part of the visible content, but they control how the site is rendered. Even if this guide is mostly for you behind the scenes, these fields still matter because the guide itself is a page in the site build.

## The main idea

The site is organized around a small set of topics:

1. Welcome
2. User Experience
3. DCMS
4. Database
5. About

Each topic has:

- a top-level menu item
- a topic landing page
- a shared set of tiles or related links
- page descriptions for the linked documents

The topic name in the menu is meant to be the source for the breadcrumb/title bar label. The topic landing page contains the topic content. The linked pages contain the detailed documents.

## What to edit for what purpose

### Change a menu label, menu order, or top-level menu description

Edit:

- `_data/navigation.yml`

This file controls the top-level menu labels and the basic descriptions associated with them.

### Change the topic landing text, tile list, or document list

Edit:

- `_data/topic_pages.yml`

This file is the main source of truth for:

- topic summaries
- topic landing page document lists
- topic tile text
- page descriptions used in the topic tables

### Change the header/menu behavior

Edit:

- `_includes/site-header.html`

This file controls:

- the logo
- the top navigation
- dropdown behavior
- the contact button

### Change the page title bar or breadcrumb-like label

Edit:

- `_includes/page-banner.html`

This is where the menu/topic label and short description appear under the header.

### Change the site-wide gate

Edit:

- `_includes/site-gate.html`
- `assets/css/style.css`

The gate is the overlay shown before access. The code is case-insensitive for `ATPG`.

### Change the layout for topic pages or standard pages

Edit:

- `_layouts/home.html`
- `_layouts/page.html`
- `_layouts/default.html`

These control the page wrappers and how topic landing pages differ from normal content pages.

### Change the site look and spacing

Edit:

- `assets/css/style.css`

This file controls:

- logo size
- menu spacing
- dropdown width
- page title bar spacing
- tile widths
- table styling
- gate styling

## Folder structure

### `home/`

The home section contains the landing page for the site.

- `home/index.md` is the home page entry point
- `home/home.md` is the page content that appears on the home page

### `dcms/`

This folder contains the DCMS topic pages.

- `dcms/index.md` is the DCMS landing page
- `dcms/what-is-dcms.md`
- `dcms/dynamic-content.md`
- `dcms/dynamic-menus.md`
- and the other DCMS-related documents

### `database/`

This folder contains the database topic pages.

- `database/index.md` is the Database landing page
- `database/why-have-a-database.md`
- `database/main-tables.md`
- `database/schema.md`
- `database/diagrams.md`

### `user-experience/`

This folder contains the persona / portal pages.

- `user-experience/index.md` is the User Experience landing page
- `user-experience/what-is-a-portal.md`
- `user-experience/selecting-a-user-experience.md`
- `user-experience/patients.md`
- `user-experience/caregivers.md`
- `user-experience/providers.md`
- `user-experience/pharmaceutical.md`
- `user-experience/guest.md`

### `about/`

This folder contains the About pages.

- `about/index.md` is the About landing page
- `about/all-things-pg.md`
- `about/phase-2-development.md`
- `about/the-designer.md`

### `docs/`

This folder contains the guides and supporting public documentation.

- `docs/pgfacts-site-guide.md` is this guide
- `docs/executive-summary.md`
- `docs/curating-content.md`
- `docs/managing-tiles.md`
- `docs/portal-experience.md`

### `_data/`

This folder stores the site’s structured data.

- `_data/navigation.yml` controls the top menu
- `_data/topic_pages.yml` controls topic summaries, tiles, and page lists

### `_includes/`

Reusable pieces of the layout live here.

- `_includes/site-header.html`
- `_includes/page-banner.html`
- `_includes/site-gate.html`

### `_layouts/`

Page templates live here.

- `_layouts/default.html`
- `_layouts/home.html`
- `_layouts/page.html`
- `_layouts/redirect.html`

### `assets/`

Shared styling and images live here.

- `assets/css/style.css`
- `assets/images/pg-logo.png`

## Navigation behavior

The top-level menu item should do two things:

1. act as a clickable link to the topic landing page
2. open a dropdown with the related pages for that topic

That means the topic label is the navigation entry, and the dropdown is the menu list. The dropdown should not be the only way to reach the topic page.

## Topic landing pages

When you click a topic such as DCMS, Database, or User Experience, the landing page should show:

- a short topic introduction
- the list of pages in that topic
- optional tiles for the topic

The page title comes from the page itself. The menu label comes from the navigation data.

## Page descriptions

Page descriptions are what you see in the title bar next to the label. They should come from the page front matter when possible, or from the topic registry when the landing page is being generated.

Use the descriptions in `_data/topic_pages.yml` when you want to maintain the page list and the page descriptions in one place.

## Tile descriptions

Tile text should live in `_data/topic_pages.yml`, not inside every page file. That keeps topic tiles consistent and easier to edit.

## Images, diagrams, and bitmaps

Images should be stored in a tracked asset folder such as `assets/images/`.

Use them from Markdown with normal image links or HTML:

```md
![Database diagram](/assets/images/database-diagram.png)
```

For screenshots or SSMS diagrams, keep the image file separate and reference it from the page that needs it.

## What to keep consistent

- Keep menu labels short and stable.
- Keep page descriptions brief.
- Keep topic landing pages and the registry data in sync.
- Keep dropdowns limited to the pages in that topic.
- Keep the desktop layout readable, then simplify for mobile later.

## Editing workflow

When adding a new page:

1. Create the Markdown file in the right folder.
2. Add a `title`, `nav_label`, and `description` in front matter.
3. Add the page to `_data/topic_pages.yml`.
4. Add or update the dropdown entry in `_data/navigation.yml` if needed.
5. Build and check the page from the topic landing page and the menu.

When changing a topic:

1. Update the topic summary in `_data/topic_pages.yml`.
2. Update the topic landing page content.
3. Add or remove page links in the topic page list.
4. Adjust tile text if the topic has tiles.

## Notes

- The guide can stay in `docs/` as a helper page, but it is really a working reference.
- If you want a private-only note later, it can move to a non-published location, but this version is usable as a site guide.
- The goal is to keep the navigation, topic pages, and descriptions driven from the repo data instead of scattered through individual pages.
