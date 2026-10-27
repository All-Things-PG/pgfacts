<a id="top"></a>

# DCMS - Dynamic Routing

This document describes the route values used by the current AllThingsPG database and Razor <a href="/welcome/glossary/" target="_blank" rel="noopener">proof of concept</a>. ASP.NET Core Razor Pages provide the request handlers; MenuItem records determine the destination and the data to process.

### The route fields have distinct jobs

MenuItemID identifies a row in the menu tree. ContentDocumentID identifies a document. ParentMenuItemID identifies the menu parent. RouteType classifies the destination, while RouteTarget stores the route value that the application follows. These values are related but are not interchangeable.

The current database stores RouteTarget as a route string, not merely as a bare content ID. For a content route, that string includes the content endpoint and the ContentDocumentID, such as `/content?target=18`. The URL's target parameter carries the content ID; the database column RouteTarget contains the full application route.

<table class="topic-table">
  <thead><tr><th>RouteType</th><th>Meaning</th><th>Example RouteTarget</th></tr></thead>
  <tbody>
    <tr><td>V</td><td>Selects a visitor experience.</td><td><code>/visitor?target=Patient</code></td></tr>
    <tr><td>C</td><td>Opens the ContentDocument identified by the target parameter.</td><td><code>/content?target=18</code></td></tr>
    <tr><td>P</td><td>Opens an application page destination.</td><td><code>/page?target=clinicfinder.cshtml</code></td></tr>
    <tr><td>R</td><td>Opens an external or internal redirect destination.</td><td><code>/redirect?target=https://example.org/</code></td></tr>
  </tbody>
</table>

### Content identity and placeholders

The original idea was to derive a slug from a menu title and look up content by that title. That becomes ambiguous when the same title appears in patient, caregiver, and provider navigation. It also breaks when titles change.

DCMS instead uses identifiers. The database creates a MenuItem, captures its MenuItemID, creates a placeholder ContentDocument linked to the menu item, captures the distinct ContentDocumentID, and sets the content RouteTarget to the route containing that document ID. The IDs establish the relationship before an article has been written.

For example, the supplied MenuItemList extract contains separate Emotional Journey menu records for patient, caregiver, and general audiences. Their MenuItemID values and ContentDocumentID values differ, and each RouteTarget names its own document. The visible title can remain familiar while each audience receives a different article later.

The placeholder is a real relational row, but it is not real PG content. It starts with ContentType U (Unknown), WorkflowStatus D (Draft), and IsPublished false. The current data has menu rows and these placeholders; it does not have authored or published PG articles.

### How the application uses the route

The MenuItemList view joins each menu row to its parent and associated ContentDocument. It exposes RouteTarget and the content identity/status fields for inspection. It does not calculate a new URL column.

The Razor application uses the stored RouteTarget as the link. MenuItem.GetUrl returns that route value; the menu helper adds the menu query value when the page needs to preserve the selected menu context. The destination page then validates and interprets its own query parameters. The content handler reads the numeric target as ContentDocumentID and loads the matching document and its elements. A legacy title parameter is still accepted by the proof of concept for older links, but it is not the canonical content key and duplicate titles can make that lookup ambiguous.

VisitorMask determines which rows are rendered in a persona's navigation. It is a visibility rule for the menu, not an authorization boundary for sensitive information. Route handlers must enforce any access restriction independently.

### CSV and database responsibilities

Master_Menu.csv defines the proposed labels, hierarchy, persona visibility, route type, and any explicit target. Populate_MasterMenu normalizes that file into MasterMenu. The menu test/staging routines create and validate StagingMenuItem rows and placeholders. Publication assigns the runtime MenuItemID and ContentDocumentID values used by RouteTarget.

The content migration process is separate: scraped legacy material is captured in MigrationDocument and MigrationElement, mapped through MigrationMapping, and published to the content tables. It does not make the current menu import incremental.

### Current implementation and remaining work

The proof of concept already demonstrates database-driven navigation, persona filtering, repeated titles with distinct content identities, route dispatch, and placeholder-backed content links. The database also defines typed content blocks through ContentElement, with FormatType, MimeType, BlockInfo, text/binary content, and file references.

The current database population routines rebuild menu and content data. They are suitable for the present baseline, where content is still empty, but must be changed to preserve authored content before ongoing menu updates and production curation begin. A searchable PG knowledge base is the intended Phase 2 product; its articles, operational search experience, and broader provider/facility directories have not yet been populated or delivered.
