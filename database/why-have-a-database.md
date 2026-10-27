---
layout: page
title: Why have a database?
nav_label: Database
description: Why Phase 2 uses a relational database.
permalink: /database/why-have-a-database/
---

# Why Phase 2 Has a Database

As discused in other areas of the <a href="/welcome/glossary/" target="_blank" rel="noopener">documentation site</a>, All Things PG needs a database in order to add new features and capabilites for growth in the future. The Phase 1 static website fine for early Foundational presense, but ATPG has grown and so has our list of activite.  This has opened up and created new opportunites that can be reflected in Phase 2.  Additionally, we have the Leo Grant with a list of new features that MUST be added, and that will require a database.

In most cases, and application is more than a collection of fixed pages. its about data. Data is content.  A nonprofit organization can collect content about their missiona and purpose, in our case its all about Pyoderma Gangrenosum.

Phase 2 plans a Knowledge Base built on the DCMS architecture, and DCMS is a a database that store information about Patients, caregivers, providers, and other visitors that have different paths to information that solves their particular problem.  DCMS is about offerring solutions not just data, and it does so by being Dynamic, with the ability to have data-driven content and menus.

A relational database gives DCMS a place to store those relationships explicitly. A menu item has a stable MenuItemID, a parent, a route type, a route target, an order, and a visitor mask. A content document is linked to its menu item and has its own ContentDocumentID. Typed content elements hold the document's text, markup, media references, or other blocks; the current schema does not persist editorial block order. Lookup tables constrain values such as route type, content type, format, MIME type, visitor type, and workflow status.

That model supports capabilities a static site cannot provide by itself:

- Change the menu hierarchy, order, routes, and audience visibility as data.
- Give the same familiar menu title different content records for different audiences.
- Store articles as structured documents made of typed elements instead of flattening all content into one file.
- Import, map, validate, and review content before it reaches the live content tables.
- Build provider, wound-care, mental-health, rehabilitation, research, and clinical-trial directories as related, searchable data when those features are developed.

Having a database will give us unlimited opportunites for expansion and to the things we want to do.