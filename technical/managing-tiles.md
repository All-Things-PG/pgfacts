---
layout: page
title: Managing Tiles
breadcrumb: Technical > Managing Tiles
description: Step-by-step instructions for adding and editing topic tiles.
permalink: /technical/managing-tiles.html
---

# Managing Tiles

Tiles are the linked panels displayed above a page's content. A topic's tile list is shared by its pages; changing the list updates the tile row across that topic.

Tiles and dropdown navigation are configured separately. Update `_data/topic_pages.yml` to change tiles. Update `_data/navigation.yml` only when you also want to change the site's dropdown menu.

### Add or edit tiles for a topic

1. **Find the topic key.** In `_data/navigation.yml`, find the top-level menu entry and note its `key`. For example, the Database menu has `key: database`. In the page's front matter, `topic_key` usually identifies the same topic.

2. **Open the topic data.** In `_data/topic_pages.yml`, find the top-level entry with that key. Edit its `tiles` list. Do not add the tiles under `pages`; `pages` supplies the topic landing-page list, while `tiles` supplies the tile row.

3. **Add or change a tile.** Each tile has a title, a short description, and a destination URL:

	 Replace only the `tiles:` subsection under `database:`; keep its other fields, such as `summary` and `pages`:

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

	 Keep the `tiles` list under the topic key, using the same indentation as the example. The order in YAML is the display order. Copy the destination from the target page's `permalink` when it has one; otherwise use the URL Jekyll generates for that page.

4. **Keep the tile row between three and five items.** The renderer displays at most five tiles. If the list has fewer than three, it fills the row with non-linked `Default Tile` placeholders. A list of three to five avoids placeholders and keeps all chosen tiles visible.

5. **Build and check the topic.** Run `bundle exec jekyll build`, then open the topic page and one of its child pages. Confirm the tile title, description, order, and destination. Tile descriptions should be concise because tiles in a row share a height.

To remove a tile, delete its entire list item (`- title`, `description`, and `url`). To change its order, move the whole item to another position in the list.

### Welcome tile group example

Most topic pages get their tiles from `_data/topic_pages.yml`. A page with `banner_tile_group: home` instead gets tiles from the matching key in `_data/home_topic_groups.yml`. For example, the Executive Summary page uses the `home` group:

```yaml
home:
  tiles:
    - title: DCMS
      description: Document the content model and menus.
      url: /dcms/
    - title: User Experience
      description: Explore the portal experiences for site visitors.
      url: /user-experience/
    - title: Database
      description: Browse the data model and schema.
      url: /database/
```

Edit this list in `_data/home_topic_groups.yml` to change that tile group. The page's `banner_tile_group` value selects the group; it does not change the dropdown menu.

### Where the tile row comes from

The shared `_includes/topic-tiles.html` include chooses the matching topic or banner tile group and renders it in both the home and standard page layouts. To change tile spacing, borders, colors, or small-screen behavior, edit the `.pg-home-topic-grid` and `.pg-home-topic-tile` rules in `assets/css/style.css`.
