# Migration Import Design

**Status:** Working design note; the source-to-target contract is not finalized.

## Purpose

Bring the <a href="/welcome/glossary/" target="_blank" rel="noopener">Phase 1</a> menu and captured page content into the Phase 2 database in a repeatable way. The menu first loads into `MasterMenuStage`; the existing `Populate_MasterMenu` flow and test harness then validate the menu before menu items and content placeholders are built.

The process should be repeatable so the target database can be rebuilt from source routines when needed. Keep the Phase 1 CSV import available as a fallback.

## Design principles

- Keep source-specific code close to the source data it reads.
- Use the expected source-specific naming pattern, including `Import_CSV` and `Migration.dbo.Import_ATPG`.
- Keep lifecycle routines within the established `Create`, `Populate`, and `Perform` pattern.
- Keep target writes under AllThingsPG routines, including `MasterMenuStage` and the target migration/content tables.
- Preserve the direct `HtmlMenu` to `HtmlPages` relationship and source identifiers as early as possible.
- Do not guess menu matches with title tokens. Resolve menu-item matching through the established review and test-harness flow.
- Keep the Phase 1 source and its content; the migration adds them to the Phase 2 model.

## Import responsibilities

### Source adapter

`Migration.dbo.Import_ATPG` should own knowledge of the Phase 1 capture schema, including `HtmlMenu`, `HtmlPages`, and URL details. It should expose a predictable set of menu and page data for the AllThingsPG import flow. If the source schema changes or is replaced, the source adapter is the place to absorb that change while preserving the agreed contract.

### AllThingsPG import flow

AllThingsPG owns the destination structures and their population. Its import flow consumes the source data and loads:

1. `MasterMenuStage`, preserving hierarchy and source order.
2. `MigrationDocument` and `MigrationElement`, preserving the source menu/page relationship and provenance.
3. The existing menu population and validation flow, after the staged data is reviewed.

The import must not replace `MasterMenu` directly.

## Source-to-target contract options

The implementation choice is still open:

- **Source routine writes to AllThingsPG:** keeps extraction next to Phase 1 tables, but the source routine then depends on AllThingsPG table names, permissions, and destination schema.
- **Source routine returns normalized rows:** keeps extraction next to Phase 1 tables while allowing AllThingsPG routines to own destination writes. SQL Server `INSERT ... EXEC` captures one result set per call, so menu and content data must fit a documented result shape or use separate export calls / a stable contract table.

The contract should include menu identity and parent identity, label and order, page identity, capture status, canonical URL, and captured HTML/text. It must preserve the menu-to-page link. If source-specific IDs are retained in target metadata, treat them as provenance keys rather than cross-database foreign keys.

## Current implementation note

The current `Import_Migration.sql` prototype reads `Migration.dbo.HtmlMenu`, `HtmlPages`, and `HtmlPageUrl` directly from AllThingsPG. That is useful for proving the data flow, but it leaves the target routine coupled to the source schema. Refactor it after deciding the source adapter's contract and location.

## Testing and working process

- Use the routine's bottom test execution for a focused manual check when appropriate.
- Use same-named scripts in the database project's `Testing` folder for broader migration tests.
- Keep debugging and logging scripts in the separate `SQL Scripts PG\Logging` folder.
- Build and test routines manually, then merge and sync the schema with the AllThingsPG database project.
- Do not run migration imports or publishing routines until Dave chooses to execute them.

This note is a design aid in `pgfacts\docs`; it is not linked from the site's documentation index or a migration topic.
