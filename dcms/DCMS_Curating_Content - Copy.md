---
layout: page
title: Curating Content
breadcrumb: DCMS > Curating Content
description: Workflow for collecting, reviewing, and publishing structured content.
updated: 2026-09-18
---
# DCMS - Curating Content

## Overview

Phase 2 of the ATPG website will add many new features, including a searchable Knowledge Base at its central core.  The Knowledge Base will hold many types of information, such as a list of wound care clinics, medical providers, current research, clinical trials, medical universities, and **curated content**.  In Phase 1, we told a developer what content we wanted on a set of static web pages.  For Phase 2, we will start with that same set of web pages, but will be able to add new information through the process of curating content from internal and external sources, with the work being done by a curator.  

The content can be on any subject related to PG, such as wound care articles, pain management, patient success stories, diagnosis and treatment etc. Any content discovered by the curator can become content linked to a menu item in the ATPG database.  One of the essential duties of the curator is to ensure the accuracy of the material, so that anything published on the website remains trusted, vetted and valuable.  Curated content becomes part of the Knowledge Base and is therefor searchable, exposing a list of Menu Items associated with the content.

## FAQ

### What is curating content?

Curating content is the work of a curator, who has a reponsiblity to identify useful material, ensure its accuracy, break it into manageable pieces, and store it in a way that can be assembled into web pages.

At its core, it means to:

- migrate information in Phase 1 to the staging database
- add additional content from internal and external sources
- add media where appropriate
- review for accuracy before publishing
- publish content from staging to production

### How do we migrate content from Phase 1 to Phase 2?

Migration is the bridge from legacy content into the the new Phase 2 Knowledge Base. The first pass will copy information from the static web pages and load into staging where it can be reviewed and linked to menu items. The second pass will publish the data from staging to production.  At that point, same or similar menu items will display the same or similar content as Phase 1.

### How does content move from Phase 1 to Phase 2?

The general flow is:

1. capture legacy content and move into migration tables
2. create the set of Phase 2 menu items
3. map legacy content to new menu items
4. load migration data into staging
5. publish content from staging to production
6. test the menu item and content structure using the Proof of Concept website

### Content curation vs content storage?

A page is not valuable because it exists in a database. It is valuable because it is understandable, accurate, and easy to maintain. Curating content is the process that makes that possible. Curating content is more than just collecting articles on PG.  The curator is also responsible for to maintain clarity and trust, deciding on what is and isn't vetted information.  Proper curation will:

- ensure the content is accurate
- keep content aligned with the audience
- avoid duplicates and dead ends
- present content in the right order
- present content linked to an appropriate menu item

### What parts of curation will be in Phase 2 vs Phase 3?

We can get ridiculous if we want to, and build a completley new tool to allow a full set of utilities to make curation possible. Realistically, we have to set Phase 2 goals that are achievable, and leave something remaining for Phase 3. As time goes only, a detailed list of Phase 2 enhancments will become part of a contract, with a clearly defined start and end date.  Content curation will be part of that, with the primary goal of copying Phase 1 data, and the ability to add new times.  What has yet to be defined is the level and scope of any additional curation tools and utilities.

Potential improvements for Phase 3 might include:

- a modern GUI to support management of content in the staging database
- richer metadata support
- notes and history, tracking activities and such
- content versioning and status
- page-level migration tracking
- better element-level structure
- better mapping between old and new titles
- more precise treatment of forms, lists, and special cases
- a GUI interface for drag and drop

### Why is Phase 2 a strong foundation?

The content curation model in Phase 2 is strong because it supports the ability to discover content from any source and load it as trusted information in the Knowledge Base.  Its the framework itself that is powerful, which is a combination of staging and production tables loading into a central searchable knowledge base. We also have DCMS which allows adding dynamic content and associating it with dynamic menu items.

Additional benefits of the new design include:

- anyone can curate content
- we can identify new content outside of the organization
- preserve only important content and discard the rest
- improve the structure over time
- keep the site maintainable
- prepare for future growth without rethinking the entire system
- build the framework first, then use it to load content

For sponsors, it also comforting to know that the platform is not a one-time build. It is an asset that continues to grow and improve without additional releases.

### Summary

Curating content inside of the DCMS framework is about moving useful PG information from any source into a structured, searchable knowledge base linked to the menuing system. The technical process of curation goes through the staging database, and the process of publishing runs various tests that ensures the accuracy of the production database.

