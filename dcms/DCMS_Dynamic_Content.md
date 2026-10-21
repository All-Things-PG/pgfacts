---
layout: page
title: Dynamic Content
breadcrumb: DCMS > Dynamic Content
description: Current content identity, typed elements, placeholders, and implementation status.
updated: 2026-10-10
permalink: /dcms/DCMS_Dynamic_Content/
---

# Dynamic Content in DCMS

DCMS stores content as relational records and renders it through the Razor proof of concept. The database schema defines content identity, typed blocks, workflow metadata, and publication state. It does not yet provide a finished authoring and review application or a populated PG knowledge base.

### The content model

| Table | Purpose |
| :--- | :--- |
| MenuItem | Navigation choice, audience mask, route type, and route target. |
| ContentDocument | Document identity and metadata, linked to a MenuItem. |
| ContentElement | Typed content block with format, MIME type, metadata, text or binary payload, and optional file paths. |
| StagingDocument / StagingElement | Prepared content related to staged menu publication. |
| MigrationDocument / MigrationElement / MigrationMapping | Captured legacy-site material and its mapping to target menu items. |

MenuItemID and ContentDocumentID are separate identities. A content menu row is established first. A placeholder ContentDocument is then linked to the MenuItem, giving it a stable ContentDocumentID before an article exists. RouteTarget for a content row carries that document ID, for example `/content?target=18`.

The same title may occur in more than one audience branch. The supplied MenuItemList extract has separate “Emotional Journey” rows for patient, caregiver, and general visitors, each with its own MenuItemID, visitor mask, and ContentDocumentID. This avoids relying on a title-derived slug to decide which article to load.

### What is in the database now

The current menu export contains 92 menu rows, including 70 content routes. Those routes are linked to placeholder documents. The placeholders use ContentType U (Unknown), WorkflowStatus D (Draft), and IsPublished false. There are no authored or published PG articles in the current data state.

ContentElement has no persisted SortOrder column. The schema therefore does not promise editorial ordering for multiple blocks in one document. That needs a deliberate schema or rendering decision before ordered multi-block articles are authored.

### Rendering and future capabilities

FormatType and MimeType describe how an element is represented; ContentType classifies the document. BlockInfo and document metadata can carry rendering or descriptive properties. The POC demonstrates numeric ContentDocumentID retrieval, route handling, and rendering of available content structures. A legacy title-based query remains for compatibility, but numeric document identity is the canonical key because titles can repeat.

The relational model can support a searchable knowledge base, provider and facility directories, clinical-trial information, and audience-specific explanations. Those features require authored and reviewed data, appropriate search and maintenance workflows, and application behavior beyond merely defining tables. Searchable content is a Phase 2 goal, not a capability delivered by the current placeholder dataset.

### Separate publication paths

Master_Menu.csv is loaded into master-menu and staging structures to establish navigation and placeholders. Legacy-site content follows a separate migration path through MigrationDocument, MigrationElement, and MigrationMapping. Both current publication routines clear existing content during rebuild. They must be made preservation-aware before routine menu or migration publication is used with authored content.

For table definitions and seeded lookup records, see the [database schema](/database/DCMS_Database_Schema/). For the import and rebuild sequence, see the [menu workflow](/dcms/DCMS_Menu_Workflow/). For the route model, see [dynamic routing](/dcms/DCMS_Dynamic_Routing/).
