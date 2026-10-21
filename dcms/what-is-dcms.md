---
layout: page
title: What is DCMS?
nav_label: DCMS
description: How database-driven content and audience-aware navigation form the Phase 2 platform.
permalink: /dcms/what-is-dcms/
updated: 2026-10-10
---

# What is DCMS?

DCMS means **Dynamic Content and Menuing System**. It is the design behind a Phase 2 website where navigation and content are managed as related data, so the site can grow beyond a collection of fixed pages.

The design connects four pieces:

1. **Audience:** a visitor chooses or is associated with a perspective such as patient, caregiver, provider, pharmaceutical, or guest.
2. **Menu:** database records define the menu hierarchy, labels, order, route, and audiences that can see each item.
3. **Content:** a menu item can link to a structured document made of typed elements. Different audience branches can use the same title and still point to distinct documents.
4. **Experience:** the website uses those records to present relevant navigation and content, with application pages and tools alongside the knowledge base.

For example, a patient and a provider may both see a menu item called “Diagnosis.” Each menu item has a different identity and can link to a different document, allowing the provider version to include more technical detail. The system does not depend on deriving a unique content slug from the shared title.

### What is implemented now

The SQL Server project defines the DCMS tables, constraints, lookup data, views, and stored procedures. The Razor proof of concept demonstrates database-driven menus, visitor filtering, route handling, and content retrieval. A menu import process loads Master_Menu.csv, creates staged menu records, validates them, and publishes the menu structure. Content-route items receive placeholder documents so each has a ContentDocumentID before an article is written.

The current database contains a menu structure and unpublished placeholder documents, but no authored or published PG articles. The import and migration publication routines also rebuild content, so they need preservation behavior before routine updates are made against an authored library.

### What DCMS is intended to make possible

DCMS is the content and navigation foundation for a searchable PG knowledge base: patient and caregiver education, provider resources, research and clinical trials, lived experience, and structured directories such as providers and care facilities. Those capabilities require populated and reviewed information, appropriate curation workflows, and application features such as search. The schema makes those directions possible; it does not mean those features are already delivered.

Continue with [Dynamic Content](/dcms/dynamic-content/) to see how documents and blocks are represented, or [Dynamic Menus](/dcms/dynamic-menus/) to see how menu data selects navigation and destinations. The [database section](/database/) documents the implemented relational model.

For the implementation-level references, see [content structure](/dcms/DCMS_Dynamic_Content/), [menu behavior](/dcms/DCMS_Dynamic_Menus/), and the [menu publication workflow](/dcms/DCMS_Menu_Workflow/).
