---
layout: page
title: Curating Content
breadcrumb: DCMS > Curating Content
description: How structured PG content will be captured, reviewed, and published.
updated: 2026-10-10
permalink: /dcms/DCMS_Curating_Content/
---

# Curating Content in DCMS

<a href="/welcome/glossary/" target="_blank" rel="noopener">DCMS</a> is designed to hold a curated, structured PG knowledge base. Content is stored as database records linked to the dynamic menu, rather than as hard-coded HTML pages. That design makes it possible to organize information by audience, reuse a stable menu, and later search across the content library.

The database structure is in place, but the current content state is still empty. Menu content routes have generated placeholder documents so each menu item already has its own identity. The placeholders are marked Unknown and Draft and are not published. They are scaffolding, not articles. There is not yet an authored PG library or a production search experience.

### Content structure

A MenuItem represents a navigation choice. A content route gets a ContentDocument linked to that MenuItem. ContentDocument has its own ContentDocumentID, content type, description, metadata, workflow status, publication flag, and dates. ContentElement stores the document's typed blocks: format and MIME codes, block metadata, text or binary payload, and optional file paths.

This allows the same title to appear in different audience branches while each menu item points to a separate document. For example, patient and provider versions of a diagnosis article can share a visible menu title but have distinct menu IDs, visitor masks, and content document IDs.

### Two separate data paths

### Master menu path

Master_Menu.csv is the source for the proposed menu tree. Populate_MasterMenu loads it using the MASTER_MENU setting, normalizes the hierarchy and route values, and stages menu rows for validation. Content-route rows receive placeholder documents so their content identities exist before articles are written.

The current Populate_MenuItems flow initializes and rebuilds the database menu. It clears content and migration rows as part of initialization, and Publish_Staging replaces the runtime menu/content baseline. This is a full rebuild intended for the current empty-content state. It must gain preservation behavior before authored content is loaded and routine menu edits are made against valuable content.

### Legacy content migration path

Legacy website material was captured into MigrationDocument and MigrationElement, with MigrationMapping linking legacy menu titles to the new MenuItem IDs. Perform_Migration loads and then publishes the migration data into ContentDocument and ContentElement. This is separate from the menu staging tables and is the route for scraped legacy content.

A migration mapping is not the same as approval. Captured or imported material still needs editorial review for accuracy, audience, format, and publication readiness. The current publish routine is a batch operation and clears existing content before applying the mapping, so it must be treated as a rebuild against an empty or disposable content database.

### Editorial workflow

The intended content lifecycle is:

1. Identify or capture a useful source and record its provenance.
2. Map it to the correct menu item and audience.
3. Organize it into ContentDocument and ContentElement records.
4. Review the wording, accuracy, audience, format, and links.
5. Set its workflow state and publication fields only after approval.
6. Publish it so the application can serve the approved article.

The database includes Draft, Review, Approved, Rejected, Published, and Staging workflow codes. The schema supports those states; the complete authoring, review, permissions, and preservation workflow remains work to be finished.

### What the knowledge base can grow to include

The relational model can support curated explanations of PG, diagnosis and treatment resources, wound care, pain and lived experience, provider education, research and clinical trials, and directories for providers and care facilities. Those resources can be linked, filtered, and searched when content and the corresponding application features are built.

A database makes this structure possible; it does not guarantee that material is current or medically reviewed. Content governance, expert review, source dates, ownership, search behavior, and safe publication controls are part of delivering a trustworthy knowledge base.

For the actual table definitions and seeded codes, see the [database schema](/database/DCMS_Database_Schema/). For the current import and publication behavior, see the [menu and content workflow](/dcms/DCMS_Menu_Workflow/).
