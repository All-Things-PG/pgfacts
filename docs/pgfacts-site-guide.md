---
layout: page
title: PG Facts Site Guide
nav_label: Welcome
description: How the site is structured and maintained.
permalink: /docs/pgfacts-site-guide/
---

# PG Facts Site Guide

This page is the working guide for the PG Facts site structure, navigation, and content model.

## Purpose

PG Facts is a Phase 2 documentation site for All Things PG. It is organized around a small set of topics:

- Welcome
- User Experience
- DCMS
- Database
- About

Each topic has a landing page and a shared set of topic tiles or linked documents.

## How the site is organized

- **`_data/navigation.yml`** stores the top-level menu labels and descriptions.
- **`_data/topic_pages.yml`** stores the page lists, tile lists, and topic summary text.
- **`_includes/site-header.html`** renders the shared header and dropdown menus.
- **`_includes/page-banner.html`** renders the title bar with menu label and page description.
- **`_includes/site-gate.html`** renders the site-wide admin gate.
- **`_layouts/home.html`** renders topic landing pages with their shared tile grid.
- **`_layouts/page.html`** renders the individual content pages.

## Topic landing pages

Each topic folder has an `index.md` file that acts as the landing page for that topic.
Those pages should:

1. Introduce the topic with a short summary.
2. Show a list of related pages or tiles.
3. Keep the page title in the Markdown file.
4. Keep the breadcrumb/title-bar label in the menu data.

## Editing rules

- Add or edit menu labels in `_data/navigation.yml`.
- Add or edit page descriptions, landing summaries, and tile text in `_data/topic_pages.yml`.
- Keep the short page title in each document's front matter.
- Use `nav_label` in page front matter when the breadcrumb should match the top-level menu item.
- Use `description` in page front matter for the title bar description.

## Menu behavior

- Top-level items open dropdown menus.
- The dropdown content comes from the topic registry when available.
- The contact button stays in the header.

## Images and diagrams

Images should live in `assets/images/` or another tracked asset folder and be referenced from Markdown with normal image links or HTML.
Database diagrams, SSMS exports, screenshots, and similar bitmap files can be embedded in pages when needed.

## Current content model

- **DCMS** explains the content model, dynamic menus, and content flow.
- **Database** explains the data model and future persistent features.
- **User Experience** explains portal experiences by visitor type.
- **About** holds project and contact information.

## Notes

- The site uses a static build, so all navigation and content relationships need to be defined in the repo.
- Keep the landing pages and topic registry in sync to avoid dead links.
- Keep the header and title bar layout stable to avoid visual shifts between pages.
