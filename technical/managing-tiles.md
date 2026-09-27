---
layout: page
title: Managing Tiles
breadcrumb: Technical > Managing Tiles
description: Configure the topic tile bar shared by pages in each topic.
permalink: /technical/managing-tiles.html
topic_key: technical
---

# Managing Tiles

The tile bar is rendered before page content by `_includes/topic-tiles.html`, shared by the home and standard page layouts. Pages in the same topic use the same tile list, including pages reached from a topic's dropdown menu.

## Configure a topic's tiles

Edit the topic's `tiles` list in `_data/topic_pages.yml`. Each item has a title, destination URL, and a short description:

```yaml
tiles:
  - title: Site Overview
    description: The shared layout and files that shape each page.
    url: /technical/site-overview.html
```

The Welcome page uses `_data/home_topic_groups.yml` instead. Keep a topic's tile list between three and five items. The layout displays at most five; if fewer than three are configured, it fills the remaining spaces with non-linked “Default Tile” placeholders.

Tiles share the available row width and height. The row stays on one line; on narrow screens it can scroll horizontally. Descriptions should be brief because the longest one determines the height of every tile in that row.

To change spacing, borders, colors, or responsive behavior, edit the `.pg-home-topic-grid` and `.pg-home-topic-tile` rules in `assets/css/style.css`.