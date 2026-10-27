---
layout: page
title: Dynamic Content
nav_label: DCMS
description: How DCMS identifies, structures, and renders content records.
permalink: /dcms/dynamic-content/
updated: 2026-10-10
---

# Dynamic Content

In <a href="/welcome/glossary/" target="_blank" rel="noopener">DCMS</a>, a page of information is represented by a **ContentDocument** record and its associated **ContentElement** records. The document holds its identity and document-level metadata; elements hold the typed content blocks, such as text, markup, or media references. Lookup values describe the content type, format, MIME type, and workflow state.
### Intended content lifecycle

DCMS is intended to support a path from discovering useful information to reviewing and publishing it. The complete authoring and review workflow is not built yet; current documents are unpublished placeholders.

![Conceptual dynamic content lifecycle: sources are organized and reviewed in staging, approved content is published, then linked to menu items for display](/assets/images/dcms-content-lifecycle.svg)

### Menu item first, document identity next

A content menu item and its document have separate identifiers. The menu item is established first. DCMS then creates a placeholder ContentDocument linked to that MenuItem and assigns a ContentDocumentID. The content route can use that stable document ID before the article itself has been written.

This handles repeated titles naturally. A patient, caregiver, and provider can each have a “Diagnosis” menu item, with different audience masks and different ContentDocumentIDs. Their shared title does not create a slug collision or force all audiences to read the same article.

### Current content state

The current MenuItemList extract has 92 menu rows, including 70 content routes. The linked documents are placeholders marked Unknown, Draft, and unpublished. There are no authored PG articles in the current database. The schema includes ContentElement, but the current data does not yet contain the intended knowledge-base content.

The schema does not currently define a persisted SortOrder for ContentElement. That means the database does not promise editorial order for multiple blocks in a document. The ordering rule should be decided before multi-block articles are authored at scale.

### Rendering and next steps

The POC demonstrates numeric ContentDocumentID retrieval and typed-content rendering paths. A legacy title-based query remains for compatibility, but numeric identity is the canonical approach because titles can repeat. Building a reliable content library still requires authoring and review tools, source and review metadata, safe rendering rules, and a publication process that preserves existing content. Search also needs to be implemented; structured tables alone do not deliver a searchable knowledge base.

Read the [detailed content model](/dcms/DCMS_Dynamic_Content/) for the implementation notes, the [database schema](/database/schema/) for exact columns and seeded lookup values, and [Curating Content](/dcms/DCMS_Curating_Content/) for the planned editorial lifecycle.
