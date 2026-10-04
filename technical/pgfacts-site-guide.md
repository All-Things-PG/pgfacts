---
layout: page
title: PG Facts Site Guide
nav_label: Technical
breadcrumb: Technical > PG Facts Site Guide
description: How the site is structured and maintained.
permalink: /technical/pgfacts-site-guide/
topic_key: technical
---

# PG Facts Site Guide

This is the working guide for maintaining the PG Facts Documentation site. This explains where the navigation comes from, which files control page content, how topic tiles are built, and what to edit when you want to add or change descriptions.

## Site overview

Every page has the same layout structure: the site header, a breadcrumb and short description bar, the topic tile bar, and the page content from an MD file. The Markdown page supplies its own title in the content as the first line with a single #.

The main layout files are:

<table class="topic-table">
	<thead>
		<tr>
			<th>File</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><a href="{{ '/_layouts/default.html' | relative_url }}">_layouts/default.html</a></td>
			<td>Includes the site header and page banner around the page layout.</td>
		</tr>
		<tr>
			<td><a href="{{ '/_layouts/page.html' | relative_url }}">_layouts/page.html</a> and <a href="{{ '/_layouts/home.html' | relative_url }}">_layouts/home.html</a></td>
			<td>Place the shared topic tiles before the page content.</td>
		</tr>
		<tr>
			<td><a href="{{ '/_includes/site-header.html' | relative_url }}">_includes/site-header.html</a></td>
			<td>Renders the logo and menu from <a href="{{ '/_data/navigation.yml' | relative_url }}">_data/navigation.yml</a>.</td>
		</tr>
		<tr>
			<td><a href="{{ '/_includes/page-banner.html' | relative_url }}">_includes/page-banner.html</a></td>
			<td>Renders the breadcrumb and page description.</td>
		</tr>
		<tr>
			<td><a href="{{ '/_includes/topic-tiles.html' | relative_url }}">_includes/topic-tiles.html</a></td>
			<td>Chooses the topic tiles from <a href="{{ '/_data/topic_pages.yml' | relative_url }}">_data/topic_pages.yml</a> or the home tiles from <a href="{{ '/_data/home_topic_groups.yml' | relative_url }}">_data/home_topic_groups.yml</a>.</td>
		</tr>
		<tr>
			<td><a href="{{ '/assets/css/style.css' | relative_url }}">assets/css/style.css</a></td>
			<td>Controls the shared visual styling.</td>
		</tr>
	</tbody>
</table>

## What is front matter?

