---
layout: page
title: Managing Pages
breadcrumb: Technical > Managing Pages
description: Add and maintain pages with the shared topic layout.
permalink: /technical/managing-pages.html
topic_key: technical
---

# Managing Pages

Each topic has a folder and an `index.md` landing page. Store a topic's supporting Markdown pages in that same folder. Every content page uses the same structure: site header, breadcrumb and description, then Markdown content. `_config.yml` applies the regular page layout by default; the home layout delegates to it, so topic landing pages have the same structure.

### Add a page

1. Create a Markdown file in the topic folder.
2. Add front matter for `title`, `description`, and the topic breadcrumb. For example:

   ```yaml
   ---
   layout: page
   title: Managing Pages
   breadcrumb: Technical > Managing Pages
   description: Add and maintain pages with the shared topic layout.
   permalink: /technical/managing-pages.html
   topic_key: technical
   ---
   ```

3. Add a Markdown `#` heading matching the page title.
4. Add the page to the topic's `pages` list in `_data/<topic>/topic.yml` and to its submenu in `_data/navigation.yml`.
5. Build the site and follow the links from the topic menu and landing page.

Use `_layouts/page.html` for a regular document and `_layouts/home.html` for a topic landing page. Keep `topic_key`, breadcrumb, and folder aligned. The shared tile include selects tile data from the page's topic folder; it can use `topic_key` or the breadcrumb as a fallback. If no tiles are configured, no tile links appear. The breadcrumb description uses `description`, falling back to the page title when no description is supplied.
