---
layout: page
title: Curating Content
breadcrumb: DCMS > Curating Content
description: Workflow for collecting, reviewing, and publishing structured content.
updated: 2026-09-18
---
# DCMS - Curating Content

## Overview

DCMS curating content means taking trusted PG information from many sources and turning it into structured content that can be searched, reused, and managed without hard-coding everything by hand.

The main idea is simple: content should be connected to menu items, supported by search, and moved through a review workflow before it reaches production.

## FAQ

### What is curating content?

Curating content is identifying useful material, breaking it into manageable pieces, and storing it in a way that can be assembled into pages and reused across the site.

At its core, it means:

- review and organize content before publishing
- keep content separate from presentation
- reuse the same content in more than one place
- support different content types over time
- keep the site maintainable as it grows

### How do we migrate content from Phase 1 to Phase 2?

Migration is the bridge from legacy content into the Phase 2 model. The first pass can use staging tables or other temporary structures to capture content, review it, and decide what belongs in production.

### How does content data move through the system?

The general flow is:

1. capture legacy content into migration tables
2. move migration data to staging for review
3. map the content to menu items
4. refine the page format using the content block information
5. publish the content, which moves data from staging to production

For the POC, the goal is to get useful content into the site correctly, not to rush past review.

### Content curation vs content storage?

A page is not valuable because it exists in a database. It is valuable because it is understandable, accurate, and easy to maintain. Curating content is the process that makes that possible.

Good curation helps the organization:

- ensure the content is accurate
- keep content aligned with the audience
- avoid duplicates and dead ends
- present content in the right order
- present content linked to a good menu item

This is especially important for a rare-disease organization, where clarity and trust matter.

### What can be improved later?

The first pass does not need to be perfect.

Later improvements might include:

- richer metadata
- notes and history
- content versioning and status
- page-level migration tracking
- better element-level structure
- better mapping between old and new titles
- more precise treatment of forms, lists, and special cases
- a GUI interface for drag and drop

### Why is this a strong foundation?

The content curation model is strong because it supports both speed and control while keeping the content accurate and useful.

When completed:

- anyone can curate content
- we can identify new content outside of the organization
- preserve important content and discard the rest
- improve the structure over time
- keep the site maintainable
- prepare for future growth without rethinking the entire system
- build the framework first, then use it to load content

For sponsors, that means the platform is not a one-time build. It is an asset that can continue to improve.

### Summary

Curating content in DCMS is about moving useful PG material into a structured system where it can be reviewed, reused, searched, and published safely.

### Cleanup notes

- The page still repeats the same idea in a few places: DCMS as a content model, DCMS as a knowledge-base enabler, and DCMS as a workflow.
- The migration / staging / approval story is useful, but it overlaps with the general curating concept and could be shortened more.
- The document still mixes concept, workflow, and implementation detail; that is the main source of repetition.
- The Phase 3 GUI discussion is a side topic and could be trimmed further if you want this page to stay purely conceptual.
