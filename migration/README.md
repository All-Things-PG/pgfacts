# Phase 1 menu migration

## Goal

Load the <a href="/welcome/glossary/" target="_blank" rel="noopener">Phase 1</a> menu into `AllThingsPG.dbo.MasterMenuStage` table.

Through one source-side black-box procedure. The source procedure knows the `Migration` schema. The target procedure knows only the result-set contract and the target stage table.

This import is for menu structure only. It does not copy page HTML, list records, or content into AllThingsPG migration tables.

## Source database: Migration

The source preparation scripts establish and validate the Phase 1 inventory:

1. `001_migration_capture_schema.sql` prepares source capture and tracking tables.
2. `002_seed_phase1_inventory.sql` seeds the page and list inventory.
3. `003_capture_phase1_source.ps1` captures public page content and media references.
4. `004_validate_migration_capture.sql` checks the captured inventory.
5. `005_create_htmlmenu.sql` creates the source menu and its parent relationships.

Run `007_import_atpg.sql` in the `Migration` database to create and preview `Migration.dbo.Import_ATPG`. The procedure reads its local `HtmlMenu`, `HtmlPages`, and `HtmlPageUrl` tables. It returns one result set with these eight columns, in order, matching `MasterMenuStage` apart from its identity column:

1. `Parent` (`nvarchar(100)`)
2. `Child` (`nvarchar(100)`)
3. `SubMenu` (`nvarchar(100)`)
4. `VisitorMask` (`nvarchar(20)`)
5. `RouteType` (`nvarchar(10)`)
6. `RouteTarget` (`nvarchar(200)`)
7. `Description` (`nvarchar(200)`)
8. `Notes` (`nvarchar(200)`)

The adapter validates that visible menu items have a supported depth and valid labels, that every visible item belongs to a root hierarchy, and that canonical URLs fit the `Notes` column. It represents menu levels in `Parent`, `Child`, and `SubMenu`; sets `VisitorMask` to `ALL`, `RouteType` to `C`, and `RouteTarget` to an empty string; and returns the canonical source URL in `Notes`.
Example result rows (illustrative labels; the real rows come from `Migration.dbo.HtmlMenu`):

| Parent | Child | SubMenu | VisitorMask | RouteType | RouteTarget | Description | Notes |
|---|---|---|---|---|---|---|---|
| About PG |  |  | ALL | C |  | About PG | `https://www.allthingspg.org/about/` |
|  | Clinical Topics |  | ALL | C |  | Clinical Topics | `https://www.allthingspg.org/clinical-topics/` |
|  |  | Symptoms | ALL | C |  | Symptoms | `https://www.allthingspg.org/symptoms/` |

Each returned row represents one visible menu entry. The hierarchy level determines which of `Parent`, `Child`, or `SubMenu` is populated. `RouteTarget` is an empty string for these content rows; `Notes` carries the source URL when it fits. These rows show the shape and mapping, not a promise that these exact labels or URLs exist in the current source inventory.

## Target database: AllThingsPG

Run `Import_Migration.sql` in `AllThingsPG`, or call `AllThingsPG.dbo.Import_Migration` with `@ImportSource = 'ATPG'`. The ATPG branch runs:

```sql
INSERT INTO #AtpgMenu (...)
EXEC Migration.dbo.Import_ATPG
```

It replaces only `AllThingsPG.dbo.MasterMenuStage` with the returned rows. It does not inspect source tables, update `MasterMenu`, or write to `MigrationDocument`, `MigrationElement`, or `MigrationMapping`.

The existing CSV branch remains available through the `MASTER_MENU` system setting. `OTHER` remains reserved.

## Continuing the existing menu workflow

`AllThingsPG.dbo.Populate_MasterMenu` calls `Import_Migration`, then copies the staged rows into `MasterMenu`. Review `MasterMenuStage` before running that procedure if you want to inspect the import first.

The menu item workflow then uses the existing population and test harness routines. Those routines validate relationships and create menu items and content placeholders from `MasterMenu`. The import described here stops at `MasterMenuStage`.

`006_load_htmlmenu_to_mastermenustage.sql` is the earlier direct-load path, which reads source tables from the target database context. The `Import_ATPG` / `Import_Migration` pair is the source-isolated path.

No step uses Jekyll's generated `_site` folder.