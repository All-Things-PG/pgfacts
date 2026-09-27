---
layout: page
title: Site Overview
breadcrumb: Technical > Site Overview
description: How the site layouts and shared page elements fit together.
permalink: /technical/site-overview.html
topic_key: technical
---

# Site Overview

Every page uses the same outer structure: the site header, a breadcrumb and short description, the topic tile bar, and the page content. The Markdown page supplies its own title in the content.

The main layout files are:

- `_layouts/default.html` includes the site header and page banner around the page layout.
- `_layouts/page.html` and `_layouts/home.html` place the shared topic tiles before the page content.
- `_includes/site-header.html` renders the logo and menu from `_data/navigation.yml`.
- `_includes/page-banner.html` renders the breadcrumb and page description.
- `_includes/topic-tiles.html` chooses the topic tiles from `_data/topic_pages.yml` or the home tiles from `_data/home_topic_groups.yml`.
- `assets/css/style.css` controls the shared visual styling.

For the full file-by-file maintenance guide, see the [PG Facts Site Guide]({{ '/docs/pgfacts-site-guide/' | relative_url }}).