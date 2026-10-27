---
layout: page
title: Managing Tiles
breadcrumb: Technical > Managing Tiles
description: Step-by-step instructions for adding and editing topic tiles.
permalink: /technical/managing-tiles/
topic_key: technical
---

# Managing Tiles

<a href="/welcome/glossary/" target="_blank" rel="noopener">Tiles</a> are the linked panels displayed above a page's content. A topic's tile list is shared by its pages; changing the list updates the tile row across that topic.

Tiles and dropdown navigation are configured separately. Update the topic's file at `_data/<topic>/topic.yml` to change its tiles. Update `_data/navigation.yml` only when you also want to change the site's dropdown menu.

### Add or edit tiles for a topic

1. **Find the topic key.** In `_data/navigation.yml`, find the top-level menu entry and note its `key`. For example, the Database menu has `key: database`. In the page's front matter, `topic_key` usually identifies the same topic.

2. **Open the topic data.** Open `_data/<topic>/topic.yml`, using the topic key for `<topic>` (for example, `_data/database/topic.yml`). Edit its `tiles` list. Do not add tiles under `pages`; `pages` supplies the topic landing-page list, while `tiles` supplies the tile row.

3. **Add or change a tile.** Each tile has a title, a short description, and a destination URL. Replace only the `tiles:` subsection; keep the file's other fields, such as `summary` and `pages`:

   ```yaml
   tiles:
     - title: Main Tables
       description: Overview of the database's main tables.
       url: /database/main-tables/
     - title: Database Schema
       description: Explore the database schema and relationships.
       url: /database/schema/
     - title: Database Diagrams
       description: View diagrams of the database structure.
       url: /database/diagrams/
   ```

   Keep the `tiles` list at the top level of the topic data file. The order in YAML is the display order. Copy the destination from the target page's `permalink` when it has one; otherwise use the URL Jekyll generates for that page.

4. **Configure three tiles for a full row.** The renderer displays the first three items. If fewer than three are configured, fewer tiles appear; items after the third are not shown.

5. **Preview the topic.** Open the topic page and one of its child pages. Confirm the tile titles, descriptions, order, and destinations. Keep descriptions concise because the tiles share a row.

To remove a tile, delete its entire list item (`- title`, `description`, and `url`). To change its order, move the whole item to another position in the list.

### Welcome tile group example

Most topic pages get their tiles from `_data/<topic>/topic.yml`. A page with `banner_tile_group: home` instead gets tiles from the matching key in `_data/home_topic_groups.yml`. For example, the Executive Summary page uses the `home` group:

```yaml
home:
  tiles:
    - title: Pyoderma Gangrenosum
      description: Plain-language PG background, including symptoms, related conditions, and care challenges.
      url: /about/pyoderma-gangrenosum/
    - title: ChatGPT Analysis
      description: Independent review of the Phase 1 site's strengths, usability, and room to improve.
      url: /phase-1/chatgpt-analysis/
    - title: Copilot Analysis
      description: Independent review of the Phase 1 site's strengths, usability, and room to improve.
      url: /phase-1/copilot-analysis/
```

Edit this list in `_data/home_topic_groups.yml` to change that tile group. The page's `banner_tile_group` value selects the group; it does not change the dropdown menu.

### Where the tile row comes from

The shared `_includes/topic-tiles.html` include chooses the matching topic or banner tile group and renders it in both the home and standard page layouts. To change tile spacing, borders, colors, or small-screen behavior, edit the `.pg-home-topic-grid` and `.pg-home-topic-tile` rules in `assets/css/style.css`.
