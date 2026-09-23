# DCMS Menu Workflow

Status: Working notes / design discussion, captured 2026-09-10. Publishing (Matches
handled, New/Deletes proposed but not yet built) is paused here to focus on a POC
website with a working script-driven menu and content update flow ahead of the
Leo Pharm meeting in Portland.

## 1. Two purposes of DCMS

The discussion kept circling back to a core distinction that should guide every
design decision going forward:

1. **Dynamic Menu** — the menu (structure, titles, routing, visitor visibility)
   can change at any time. This is what today's work is about.
2. **Dynamic Content** — curated content can be added/edited against an existing,
   possibly locked-down menu. This is the original purpose of the staging tables
   (`StagingDocument`, `StagingElement`), and is a *different* concern from (1).

For a brand-new menu import, content is effectively static (freshly generated
placeholders). For an established, stable menu, content is what changes dynamically.
Current effort is scoped to (1) — dynamic menu — until it's solid. Bringing new
content into an *existing* MenuItem structure is out of scope for this document.

## 2. Pipeline overview

```
Spreadsheet (CSV)
    │  bulk insert
    ▼
MasterMenuStage  ──copy/resequence──▶  MasterMenu
                                          │  builds hierarchy (ParentMenuID),
                                          │  normalizes Title/RouteType/VisitorMask,
                                          │  matches existing MenuItem/ContentDocument
                                          │  (MenuItemID, ContentDocumentID columns)
                                          ▼
                                    Populate_TestHarness (@CategoryFilter='MENU')
                                          │  loads TestHarness from MasterMenu
                                          │  (1 row per MasterMenu row, Category='MENU')
                                          ▼
                                    Execute_TestHarness
                                          │  drives Insert_MenuItem_Parent / _Child
                                          │  for every TestHarness row, in order
                                          ▼
                              Insert_MenuItem (always staging)
                                    │
                                    ├─▶ StagingMenuItem   (menu item itself)
                                    └─▶ Insert_Content_Placeholder (RouteType='C' only)
                                              │
                                              ▼
                                        Insert_ContentDocument (@IsStaging)
                                              │
                                              ▼
                                        StagingDocument (placeholder content record)
                                          │
                                          ▼
                                 [ StagingMenuItem / StagingDocument / StagingElement
                                   now fully normalized, validated, hierarchy-correct ]
                                          │
                                          ▼
                                    Publish_Staging  ◀── current focus, Matches done
                                          │
                                          ▼
                              MenuItem / ContentDocument / ContentElement (production)
```

## 3. Why staging exists, and why the flag went away

Originally `Insert_MenuItem`/`_Parent`/`_Child` had an `@IsStaging` flag so callers
could choose staging vs. production. That flag was removed:

- **Insert_MenuItem / _Parent / _Child**: always write to `StagingMenuItem`. There is
  no ambiguity — anything going through the test harness (which includes any new
  MasterMenu import) is staging, full stop. This was a deliberate simplification:
  "I'm basically eliminating the isstaging flag... the better approach is to always
  insert into staging through the test harness."
- **Insert_Content_Placeholder / Insert_ContentDocument**: `@IsStaging` was kept
  (default `1`), because these procedures are dual-purpose:
  - Called from the always-staging menu-item chain during test-harness runs
    (`@IsStaging = 1`) to create a placeholder in `StagingDocument`.
  - Will eventually be called from the **publish** step with `@IsStaging = 0` to
    create real `ContentDocument`/`ContentElement` rows in production.

This asymmetry is intentional, not an oversight: the menu-item chain has exactly one
destination now (staging); the content-creation layer has two destinations depending
on which phase of the lifecycle is calling it.

### StagingDocument as its own table (not a WorkflowStatus flag)

Staging content now lives in a **dedicated `StagingDocument` table**, mirroring the
pre-existing `StagingElement` table, rather than the earlier approach of flagging rows
in production `ContentDocument` with `WorkflowStatus = 'S'`. This is a cleaner
separation: staging and production content never share a table, and an FK from
`StagingDocument.MenuItemID` to `StagingMenuItem.StagingMenuItemID` keeps staging
self-contained (this FK was originally miswired to point at production `MenuItem` and
was corrected during this session, along with reordering `Create_Staging_Tables.sql`
so `StagingMenuItem` is created before the table that depends on it).

## 4. Test harness = validation harness, not a decision-maker

`Execute_TestHarness` exercises `Insert_MenuItem_Parent`/`_Child` (which call
`Insert_MenuItem`, which calls `Insert_Content_Placeholder`/`Insert_ContentDocument`)
for every row in `TestHarness`. Its job is purely mechanical: prove that inserts,
normalization (Title, RouteType, VisitorMask, RouteTarget), auto-sort-order, hierarchy
construction, and placeholder creation all work correctly and repeatably. It has no
concept of "is this content new or should it reuse existing production content" — it
creates a placeholder for every `RouteType = 'C'` row because that is just what
`Insert_MenuItem` does, unconditionally. Placeholders it creates in staging are
scaffolding, not decisions, and get reconciled against production only at publish time.

