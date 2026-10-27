---
layout: page
title: DCMS Menu Workflow
breadcrumb: DCMS > Menu Workflow
description: Current Master_Menu.csv import, staging, validation, and publication flow.
updated: 2026-10-10
permalink: /dcms/DCMS_Menu_Workflow/
---

# DCMS Menu and Content Workflows

<a href="/welcome/glossary/" target="_blank" rel="noopener">DCMS</a> has two related but separate database workflows: one establishes the menu structure, and another captures and migrates legacy-site content. Both connect content to a menu item, but their source data and staging tables serve different purposes.

### The menu data model

| Table | Role |
| :--- | :--- |
| MasterMenuStage | Temporary bulk-load target for the configured CSV file. |
| MasterMenu | Normalized menu specification, including titles, hierarchy, route types, route targets, and visitor masks. |
| TestHarness | Runs the imported menu through the same insert and validation routines used by the menu workflow. |
| StagingMenuItem | Proposed menu tree before it is copied to the runtime menu. |
| StagingDocument | Placeholder document attached to a staged content menu item. |
| MenuItem | Runtime menu tree used by the application. |
| ContentDocument | Runtime content identity linked to a MenuItem. |

MenuItemID and ContentDocumentID are different identifiers. For a content route, the menu item is established first; its placeholder document then receives its own ContentDocumentID. RouteTarget stores the resulting content URL with that document ID, for example /content?target=18. The same displayed title can therefore appear for multiple visitor masks and point to different documents.

### Master menu import

The menu begins as Master_Menu.csv. Populate_MasterMenu reads the file path from the MASTER_MENU SystemSettings value, bulk-loads MasterMenuStage, then rebuilds and normalizes MasterMenu. The CSV's Parent, Child, and Sub Menu columns encode hierarchy. Its RouteType and RouteTarget columns describe how a choice is handled; content rows can leave RouteTarget blank because the placeholder step supplies the content identity.

Populate_MenuItems coordinates the current rebuild:

1. Initialize_Database ensures required objects exist, clears menu/content/staging and migration data, and reloads system and lookup values.
2. Populate_MasterMenu loads and normalizes the configured CSV.
3. Populate_TestHarness and Execute_TestHarness run each menu row through the insert routines, creating StagingMenuItem rows and staged placeholders for content routes.
4. Menu validation checks route values, visitor masks, hierarchy, sort order, and active state.
5. Publish_Staging replaces the runtime menu with the staged tree, reconstructs parent links, validates the result, and creates any missing runtime placeholders.
6. Populate_PortalMenu rebuilds the persona-specific portal tiles.

The lookup population routines seed the defined visitor, route, content, format, MIME, and workflow codes. A mask of ALL is normalized from the current VisitorType rows. The current VisitorType seed values are P (Patient), C (Caregiver), M (Provider), D (Pharmaceutical), and V (Guest).

### Current rebuild limitation

This import path is a full initialization and rebuild, not an incremental menu sync. Initialize_Database clears existing migration, staging, menu, and content rows. Publish_Staging also clears the existing runtime menu and content before copying the staged tree. This is safe for establishing the current empty-content baseline, but it would remove authored content if run after articles have been loaded.

Before the content library is populated, the menu publication workflow needs a preservation strategy that can apply menu changes without deleting unrelated content. Until then, treat Populate_MenuItems as a destructive rebuild and run it only against a disposable or backed-up database.

### Legacy-site content migration

The separate migration path stores extracted legacy material in MigrationDocument and MigrationElement. MigrationMapping connects a captured legacy menu title to the target MenuItem. Perform_Migration calls Populate_Migration and then Publish_Migration. The publish routine clears existing content, restores placeholders, maps captured documents to their target menu items, and writes the resulting document metadata and elements into ContentDocument and ContentElement.

Migration tables are not the same as StagingDocument and StagingElement. Migration tables hold captured source material and its mapping; staging tables hold a proposed menu and its placeholder/prepared content before publication.

### Current content status

The supplied MenuItemList extract shows the menu structure and a placeholder ContentDocument for each content-route item. Those rows are not authored PG articles: their content type is Unknown, workflow status is Draft, and IsPublished is false. As you confirmed, the database currently has no authored or published PG content.

MenuItemList is the inspection view for checking menu IDs, parent relationships, RouteTarget values, visitor masks, linked document IDs, workflow state, and publication state. It is the best query output to compare with a revised CSV or a database workflow change.
