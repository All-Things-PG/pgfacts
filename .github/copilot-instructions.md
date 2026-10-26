# Copilot instructions for `pgfacts`

## Repository shape

This repository is the source for the All Things PG Phase 2 documentation site. It is primarily a Jekyll static site; it is not the Phase 2 database-backed application itself.

- Markdown pages are grouped by documentation topic (`welcome`, `phase-1`, `phase-2`, `new-features`, `technical`, `dcms`, `database`, `user-experience`, and `about`).
- `_layouts/` and `_includes/` provide the shared page shell, banner, navigation, topic tiles, site gate, and back-to-top behavior. `_config.yml` assigns the regular `page` layout by default.
- `_data/navigation.yml` is the source for the main menu and submenus. Topic metadata under `_data/<topic>/topic.yml` supplies landing-page lists, summaries, and shared tiles. `_data/home_topic_groups.yml` supplies tile groups selected with `banner_tile_group`.
- `assets/` contains the site stylesheet and images. `_site/` and `.jekyll-cache/` are generated output and are ignored.
- `migration/` contains SQL Server migration/capture scripts and one PowerShell capture script. These scripts target the separate `Migration` and `AllThingsPG` databases and are not part of the Jekyll build.

The database/DCMS documentation describes a planned or prototyped Phase 2 system. Do not describe documented designs as production capabilities unless the source explicitly says they are implemented or in use.

## Build, preview, and checks

The Ruby dependencies are locked in `Gemfile.lock` (Jekyll 4.3.x and `jekyll-feed`). Install dependencies with Bundler before running site commands:

```powershell
bundle install
bundle exec jekyll build
bundle exec jekyll serve --livereload
```

`jekyll build` is the repository's primary validation check. `jekyll serve` previews the generated site locally; the root page redirects to `/welcome/home/`. There is no configured automated test suite or lint task. For a focused content change, run the build after editing the affected Markdown/data/layout files; there is no smaller single-test command.

Migration scripts are run individually in the intended SQL Server database, normally from SSMS or an equivalent SQL client. Follow `migration/README.md` for the required order and database context. Run `003_capture_phase1_source.ps1` only when intentionally capturing the Phase 1 source; do not run migration imports or publishing routines casually. The migration design notes say to use the database project's corresponding `Testing` scripts for broader database tests, but that project is outside this repository.

## Adding and editing documentation pages

Use YAML front matter on every rendered Markdown page. For a normal page, follow the established pattern:

```yaml
---
layout: page
title: Page title
breadcrumb: Topic > Page title
description: Short text shown in the page banner.
permalink: /topic/page-name/
topic_key: topic
---
```

Then use a Markdown `#` heading matching the title. Keep the file in the matching topic folder. When adding a page, update both:

1. `_data/<topic>/topic.yml` under `pages` so the topic landing page lists it.
2. `_data/navigation.yml` under the relevant submenu so visitors can reach it.

Keep the page folder, `topic_key`, breadcrumb topic, navigation key, and data-file topic aligned. Use an explicit `permalink` matching nearby pages (normally with a trailing slash). Existing legacy pages may use `.html` or older data structures; preserve those URLs unless the task explicitly includes a URL migration.

Use `layout: home` only for topic landing pages that intentionally use the home layout. The regular `page` layout renders the same shared page content shell and topic tiles. `page.description` is also the banner description; `page.work_in_progress` defaults to showing the work-in-progress label, so set `work_in_progress: false` only when that is intentional.

## Navigation and tiles

Navigation and tiles are separate concerns:

- Change `_data/navigation.yml` for dropdown menu labels, order, destinations, and children.
- Change `_data/<topic>/topic.yml` for a topic's shared tile row and landing-page list.
- Change `_data/home_topic_groups.yml` when a page uses `banner_tile_group`.

The `topic-tiles.html` include chooses a banner group first, then topic data based on the page directory, then `topic_key`/legacy data fallbacks. It renders only the first three tiles, in YAML order. Each tile should provide `title`, `description`, and a site-relative `url`. Do not put tile entries under the `pages` key.

Use site-relative URLs such as `/database/schema/`; templates apply `relative_url` for the configured site path. Keep navigation labels, page permalinks, and tile destinations synchronized when renaming or moving content.

## SQL migration conventions

Migration SQL is SQL Server-specific. Scripts generally use `SET NOCOUNT ON`, `SET XACT_ABORT ON`, explicit database guards, rerunnable `IF OBJECT_ID`/`COL_LENGTH` checks, and transactions. Preserve those conventions when extending scripts.

The intended flow is source capture in `Migration`, source-side `Migration.dbo.Import_ATPG` returning the documented menu result shape, target-side import into `AllThingsPG.dbo.MasterMenuStage`, review/validation, and only then the existing menu population workflow. Do not write directly to `MasterMenu` when the staged import flow is required. Preserve source identifiers and the `HtmlMenu` to `HtmlPages` relationship; do not infer matches from title tokens.

`migration/README.md` is the operational reference for the current ATPG menu import contract and script order. `docs/Migration_Import_Design.md` is a working design note and may describe unresolved choices; distinguish it from the implemented contract.

## Content and documentation conventions

Prefer the existing topic/page terminology and shared includes over creating one-off layouts or navigation markup. Keep descriptions concise because they appear in banners and tile rows. Treat `_data` YAML as behavior/configuration, not just presentation: small changes can alter the whole site's navigation or repeated tile rows.

When changing schema, routing, menu, or migration behavior, update the relevant canonical documentation as well as any linked inventory or navigation entry. Avoid editing generated `_site` output; rebuild it instead.