`TestHarness` categories other than `MENU` (IsActive, Mixed, RouteTarget, SortOrder,
Title, VisitorMask, RouteType) are hand-authored fixed test rows exercising specific
validation/normalization rules and are unrelated to a real MasterMenu import — they
share the same execution engine but are not part of the "publish a new menu" flow.

## 5. Publish_Staging — current state

`Publish_Staging` (in `Stored Procedures/Publish_Staging.sql`) currently handles only
**Matches**:

- Matches `StagingMenuItem` to `MenuItem` on the natural key
  `Title + RouteType + VisitorMask` (same columns as
  `UQ_MenuItem_Title_RouteType_VisitorMask`).
- For every matched row:
  - `SortOrder` and `IsActive` are refreshed from staging (placement/visibility can
    change even for an item whose content is untouched).
  - `ParentMenuItemID` is remapped using a `StagingMenuItemID -> MenuItemID` map, so a
    matched row's position in the tree always reflects staging's current hierarchy,
    even if its parent moved.
  - `RouteTarget` and content (`ContentDocument`/`ContentElement`) are **left
    completely untouched** — "if there's a match, we can ignore content altogether...
    We only care about the placement of the MenuItem in the Menu."
- Runs inside a transaction; after the match/remap, `Validate_MenuItem` is called
  (`@IsTesting = 0`, live rules only). If validation reports any errors, the whole
  publish throws and rolls back — matches are all-or-nothing, never partially applied
  on top of an invalid hierarchy.
- New (unmatched) `StagingMenuItem` rows and deletions of `MenuItem` rows no longer
  present in staging are explicitly **not yet handled** — reserved for the next phase.

### Validate_MenuItem additions

Two checks were added to `Validate_MenuItem` specifically as a safety net for
`Publish_Staging`'s remap logic (not because staging hierarchy itself is suspect —
`MasterMenu`/staging hierarchy is trusted to be correct going in):

- **50012 Self-Referencing Parent** — `MenuItemID = ParentMenuItemID`.
- **50013 Circular Hierarchy** — recursive walk of `ParentMenuItemID` chains, flags
  any chain whose depth exceeds total `MenuItem` row count (proof it looped instead
  of terminating at a null-parent root).

Both are cheap insurance against a bug in the publish remap step itself (e.g. a bad
join), not expected to ever fire against correct staging data.

## 6. Open problem: matching is fragile on natural keys

While designing New/Delete handling, a real gap surfaced: a `StagingMenuItem` row
that no longer matches `MenuItem` on Title+RouteType+VisitorMask *looks* new, but may
just be an existing item whose VisitorMask (or Title) was hand-edited in the
spreadsheet. Two mitigations were discussed, in escalating sophistication:

1. **Fallback match on Title+RouteType alone**, accepted only if exactly one
   candidate exists (no duplicates) — treat as a VisitorMask update, matched exactly
   like a primary match (content untouched, only placement/mask refreshed). Multiple
   candidates or zero candidates fall through to "new."
2. **Corroborating-signal scoring** (analogous to record-linkage techniques used
   previously on a 60M-row Medline/WebOfScience publications match): weight a
   Title+RouteType candidate up if its *parent* also matched, and by degree of
   VisitorMask overlap; require a minimum confidence before auto-matching. Always
   defer to "new" when multiple same-Title+RouteType candidates exist under the same
   parent — never guess between siblings.

### The better fix: a persistent MenuKey

The deeper realization: natural-key matching (even scored) is inherently fragile
because it re-derives identity from mutable descriptive fields every time. The
actual fix is a **persistent identity** carried on each menu item from the moment it
is authored, independent of Title/RouteType/VisitorMask:

- Add a `MenuKey` (uniqueidentifier/GUID) column to the spreadsheet, `MasterMenu`, and
  eventually `MenuItem`/`StagingMenuItem`.
- Matching becomes `MenuKey = MenuKey` — exact, no fuzziness, no scoring, no
  duplicate-candidate ambiguity — regardless of how much Title/RouteType/VisitorMask
  drift over time.
- Existing production `MenuItem` rows would need a one-time GUID backfill so the
  first GUID-aware import has something to match against.
- This does not require moving to batch/versioned MasterMenu (a related idea —
  `BatchID`, `DateImported`, a MasterMenu that accumulates instead of being wiped each
  import — that was explicitly deferred as "a distraction" right now, but a stable
  MenuKey is a prerequisite for it and is not wasted effort if that direction is
  picked up later).
- Trade-off acknowledged: introduces a small new discipline for whoever edits the
  spreadsheet (never blank out or duplicate an existing key), a cost weighed against
  the goal of letting a non-programmer edit the menu safely without needing the
  original authoring script.

**This was set aside, not decided against.** Decision explicitly deferred to revisit
after the POC website work.

## 7. Proposal: handling Matches, New, and Deletes at publish time

Given everything implemented and discussed so far, here is the proposed shape for
completing `Publish_Staging`, without prejudging whether MenuKey gets adopted:

### Matches (implemented)