Front matter are fields used by Jekyll as metadata to control the visible content of the document on the page. Each Markdown file starts with front matter, and the exact fields depend on the page type. For the full list of fields and examples, see the [Front Matter section](#front-matter-fields).

### The main idea

The site is organized around these topics, in menu order:

1. Welcome
2. Phase 1
3. Phase 2
4. New Features
5. DCMS
6. Database
7. User Experience
8. About

Each topic has:

- a top-level menu item
- a topic landing page
- a shared tile bar
- page descriptions for the linked documents

The top-level menu item links to its topic landing page and also opens its submenu. Every page in a topic uses the same header, breadcrumb and description bar, tile bar, and content layout.

## Front matter fields

The most common fields are:

<table class="topic-table">
	<thead>
		<tr>
			<th>Field</th>
			<th>Purpose</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>layout</code></td>
			<td>Selects the page wrapper. Common options here are <code>page</code>, <code>home</code>, and <code>redirect</code>.</td>
		</tr>
		<tr>
			<td><code>title</code></td>
			<td>The page title shown in the browser and on the page.</td>
		</tr>
		<tr>
			<td><code>description</code></td>
			<td>Short description in the page banner.</td>
		</tr>
		<tr>
			<td><code>permalink</code></td>
			<td>The public URL for the page.</td>
		</tr>
		<tr>
			<td><code>nav_label</code></td>
			<td>Top-level menu label shown in the breadcrumb/title bar.</td>
		</tr>
		<tr>
			<td><code>breadcrumb</code></td>
			<td>Full breadcrumb trail for the page banner.</td>
		</tr>
		<tr>
			<td><code>topic_key</code></td>
			<td>Looks up the matching topic in <a href="{{ '/_data/topic_pages.yml' | relative_url }}">_data/topic_pages.yml</a> for tiles and page lists.</td>
		</tr>
		<tr>
			<td><code>banner_tile_group</code></td>
			<td>Uses a non-topic tile group from <a href="{{ '/_data/home_topic_groups.yml' | relative_url }}">_data/home_topic_groups.yml</a>.</td>
		</tr>
		<tr>
			<td><code>redirect_to</code></td>
			<td>Sends a redirect page to another URL.</td>
		</tr>
	</tbody>
</table>

## What to edit for what purpose

### Change a menu label, menu order, or top-level menu description

Edit:

- [_data/navigation.yml](../_data/navigation.yml)

This file controls the top-level menu labels and the basic descriptions associated with them.

### Change the topic landing text, tile list, or document list

Edit:

- [_data/topic_pages.yml](../_data/topic_pages.yml)

This file is the main source of truth for:

- topic summaries
- topic landing page document lists
- topic tile text and destinations
- page descriptions used in the topic tables

### Redirects

Redirect pages use `layout: redirect` and a `redirect_to` value. The redirect layout sends visitors to the target page and keeps older links working after content moves.

Current redirect examples in this site:

- [index.md](../index.md) redirects `/` to `/home/`

The redirect behavior itself is defined in [_layouts/redirect.html](../_layouts/redirect.html).

### Change the header/menu behavior

Edit:

- [_includes/site-header.html](../_includes/site-header.html)

This file controls:

- the logo
- the top navigation
- dropdown behavior
- the contact button

### Change the page title bar or breadcrumb-like label

Edit:

- [_includes/page-banner.html](../_includes/page-banner.html)

This is where the menu/topic label and short description appear under the header.

### Change the site-wide gate

Edit:

- [_includes/site-gate.html](../_includes/site-gate.html)
- [assets/css/style.css](../assets/css/style.css)

The gate is the overlay shown before access. The code is case-insensitive for `ATPG`.

### Change the layout for topic pages or standard pages

Edit:

- [_layouts/home.html](../_layouts/home.html)
- [_layouts/page.html](../_layouts/page.html)
- [_layouts/default.html](../_layouts/default.html)

These control the page wrappers. Both layouts use [_includes/topic-tiles.html](../_includes/topic-tiles.html) to render the correct tile bar before page content.

### Change the site look and spacing

Edit:

- [assets/css/style.css](../assets/css/style.css)

This file controls:

- logo size
- menu spacing
- dropdown width
- page title bar spacing
- tile widths
- table styling
- gate styling

### Change the front matter rules or examples

The front matter guidance now lives in this page. Use the front matter section above when you need the common field definitions or the recommended minimal sets.

## Folder structure

### `home/`

The home section contains the landing page for the site.

- [home/index.md](../home/index.md) is the home page entry point
- [home/home.md](../home/home.md) is the page content that appears on the home page

### `dcms/`

This folder contains the DCMS topic pages.

- [dcms/index.md](../dcms/index.md) is the DCMS landing page
- [dcms/what-is-dcms.md](../dcms/what-is-dcms.md)
- [dcms/dynamic-content.md](../dcms/dynamic-content.md)
- [dcms/dynamic-menus.md](../dcms/dynamic-menus.md)
- and the other DCMS-related documents

### `database/`

This folder contains the database topic pages.

- [database/index.md](../database/index.md) is the Database landing page
- [database/why-have-a-database.md](../database/why-have-a-database.md)
- [database/main-tables.md](../database/main-tables.md)
- [database/schema.md](../database/schema.md)
- [database/diagrams.md](../database/diagrams.md)

### `user-experience/`

This folder contains the persona / portal pages.

- [user-experience/index.md](../user-experience/index.md) is the User Experience landing page
- [user-experience/what-is-a-portal.md](../user-experience/what-is-a-portal.md)
- [user-experience/selecting-a-user-experience.md](../user-experience/selecting-a-user-experience.md)
- [user-experience/patients.md](../user-experience/patients.md)
- [user-experience/caregivers.md](../user-experience/caregivers.md)
- [user-experience/providers.md](../user-experience/providers.md)
- [user-experience/pharmaceutical.md](../user-experience/pharmaceutical.md)
- [user-experience/guest.md](../user-experience/guest.md)

### `technical/`

This folder contains the working documentation and maintenance guides for the site.

- [technical/index.md](../technical/index.md) is the Technical topic landing page
- [technical/managing-tiles.md](../technical/managing-tiles.md)
- [technical/managing-pages.md](../technical/managing-pages.md)
- [technical/pgfacts-site-guide.md](../technical/pgfacts-site-guide.md) is the full maintenance guide

### `docs/`

This folder contains older public documentation and archive-style supporting pages.

- [docs/index.md](../docs/index.md) is the Documents page
- [docs/executive-summary.md](../docs/executive-summary.md)
- [docs/curating-content.md](../docs/curating-content.md)
- [docs/managing-tiles.md](../docs/managing-tiles.md)
- [docs/portal-experience.md](../docs/portal-experience.md)

### `_data/`

This folder stores the site’s structured data.

- [_data/navigation.yml](../_data/navigation.yml) controls the top menu
- [_data/topic_pages.yml](../_data/topic_pages.yml) controls topic summaries, tiles, and page lists

### `_includes/`

Reusable pieces of the layout live here.

- [_includes/site-header.html](../_includes/site-header.html)
- [_includes/page-banner.html](../_includes/page-banner.html)
- [_includes/site-gate.html](../_includes/site-gate.html)

### `_layouts/`

Page templates live here.

- [_layouts/default.html](../_layouts/default.html)
- [_layouts/home.html](../_layouts/home.html)
- [_layouts/page.html](../_layouts/page.html)
- [_layouts/redirect.html](../_layouts/redirect.html)

### `assets/`

Shared styling and images live here.

- [assets/css/style.css](../assets/css/style.css)
- [assets/images/pg-logo.png](../assets/images/pg-logo.png)

## Navigation behavior

The top-level menu item should do two things:

1. act as a clickable link to the topic landing page
2. open a dropdown with the related pages for that topic

That means the topic label is the navigation entry, and the dropdown is the menu list. The dropdown should not be the only way to reach the topic page.

## Topic landing pages

When you click a topic such as Phase 1 or Phase 2, the landing page should show:

- a short topic introduction
- the list of pages in that topic
- the topic tile bar, followed by the page content

The page title is a Markdown heading in the page content. The menu label comes from the navigation data.

## Page descriptions

Page descriptions are what you see in the title bar next to the label. They should come from the page front matter when possible, or from the topic registry when the landing page is being generated.

Use the descriptions in [_data/topic_pages.yml](../_data/topic_pages.yml) when you want to maintain the page list and the page descriptions in one place.

## Tile descriptions

Tile text should live in [_data/topic_pages.yml](../_data/topic_pages.yml), not inside every page file. Welcome tiles live in [_data/home_topic_groups.yml](../_data/home_topic_groups.yml). The shared tile include resolves the topic using the page's `topic_key`, breadcrumb, or `nav_label`, so pages within a topic share a tile list.

Each tile row displays at least three and at most five tiles. Missing entries are shown as non-linked “Default Tile” placeholders. Tiles have equal height, share the row width, and remain on one line; narrow screens can scroll the row horizontally.

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

1. Create the Markdown file in the topic folder.
2. Add `title`, `description`, a topic breadcrumb, and a permalink in front matter.
3. Add a Markdown `#` heading for the visible page title.
4. Add the page to [_data/topic_pages.yml](../_data/topic_pages.yml) and [_data/navigation.yml](../_data/navigation.yml).
5. Build and check the page from the topic landing page and the menu.

When changing a topic:

1. Update the topic summary in [_data/topic_pages.yml](../_data/topic_pages.yml).
2. Update the topic landing page content.
3. Add or remove page links in the topic page list.
4. Adjust tile text if the topic has tiles.

## Notes

- The guide can stay in `docs/` as a helper page, but it is really a working reference.
- If you want a private-only note later, it can move to a non-published location, but this version is usable as a site guide.
- The goal is to keep the navigation, topic pages, and descriptions driven from the repo data instead of scattered through individual pages.