As described in Section 5. No changes proposed here.

### New

A `StagingMenuItem` row with no match (natural-key today; `MenuKey` if adopted) is a
genuinely new menu item:

1. Insert into `MenuItem`, capturing `StagingMenuItemID -> MenuItemID` in the same
   mapping table used for matched rows (a single unified map keyed by
   `StagingMenuItemID`, regardless of whether the row was matched or newly inserted,
   so hierarchy remapping works uniformly for every row in one pass).
2. Remap `ParentMenuItemID` via that unified map — a new child can have a matched
   parent and vice versa, so the map must cover both.
3. Promote the row's `StagingDocument` placeholder (created automatically by
   `Insert_MenuItem` during the test harness run) into a real `ContentDocument` via
   `Insert_ContentDocument @IsStaging = 0` (or an equivalent set-based insert),
   carrying over `StagingElement` rows into `ContentElement` the same way.
4. Rebuild `RouteTarget` for `RouteType = 'C'` rows to encode the new
   `ContentDocumentID` (staging `RouteTarget` encodes `StagingDocumentID`, a different
   ID space, so it cannot be copied as-is).

### Deletes

A `MenuItem` row with no corresponding `StagingMenuItem` row (by whichever match key
is in force) represents something present in production but no longer in the newly
imported menu. Proposed handling, most-conservative first:

1. **Never hard-delete automatically.** Deleting a MenuItem cascades risk to its
   content and any hand-curated additions made via the *content* side of DCMS
   (Section 1) that may not be reflected back in the spreadsheet at all (curation and
   menu-import are different authorities). An automatic delete could silently destroy
   curated work.
2. Preferred first pass: **flag, don't remove** — set `IsActive = 0` on production
   `MenuItem` rows with no staging match, so they drop out of the rendered menu but
   remain in the database, inspectable, and reversible.
3. A true hard-delete (and cascading `ContentDocument`/`ContentElement` cleanup) would
   be a distinct, explicit, human-triggered operation — not something `Publish_Staging`
   does implicitly as a side effect of an import. This mirrors the same instinct
   already applied throughout this session: no destructive operation runs without
   explicit confirmation.
4. If `MenuKey` is adopted, "deleted" becomes an exact-match problem too — no
   candidate whose `MenuKey` doesn't appear anywhere in the new staging batch — with
   the same conservative flag-first handling.

### Suggested overall publish order

```
1. Match   (exact key match)         -- implemented
2. New     (unmatched staging rows)  -- proposed above
3. Delete  (unmatched production rows) -- proposed above, flag not remove
4. Validate_MenuItem (@IsTesting = 0) -- run once, at the end, across the fully
                                         published result; throw + rollback on any
                                         error, exactly as Matches does today
```

Running validation once at the very end (rather than after each phase) ensures the
final state — matches, new inserts, and delete-flags all applied — is checked as a
whole, since e.g. a new row's hierarchy might depend on a matched row's remapped
`ParentMenuItemID`.

## 8. Parking lot (explicitly deferred, not rejected)

- **MenuKey GUID** on spreadsheet/MasterMenu/MenuItem — strong candidate to replace
  natural-key matching entirely; deferred pending POC work.
- **Batch/versioned MasterMenu** (`BatchID`, `DateImported`, accumulating history
  instead of wipe-and-reload) — related to MenuKey, deferred as a distraction from
  current priorities.
- **Insert_MissingContentPlaceholders** — currently calls `Insert_Content_Placeholder`
  with `@IsStaging = 1` as a provisional fix; its source view (`MissingPlacholders`,
  note existing filename typo) still needs semantics reconciled against a
  staging-first world. Left intentionally provisional.
- **Insert_ContentElement** — sibling "publish" procedure to `Insert_ContentDocument`
  for content elements; not yet reviewed for the same `@IsStaging` consistency as its
  sibling.
- **TestHarness.MenuItemID / ContentDocumentID naming collision** — these columns
  already exist but are used by `Execute_TestHarness` to record staging-generated
  test-result IDs, not the `MasterMenu`-matched production IDs. Carrying a matched
  production link through `TestHarness` → `StagingMenuItem` → `Publish_Staging` would
  need new, distinctly-named columns (e.g. `MatchMenuItemID` /
  `MatchContentDocumentID`) to avoid colliding with the existing test-result meaning.
  Not yet designed or built.
- **Full DCMS content curation UI** (view/move/link content, create MenuItems from the
  content side) — acknowledged as the real long-term purpose of staging (Section 1,
  item 2), but explicitly out of scope until the menu-import flow is solid.

## 9. Immediate next priority (per 2026-09-10 direction)

Paused here to build a working POC website ahead of the Leo Pharm meeting in
Portland (grant approved, $125,000, timing "perfect"). Needed for that POC:

- A working website with a few real content pages.
- A script-driven way to update content and see it reflected on the site.
- A script-driven way to change the menu and see it reflected on the site.

Once that POC is solid, work returns to completing `Publish_Staging` (New/Delete) and
revisiting MasterMenu design (MenuKey, batching) as outlined above.
