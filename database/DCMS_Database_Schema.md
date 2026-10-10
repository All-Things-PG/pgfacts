---
layout: page
title: Database Schema
breadcrumb: Database > Schema
description: Define the structure of the database.
updated: 2026-09-18
---

# DCMS - Dynamic Content and Menuing System

## Database Schema

This document describes the database schema for  **AllThingsPG** SQL Server database.  Schema is the structure of the database, for tables, stored procedures, functions, constraints and much more.  Schema is the definition of the database. All databases have schema, which is a description of things like table columns, type etc.  A table in a database is much like an Excel spreadsheet, where each column has a name and type (integer, text, currency etc).  The definition of a table defines what type of data can be put in that table, and where to put it. This document, and other database documents, are part of the developer specs, and not attempt (other than this paragraph) will be made to explain terminology.

The SQL project under `Database\AllThingsPG.Database` is the implementation baseline for table names, column definitions, constraints, relationships, views, functions, procedures, and deployment behavior.  It is the master source of truth.  Even the database itself is not, it is the schema defined in the database project that is.  Like the POC and eventualy Phase2 website, the db project is in a Github repository and securely stored with our nonprofit All Things PG organization (or will be soon).

The schema defines various categories of tables:

- lookup data tha defines valid domain values
- menu and route definitions used to build navigation
- content documents and ordered content elements
- staging records used before content is published
- master menu, menu items, portal menu
- registration, communication, emails, contacts
- system settings, error log
- test harness and staging

## Database Project

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Property</th>
      <th scope="col">Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Project</td>
      <td>`AllThingsPG.Database`</td>
    </tr>
    <tr>
      <td>Project file</td>
      <td>`AllThingsPG.Database.sqlproj`</td>
    </tr>
    <tr>
      <td>Schema provider</td>
      <td>`Microsoft.Data.Tools.Schema.Sql.Sql160DatabaseSchemaProvider`</td>
    </tr>
    <tr>
      <td>Target</td>
      <td>SQL Server database</td>
    </tr>
    <tr>
      <td>Default schema</td>
      <td>`dbo`</td>
    </tr>
    <tr>
      <td>Deployment</td>
      <td>SSDT build, pre-deployment, and post-deployment scripts</td>
    </tr>
  </tbody>
</table>

### Implemented object inventory

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Object type</th>
      <th scope="col">Location</th>
      <th scope="col">Objects</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Tables</td>
      <td>`Tables`</td>
      <td>29 tables, including operational, lookup, staging, and test tables</td>
    </tr>
    <tr>
      <td>Views</td>
      <td>`Views`</td>
      <td>`ContentDocumentList`, `ContentElementList`, `MenuItemList`, `MissingTableList`, `TableList`</td>
    </tr>
    <tr>
      <td>Functions</td>
      <td>`Functions`</td>
      <td>15 scalar/table-valued utility and validation functions</td>
    </tr>
    <tr>
      <td>Stored procedures</td>
      <td>`Stored Procedures`</td>
      <td>61 initialization, CRUD, validation, population, logging, and reporting procedures</td>
    </tr>
    <tr>
      <td>Deployment scripts</td>s
      <td>Project root and `Scripts`</td>
      <td>`Pre-Deployment.sql`, `Post-Deployment.sql`, backup and initial-data scripts</td>
    </tr>
    <tr>
      <td>Test scripts</td>
      <td>`Testing`</td>
      <td>Non-build scripts for setup, normalization, population, validation, and test execution</td>
    </tr>
  </tbody>
</table>

---

## 1. Lookup Tables

Lookup tables provide validated domain values referenced by transactional tables. Their codes are deliberately compact because they are used as foreign-key values in menu, content, registration, staging, and rendering records.

### Table: `VisitorType`

Defines visitor personas used by registration and menu visibility rules.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`Code`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Persona description</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Display order</td>
    </tr>
    <tr>
      <td>`IsDefault`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Identifies the default persona</td>
    </tr>
  </tbody>
</table>

**Current sample data:**

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Code</th>
      <th scope="col">Description</th>
      <th scope="col">SortOrder</th>
      <th scope="col">IsDefault</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`P`</td>
      <td>Patient</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <td>`C`</td>
      <td>Caregiver</td>
      <td>2</td>
      <td>0</td>
    </tr>
    <tr>
      <td>`M`</td>
      <td>Provider</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <td>`D`</td>
      <td>Pharmaceutical</td>
      <td>4</td>
      <td>0</td>
    </tr>
    <tr>
      <td>`V`</td>
      <td>Visitor</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <td>`R`</td>
      <td>Register</td>
      <td>6</td>
      <td>0</td>
    </tr>
  </tbody>
</table>

### Table: `RouteType`

Defines how a menu item route is interpreted by the application.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`Code`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Route behavior description</td>
    </tr>
    <tr>
      <td>`Folder`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Application folder or handler context</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Display or evaluation order</td>
    </tr>
  </tbody>
</table>

**Current sample data:**

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Code</th>
      <th scope="col">Description</th>
      <th scope="col">Folder</th>
      <th scope="col">SortOrder</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`V`</td>
      <td>Visitor</td>
      <td>`Visitor`</td>
      <td>1</td>
    </tr>
    <tr>
      <td>`C`</td>
      <td>Content</td>
      <td>`Content`</td>
      <td>2</td>
    </tr>
    <tr>
      <td>`P`</td>
      <td>Page</td>
      <td>`Page`</td>
      <td>3</td>
    </tr>
    <tr>
      <td>`R`</td>
      <td>Redirect</td>
      <td>`Redirect`</td>
      <td>4</td>
    </tr>
  </tbody>
</table>

### Table: `ContentType`

Defines the document-level content classification or rendering template.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`Code`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`Name`</td>
      <td>`nvarchar(50)`</td>
      <td>NOT NULL</td>
      <td>Short type name</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Type description</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Display order</td>
    </tr>
  </tbody>
</table>

**Current sample data:**

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Code</th>
      <th scope="col">Name</th>
      <th scope="col">Description</th>
      <th scope="col">SortOrder</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`A`</td>
      <td>Article</td>
      <td>Long-form educational content</td>
      <td>1</td>
    </tr>
    <tr>
      <td>`N`</td>
      <td>NewsItem</td>
      <td>News updates and announcements</td>
      <td>2</td>
    </tr>
    <tr>
      <td>`F`</td>
      <td>FAQ</td>
      <td>Question and answer pairs</td>
      <td>3</td>
    </tr>
    <tr>
      <td>`T`</td>
      <td>Testimonial</td>
      <td>Patient and caregiver stories</td>
      <td>4</td>
    </tr>
    <tr>
      <td>`P`</td>
      <td>Profile</td>
      <td>Board members, staff, medical experts</td>
      <td>5</td>
    </tr>
    <tr>
      <td>`E`</td>
      <td>Event</td>
      <td>Events, webinars, fundraisers</td>
      <td>6</td>
    </tr>
    <tr>
      <td>`L`</td>
      <td>Link</td>
      <td>External resource or reference</td>
      <td>8</td>
    </tr>
    <tr>
      <td>`R`</td>
      <td>Research</td>
      <td>Clinical trial or research study</td>
      <td>9</td>
    </tr>
    <tr>
      <td>`X`</td>
      <td>External</td>
      <td>External file</td>
      <td>10</td>
    </tr>
    <tr>
      <td>`G`</td>
      <td>Gallery</td>
      <td>Image gallery metadata</td>
      <td>11</td>
    </tr>
    <tr>
      <td>`D`</td>
      <td>Document</td>
      <td>PDF or downloadable file reference</td>
      <td>12</td>
    </tr>
    <tr>
      <td>`U`</td>
      <td>Unknown</td>
      <td>Content has not been populated</td>
      <td>99</td>
    </tr>
  </tbody>
</table>

### Table: `FormatType`

Defines the source or encoding format of a content element.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`Code`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`Name`</td>
      <td>`nvarchar(50)`</td>
      <td>NOT NULL</td>
      <td>Format name</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Format description</td>
    </tr>
    <tr>
      <td>`FileTypes`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Associated file extensions or types</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Display or processing order</td>
    </tr>
  </tbody>
</table>

**Current sample data:**

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Code</th>
      <th scope="col">Name</th>
      <th scope="col">Description</th>
      <th scope="col">SortOrder</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`T`</td>
      <td>Text</td>
      <td>Plain Text</td>
      <td>1</td>
    </tr>
    <tr>
      <td>`R`</td>
      <td>RTF</td>
      <td>Rich Text</td>
      <td>2</td>
    </tr>
    <tr>
      <td>`H`</td>
      <td>HTML</td>
      <td>Web Page Markup</td>
      <td>3</td>
    </tr>
    <tr>
      <td>`E`</td>
      <td>EPUB</td>
      <td>Electronic Pub</td>
      <td>4</td>
    </tr>
    <tr>
      <td>`P`</td>
      <td>PDF</td>
      <td>Portable Doc</td>
      <td>5</td>
    </tr>
    <tr>
      <td>`M`</td>
      <td>MD</td>
      <td>Markdown</td>
      <td>6</td>
    </tr>
    <tr>
      <td>`J`</td>
      <td>JSON</td>
      <td>JSON</td>
      <td>7</td>
    </tr>
    <tr>
      <td>`I`</td>
      <td>IMAGE</td>
      <td>Binary Image</td>
      <td>8</td>
    </tr>
    <tr>
      <td>`A`</td>
      <td>AUDIO</td>
      <td>Binary Audio</td>
      <td>9</td>
    </tr>
    <tr>
      <td>`W`</td>
      <td>WORD</td>
      <td>MS Word Document</td>
      <td>10</td>
    </tr>
    <tr>
      <td>`S`</td>
      <td>EXCEL</td>
      <td>MS Spreadsheet</td>
      <td>11</td>
    </tr>
    <tr>
      <td>`N`</td>
      <td>PPT</td>
      <td>Powerpoint</td>
      <td>12</td>
    </tr>
    <tr>
      <td>`G`</td>
      <td>GDOC</td>
      <td>Google Document</td>
      <td>13</td>
    </tr>
    <tr>
      <td>`D`</td>
      <td>OPEN</td>
      <td>Open Document</td>
      <td>14</td>
    </tr>
    <tr>
      <td>`?`</td>
      <td>UNKNOWN</td>
      <td>Unknown</td>
      <td>99</td>
    </tr>
  </tbody>
</table>

### Table: `MimeType`

Defines the media type and rendering characteristics of a content element.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`Code`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`FormatType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `FormatType.Code`</td>
    </tr>
    <tr>
      <td>`Name`</td>
      <td>`nvarchar(50)`</td>
      <td>NOT NULL</td>
      <td>MIME type name</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Rendering description</td>
    </tr>
    <tr>
      <td>`IsText`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Indicates text payload</td>
    </tr>
    <tr>
      <td>`IsBinary`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Indicates binary payload</td>
    </tr>
    <tr>
      <td>`IsRenderable`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Indicates whether the application can render it</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Processing or display order</td>
    </tr>
  </tbody>
</table>

Constraint: `FK_MimeType_FormatType` references `FormatType(Code)`.

**Current sample data:**

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Code</th>
      <th scope="col">FormatType</th>
      <th scope="col">Name</th>
      <th scope="col">Description</th>
      <th scope="col">IsText</th>
      <th scope="col">IsBinary</th>
      <th scope="col">IsRenderable</th>
      <th scope="col">SortOrder</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`T`</td>
      <td>`T`</td>
      <td>TXT</td>
      <td>`text/plain`</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>`M`</td>
      <td>`M`</td>
      <td>MD</td>
      <td>`text/markdown`</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <td>`H`</td>
      <td>`H`</td>
      <td>HTML</td>
      <td>`text/html`</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>3</td>
    </tr>
    <tr>
      <td>`C`</td>
      <td>`H`</td>
      <td>HTM</td>
      <td>`text/htm`</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>4</td>
    </tr>
    <tr>
      <td>`R`</td>
      <td>`R`</td>
      <td>RTF</td>
      <td>`application/rtf`</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>5</td>
    </tr>
    <tr>
      <td>`J`</td>
      <td>`J`</td>
      <td>JSON</td>
      <td>`application/json`</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>6</td>
    </tr>
    <tr>
      <td>`E`</td>
      <td>`E`</td>
      <td>EPUB</td>
      <td>`application/epub+zip`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>7</td>
    </tr>
    <tr>
      <td>`P`</td>
      <td>`P`</td>
      <td>PDF</td>
      <td>`application/pdf`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>8</td>
    </tr>
    <tr>
      <td>`I`</td>
      <td>`I`</td>
      <td>JPG</td>
      <td>`image/jpeg`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>9</td>
    </tr>
    <tr>
      <td>`N`</td>
      <td>`I`</td>
      <td>PNG</td>
      <td>`image/png`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>10</td>
    </tr>
    <tr>
      <td>`F`</td>
      <td>`I`</td>
      <td>GIF</td>
      <td>`image/gif`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>11</td>
    </tr>
    <tr>
      <td>`S`</td>
      <td>`I`</td>
      <td>SVG</td>
      <td>`image/svg+xml`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>12</td>
    </tr>
    <tr>
      <td>`W`</td>
      <td>`I`</td>
      <td>WEBP</td>
      <td>`image/webp`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>13</td>
    </tr>
    <tr>
      <td>`A`</td>
      <td>`A`</td>
      <td>MP3</td>
      <td>`audio/mpeg`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>14</td>
    </tr>
    <tr>
      <td>`U`</td>
      <td>`A`</td>
      <td>WAV</td>
      <td>`audio/wav`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>15</td>
    </tr>
    <tr>
      <td>`Q`</td>
      <td>`A`</td>
      <td>OGG</td>
      <td>`audio/ogg`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>16</td>
    </tr>
    <tr>
      <td>`D`</td>
      <td>`W`</td>
      <td>DOCX</td>
      <td>`application/vnd.openxmlformats-officedocument.wordprocessingml.document`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>17</td>
    </tr>
    <tr>
      <td>`X`</td>
      <td>`W`</td>
      <td>DOCM</td>
      <td>`application/vnd.ms-word.document.macroEnabled.12`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>18</td>
    </tr>
    <tr>
      <td>`Y`</td>
      <td>`W`</td>
      <td>DOTX</td>
      <td>`application/vnd.openxmlformats-officedocument.wordprocessingml.template`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>19</td>
    </tr>
    <tr>
      <td>`Z`</td>
      <td>`W`</td>
      <td>DOTM</td>
      <td>`application/vnd.ms-word.template.macroEnabled.12`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>20</td>
    </tr>
    <tr>
      <td>`L`</td>
      <td>`S`</td>
      <td>XLS</td>
      <td>`application/vnd.ms-excel`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>21</td>
    </tr>
    <tr>
      <td>`K`</td>
      <td>`S`</td>
      <td>XLSX</td>
      <td>`application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>22</td>
    </tr>
    <tr>
      <td>`!`</td>
      <td>`N`</td>
      <td>PPT</td>
      <td>`application/vnd.ms-powerpoint`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>23</td>
    </tr>
    <tr>
      <td>`@`</td>
      <td>`N`</td>
      <td>PPTX</td>
      <td>`application/vnd.openxmlformats-officedocument.presentationml.presentation`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>24</td>
    </tr>
    <tr>
      <td>`#`</td>
      <td>`N`</td>
      <td>PPS</td>
      <td>`application/vnd.ms-powerpoint`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>25</td>
    </tr>
    <tr>
      <td>`$`</td>
      <td>`N`</td>
      <td>PPSX</td>
      <td>`application/vnd.openxmlformats-officedocument.presentationml.slideshow`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>26</td>
    </tr>
    <tr>
      <td>`%`</td>
      <td>`N`</td>
      <td>POT</td>
      <td>`application/vnd.ms-powerpoint`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>27</td>
    </tr>
    <tr>
      <td>`^`</td>
      <td>`N`</td>
      <td>POTX</td>
      <td>`application/vnd.openxmlformats-officedocument.presentationml.template`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>28</td>
    </tr>
    <tr>
      <td>`&amp;`</td>
      <td>`N`</td>
      <td>PPTM</td>
      <td>`application/vnd.ms-powerpoint.presentation.macroEnabled.12`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>29</td>
    </tr>
    <tr>
      <td>`*`</td>
      <td>`N`</td>
      <td>PPSM</td>
      <td>`application/vnd.ms-powerpoint.slideshow.macroEnabled.12`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>30</td>
    </tr>
    <tr>
      <td>`+`</td>
      <td>`N`</td>
      <td>POTM</td>
      <td>`application/vnd.ms-powerpoint.template.macroEnabled.12`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>31</td>
    </tr>
    <tr>
      <td>`G`</td>
      <td>`G`</td>
      <td>GDOC</td>
      <td>`application/vnd.google-apps.document`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>32</td>
    </tr>
    <tr>
      <td>`O`</td>
      <td>`D`</td>
      <td>ODT</td>
      <td>`application/vnd.oasis.opendocument.text`</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>33</td>
    </tr>
    <tr>
      <td>`B`</td>
      <td>`?`</td>
      <td>BIN</td>
      <td>`application/octet-stream`</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>99</td>
    </tr>
  </tbody>
</table>

### Table: `WorkflowStatus`

Defines the editorial state of content and staged content.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`Code`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`Title`</td>
      <td>`nvarchar(50)`</td>
      <td>NOT NULL</td>
      <td>Short status title</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(200)`</td>
      <td>NULL</td>
      <td>Status explanation</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Workflow order</td>
    </tr>
  </tbody>
</table>

**Current sample data:**

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Code</th>
      <th scope="col">Title</th>
      <th scope="col">Description</th>
      <th scope="col">SortOrder</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`D`</td>
      <td>Draft</td>
      <td>Content is newly curated or created</td>
      <td>1</td>
    </tr>
    <tr>
      <td>`R`</td>
      <td>Review</td>
      <td>Content needs review</td>
      <td>2</td>
    </tr>
    <tr>
      <td>`A`</td>
      <td>Approved</td>
      <td>Content has been approved but not published</td>
      <td>3</td>
    </tr>
    <tr>
      <td>`X`</td>
      <td>Rejected</td>
      <td>Content has been rejected</td>
      <td>4</td>
    </tr>
    <tr>
      <td>`P`</td>
      <td>Published</td>
      <td>Content has been published</td>
      <td>5</td>
    </tr>
  </tbody>
</table>

---

## 2. Menu and Routing Tables

### Table: `MenuItem`

`MenuItem` is the runtime menu model. A row represents one menu node. Parent-child relationships are represented by the self-referencing `ParentMenuItemID`.md/"> a `NULL` parent identifies a top-level item.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`MenuItemID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Clustered primary key</td>
    </tr>
    <tr>
      <td>`ParentMenuItemID`</td>
      <td>`int`</td>
      <td>NULL</td>
      <td>Self-FK to `MenuItem.MenuItemID`</td>
    </tr>
    <tr>
      <td>`Title`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Menu label</td>
    </tr>
    <tr>
      <td>`RouteType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `RouteType.Code`</td>
    </tr>
    <tr>
      <td>`RouteTarget`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Route-specific target value</td>
    </tr>
    <tr>
      <td>`VisitorMask`</td>
      <td>`varchar(10)`</td>
      <td>NOT NULL</td>
      <td>Allowed visitor-type codes</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Defaults to `0`.md/&quot;&gt; must be non-negative</td>
    </tr>
    <tr>
      <td>`IsActive`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Defaults to `1`.md/&quot;&gt; controls visibility</td>
    </tr>
    <tr>
      <td>`CreatedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
    <tr>
      <td>`ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
  </tbody>
</table>

Constraints:

* `FK_MenuItem_Parent` references the same table through `ParentMenuItemID`.
* `FK_MenuItem_RouteType` references `RouteType(Code)`.
* `CK_MenuItem_SortOrder` requires `SortOrder >= 0`.
* `CK_MenuItem_Title_Normalized` rejects reserved URL, markup, and query characters.
* `CK_MenuItem_VisitorMask` permits only `P`, `C`, `M`, `D`, `V`, and `R`, and requires a non-empty mask.

### Visitor Types (`RouteType = V`)

The visitor route selects or changes the visitor persona. The current Welcome branch contains seven active records: one parent and six visitor choices.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">MenuItemID</th>
      <th scope="col">ParentMenuItemID</th>
      <th scope="col">Title</th>
      <th scope="col">RouteTarget</th>
      <th scope="col">VisitorMask</th>
      <th scope="col">SortOrder</th>
      <th scope="col">IsActive</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>NULL</td>
      <td>Welcome</td>
      <td>`/visitor?v=Register`</td>
      <td>`PCMDVR`</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>2</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Patient</td>
      <td>`/visitor?v=Patient`</td>
      <td>`PCMDVR`</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>3</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Caregiver</td>
      <td>`/visitor?v=Caregiver`</td>
      <td>`PCMDVR`</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <td>4</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Provider</td>
      <td>`/visitor?v=Provider`</td>
      <td>`PCMDVR`</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <td>5</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Pharmaceutical</td>
      <td>`/visitor?v=Pharmaceutical`</td>
      <td>`PCMDVR`</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <td>6</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Visitor</td>
      <td>`/visitor?v=Visitor`</td>
      <td>`PCMDVR`</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <td>7</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Register</td>
      <td>`/visitor?v=Register`</td>
      <td>`PCMDVR`</td>
      <td>6</td>
      <td>1</td>
    </tr>
  </tbody>
</table>

All seven rows have `RouteType = 'V'`.

### Content Example (`RouteType = C`)

`About PG` demonstrates a content route with a root menu item, child menu items, and third-level submenu items. The hierarchy below is the complete active descendant tree for `MenuItemID = 8`.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">MenuItemID</th>
      <th scope="col">ParentMenuItemID</th>
      <th scope="col">Level</th>
      <th scope="col">Title</th>
      <th scope="col">RouteTarget</th>
      <th scope="col">VisitorMask</th>
      <th scope="col">SortOrder</th>
      <th scope="col">IsActive</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>8</td>
      <td>NULL</td>
      <td>0</td>
      <td>About PG</td>
      <td>`/content?c=about%20pg`</td>
      <td>`PCMDVR`</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <td>9</td>
      <td>8</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;What is PG</td>
      <td>`/content?c=what%20is%20pg`</td>
      <td>`PCMDVR`</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>10</td>
      <td>8</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Clinical Topics</td>
      <td>`/content?c=clinical%20topics`</td>
      <td>`PCMDVR`</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <td>17</td>
      <td>8</td>
      <td>1</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Living With PG</td>
      <td>`/content?c=living%20with%20pg`</td>
      <td>`PCMDVR`</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <td>11</td>
      <td>10</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Symptoms</td>
      <td>`/content?c=symptoms`</td>
      <td>`PCMDVR`</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>12</td>
      <td>10</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Diagnosis</td>
      <td>`/content?c=diagnosis`</td>
      <td>`PCMDVR`</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <td>13</td>
      <td>10</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Treatment</td>
      <td>`/content?c=treatment`</td>
      <td>`PCMDVR`</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <td>14</td>
      <td>10</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Wound Care</td>
      <td>`/content?c=wound%20care`</td>
      <td>`PCMDVR`</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <td>15</td>
      <td>10</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Pain Management</td>
      <td>`/content?c=pain%20management`</td>
      <td>`PCMDVR`</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <td>16</td>
      <td>10</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Outcomes</td>
      <td>`/content?c=outcomes`</td>
      <td>`PCMDVR`</td>
      <td>6</td>
      <td>1</td>
    </tr>
    <tr>
      <td>18</td>
      <td>17</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Emotional Journey</td>
      <td>`/content?c=emotional%20journey`</td>
      <td>`PCMDVR`</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>19</td>
      <td>17</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Loss of Mobility</td>
      <td>`/content?c=loss%20of%20mobility`</td>
      <td>`PCMDVR`</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <td>20</td>
      <td>17</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Loss of Identity</td>
      <td>`/content?c=loss%20of%20identity`</td>
      <td>`PCMDVR`</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <td>21</td>
      <td>17</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Avoiding Mistakes</td>
      <td>`/content?c=avoiding%20mistakes`</td>
      <td>`PCMDVR`</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <td>22</td>
      <td>17</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Managing Disability</td>
      <td>`/content?c=managing%20disability`</td>
      <td>`PCMDVR`</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <td>23</td>
      <td>17</td>
      <td>2</td>
      <td>&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;&amp;nbsp.md/&quot;&gt;Comorbidities</td>
      <td>`/content?c=comorbidities`</td>
      <td>`PCMDVR`</td>
      <td>6</td>
      <td>1</td>
    </tr>
  </tbody>
</table>

All rows in this example have `RouteType = 'C'`.

### Other RouteTypes (`P` and `R`)

The remaining route types currently represented in `MenuItem` are page routes (`P`) and redirects (`R`).

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">MenuItemID</th>
      <th scope="col">ParentMenuItemID</th>
      <th scope="col">Title</th>
      <th scope="col">RouteType</th>
      <th scope="col">RouteTarget</th>
      <th scope="col">VisitorMask</th>
      <th scope="col">SortOrder</th>
      <th scope="col">IsActive</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>64</td>
      <td>59</td>
      <td>Clinic Finder</td>
      <td>`P` (Page)</td>
      <td>`/page?p=clinicfinder.html`</td>
      <td>`PCMD`</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <td>66</td>
      <td>65</td>
      <td>All Things Pyoderma 4.2k members</td>
      <td>`R` (Redirect)</td>
      <td>`/redirect?r=https://www.facebook.com/groups/368163159232`</td>
      <td>`PCMD`</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>67</td>
      <td>65</td>
      <td>PG Support Group 2.6k member</td>
      <td>`R` (Redirect)</td>
      <td>`/redirect?r=https://www.facebook.com/groups/56007379235`</td>
      <td>`PCMD`</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <td>68</td>
      <td>65</td>
      <td>PG Support and Advocacy 1.4k members</td>
      <td>`R` (Redirect)</td>
      <td>`/redirect?r=https://www.facebook.com/groups/345212721641027`</td>
      <td>`PCMD`</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <td>84</td>
      <td>80</td>
      <td>Global Skin Alliance</td>
      <td>`R` (Redirect)</td>
      <td>`/redirect?r=https://globalskin.org/`</td>
      <td>`PCMDVR`</td>
      <td>4</td>
      <td>1</td>
    </tr>
  </tbody>
</table>

These rows demonstrate that page and redirect targets can appear beneath other menu items while retaining their own route-specific behavior.

### Table: `MasterMenu`

`MasterMenu` stores the descriptive master-menu representation used by import, population, or legacy menu workflows. It is separate from the normalized runtime `MenuItem` hierarchy.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`MenuID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Identity identifier</td>
    </tr>
    <tr>
      <td>`ParentMenuID`</td>
      <td>`int`</td>
      <td>NULL</td>
      <td>Parent reference value</td>
    </tr>
    <tr>
      <td>`Parent`</td>
      <td>`nvarchar(100)`</td>
      <td>NOT NULL</td>
      <td>Parent menu label</td>
    </tr>
    <tr>
      <td>`Child`</td>
      <td>`nvarchar(100)`</td>
      <td>NOT NULL</td>
      <td>Child menu label</td>
    </tr>
    <tr>
      <td>`SubMenu`</td>
      <td>`nvarchar(100)`</td>
      <td>NOT NULL</td>
      <td>Submenu label</td>
    </tr>
    <tr>
      <td>`MenuType`</td>
      <td>`nvarchar(10)`</td>
      <td>NOT NULL</td>
      <td>Menu classification</td>
    </tr>
    <tr>
      <td>`VisitorMask`</td>
      <td>`nvarchar(20)`</td>
      <td>NULL</td>
      <td>Visitor visibility mask</td>
    </tr>
    <tr>
      <td>`RouteType`</td>
      <td>`nvarchar(10)`</td>
      <td>NULL</td>
      <td>Route classification</td>
    </tr>
    <tr>
      <td>`RouteTarget`</td>
      <td>`nvarchar(200)`</td>
      <td>NULL</td>
      <td>Route target</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(200)`</td>
      <td>NOT NULL</td>
      <td>Menu description</td>
    </tr>
    <tr>
      <td>`Notes`</td>
      <td>`nvarchar(200)`</td>
      <td>NULL</td>
      <td>Additional notes</td>
    </tr>
  </tbody>
</table>

### Tables: `MasterMenuStage` and `MasterMenu_Stage`

These tables support staged or imported master-menu data. They retain the parent, child, submenu, menu type, visitor, routing, description, and notes fields before or during menu population.

`MasterMenuStage` has an identity `MenuID` and uses `MenuType`. `MasterMenu_Stage` has an identity `LoadOrder` and uses `Type`.md/"> it does not define a primary key or foreign keys.

---

## 3. Content Tables

### Table: `ContentDocument`

Stores the document-level descriptor associated with a menu item. A content document is the parent of one or more ordered `ContentElement` rows.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`ContentDocumentID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Clustered primary key</td>
    </tr>
    <tr>
      <td>`MenuItemID`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>FK to `MenuItem.MenuItemID`</td>
    </tr>
    <tr>
      <td>`ContentType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `ContentType.Code`</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(500)`</td>
      <td>NOT NULL</td>
      <td>Document description</td>
    </tr>
    <tr>
      <td>`MetaData`</td>
      <td>`nvarchar(max)`</td>
      <td>NOT NULL</td>
      <td>JSON document metadata</td>
    </tr>
    <tr>
      <td>`WorkflowStatus`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `D`.md/&quot;&gt; FK to `WorkflowStatus.Code`</td>
    </tr>
    <tr>
      <td>`IsPublished`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Public visibility flag</td>
    </tr>
    <tr>
      <td>`PublishedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NULL</td>
      <td>Publication timestamp</td>
    </tr>
    <tr>
      <td>`CreatedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
    <tr>
      <td>`ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
  </tbody>
</table>

Constraints:

* `CK_ContentDocument_MetaData_IsJSON` requires valid JSON in `MetaData`.
* `FK_ContentDocument_MenuItem` cascades deletion from a menu item.
* `FK_ContentDocument_ContentType` and `FK_ContentDocument_WorkflowStatus` enforce valid classifications.

### Table: `ContentElement`

Stores an ordered or independently addressable content block belonging to a document.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`ContentElementID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Clustered primary key</td>
    </tr>
    <tr>
      <td>`ContentDocumentID`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>FK to `ContentDocument.ContentDocumentID`</td>
    </tr>
    <tr>
      <td>`FormatType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `FormatType.Code`</td>
    </tr>
    <tr>
      <td>`MimeType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `MimeType.Code`</td>
    </tr>
    <tr>
      <td>`BlockInfo`</td>
      <td>`nvarchar(max)`</td>
      <td>NOT NULL</td>
      <td>JSON block metadata</td>
    </tr>
    <tr>
      <td>`TextContent`</td>
      <td>`nvarchar(max)`</td>
      <td>NULL</td>
      <td>Text, HTML, or other textual payload</td>
    </tr>
    <tr>
      <td>`BinaryContent`</td>
      <td>`varbinary(max)`</td>
      <td>NULL</td>
      <td>Binary payload</td>
    </tr>
    <tr>
      <td>`LocalFilePath`</td>
      <td>`nvarchar(255)`</td>
      <td>NULL</td>
      <td>Local server file reference</td>
    </tr>
    <tr>
      <td>`ExternalFilePath`</td>
      <td>`nvarchar(255)`</td>
      <td>NULL</td>
      <td>External file reference</td>
    </tr>
    <tr>
      <td>`CreatedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
    <tr>
      <td>`ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
  </tbody>
</table>

Constraint: `CK_ContentElement_BlockInfo_IsJSON` requires valid JSON in `BlockInfo`. Deleting a document cascades to its elements.

---

## 4. Staging Tables

Staging tables represent content before it is promoted to the operational content tables.

### Table: `StagingDocument`

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`StagingDocumentID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Clustered primary key</td>
    </tr>
    <tr>
      <td>`MenuItemID`</td>
      <td>`int`</td>
      <td>NULL</td>
      <td>Optional FK to `MenuItem.MenuItemID`</td>
    </tr>
    <tr>
      <td>`Title`</td>
      <td>`nvarchar(255)`</td>
      <td>NOT NULL</td>
      <td>Staged document title</td>
    </tr>
    <tr>
      <td>`Description`</td>
      <td>`nvarchar(500)`</td>
      <td>NOT NULL</td>
      <td>Staged document description</td>
    </tr>
    <tr>
      <td>`ContentType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `ContentType.Code`</td>
    </tr>
    <tr>
      <td>`Metadata`</td>
      <td>`nvarchar(max)`</td>
      <td>NOT NULL</td>
      <td>JSON staging metadata</td>
    </tr>
    <tr>
      <td>`WorkflowStatus`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Staging workflow state</td>
    </tr>
    <tr>
      <td>`CreatedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
    <tr>
      <td>`ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
  </tbody>
</table>

`CK_StagingDocument_Metadata_IsJSON` validates `Metadata`. The menu-item relationship is optional so a staged document can exist before it is assigned to navigation.

### Table: `StagingElement`

Stores staged content blocks associated with a staged document.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`StagingElementID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Clustered primary key</td>
    </tr>
    <tr>
      <td>`StagingDocumentID`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>FK to `StagingDocument.StagingDocumentID`</td>
    </tr>
    <tr>
      <td>`WorkflowStatus`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>Element workflow state.md/&quot;&gt; FK to `WorkflowStatus.Code`</td>
    </tr>
    <tr>
      <td>`FormatType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `FormatType.Code`</td>
    </tr>
    <tr>
      <td>`MimeType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `MimeType.Code`</td>
    </tr>
    <tr>
      <td>`Metadata`</td>
      <td>`nvarchar(max)`</td>
      <td>NOT NULL</td>
      <td>JSON rendering metadata</td>
    </tr>
    <tr>
      <td>`TextContent`</td>
      <td>`nvarchar(max)`</td>
      <td>NULL</td>
      <td>Staged text payload</td>
    </tr>
    <tr>
      <td>`BinaryContent`</td>
      <td>`varbinary(max)`</td>
      <td>NULL</td>
      <td>Staged binary payload</td>
    </tr>
    <tr>
      <td>`LocalFilePath`</td>
      <td>`nvarchar(255)`</td>
      <td>NULL</td>
      <td>Local file reference</td>
    </tr>
    <tr>
      <td>`ExternalFilePath`</td>
      <td>`nvarchar(255)`</td>
      <td>NULL</td>
      <td>External file reference</td>
    </tr>
    <tr>
      <td>`CreatedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
    <tr>
      <td>`ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
  </tbody>
</table>

`CK_StagingElement_Metadata_IsJSON` validates `Metadata`. The staging document relationship is not configured with cascade delete.

---

## 5. Registration and Communication Tables

### Table: `Registration`

Stores registered users and visitor-persona preferences.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`RegistrationID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Clustered primary key</td>
    </tr>
    <tr>
      <td>`Email`</td>
      <td>`nvarchar(500)`</td>
      <td>NOT NULL</td>
      <td>Unique login/contact address</td>
    </tr>
    <tr>
      <td>`PasswordHash`</td>
      <td>`varbinary(256)`</td>
      <td>NULL</td>
      <td>Password hash</td>
    </tr>
    <tr>
      <td>`PasswordSalt`</td>
      <td>`varbinary(256)`</td>
      <td>NULL</td>
      <td>Password salt</td>
    </tr>
    <tr>
      <td>`VisitorType`</td>
      <td>`char(1)`</td>
      <td>NOT NULL</td>
      <td>FK to `VisitorType.Code`</td>
    </tr>
    <tr>
      <td>`IsMember`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Membership flag</td>
    </tr>
    <tr>
      <td>`IsVolunteer`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Volunteer flag</td>
    </tr>
    <tr>
      <td>`IsNewsLetter`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Newsletter subscription flag</td>
    </tr>
    <tr>
      <td>`IsFundraising`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Fundraising communication flag</td>
    </tr>
    <tr>
      <td>`IsActive`</td>
      <td>`bit`</td>
      <td>NOT NULL</td>
      <td>Account-active flag</td>
    </tr>
    <tr>
      <td>`CreatedDate`, `ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Audit timestamps</td>
    </tr>
  </tbody>
</table>

`UQ_Registration_Email` enforces unique email addresses.

### Table: `Contact`

Stores contact and address details for a registration.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`ContactID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`RegistrationID`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>FK to `Registration.RegistrationID`</td>
    </tr>
    <tr>
      <td>`FirstName`, `LastName`, `MiddleName`</td>
      <td>`varchar(100)`</td>
      <td>First/last NOT NULL.md/&quot;&gt; middle NULL</td>
      <td>Name fields</td>
    </tr>
    <tr>
      <td>`MobilePhone`, `HomePhone`, `WorkPhone`</td>
      <td>`varchar(20)`</td>
      <td>NULL</td>
      <td>Phone fields</td>
    </tr>
    <tr>
      <td>`WorkEmail`</td>
      <td>`varchar(500)`</td>
      <td>NULL</td>
      <td>Work email</td>
    </tr>
    <tr>
      <td>`AddressLine1`, `AddressLine2`</td>
      <td>`varchar(200)`</td>
      <td>NULL</td>
      <td>Address fields</td>
    </tr>
    <tr>
      <td>`ForeignAddress`</td>
      <td>`varchar(500)`</td>
      <td>NULL</td>
      <td>Non-domestic address</td>
    </tr>
    <tr>
      <td>`City`, `StateProvince`, `Country`</td>
      <td>`varchar(100)`</td>
      <td>NULL</td>
      <td>Location fields</td>
    </tr>
    <tr>
      <td>`PostalCode`</td>
      <td>`varchar(20)`</td>
      <td>NULL</td>
      <td>Postal code</td>
    </tr>
    <tr>
      <td>`DateOfBirth`</td>
      <td>`date`</td>
      <td>NULL</td>
      <td>Birth date</td>
    </tr>
    <tr>
      <td>`CreatedDate`, `ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Audit timestamps</td>
    </tr>
  </tbody>
</table>

### Table: `Email`

Stores outbound email messages.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`EmailID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`Subject`</td>
      <td>`varchar(200)`</td>
      <td>NOT NULL</td>
      <td>Subject</td>
    </tr>
    <tr>
      <td>`BodyText`</td>
      <td>`nvarchar(max)`</td>
      <td>NULL</td>
      <td>Message body</td>
    </tr>
    <tr>
      <td>`SentDate`</td>
      <td>`datetime2(7)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysutcdatetime()`</td>
    </tr>
    <tr>
      <td>`CreatedDate`, `ModifiedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Audit timestamps</td>
    </tr>
  </tbody>
</table>

### Table: `EmailRecipient`

Associates an email with a registered recipient.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`EmailRecipientID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`EmailID`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>FK to `Email.EmailID`.md/&quot;&gt; cascade delete</td>
    </tr>
    <tr>
      <td>`RegistrationID`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>FK to `Registration.RegistrationID`.md/&quot;&gt; cascade delete</td>
    </tr>
    <tr>
      <td>`DateSent`</td>
      <td>`datetime2(7)`</td>
      <td>NULL</td>
      <td>Delivery timestamp</td>
    </tr>
    <tr>
      <td>`CreatedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Creation timestamp</td>
    </tr>
  </tbody>
</table>

### Table: `EmailAttachment`

Stores binary files attached to an email.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`EmailAttachmentID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`EmailID`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>FK to `Email.EmailID`.md/&quot;&gt; cascade delete</td>
    </tr>
    <tr>
      <td>`FileName`</td>
      <td>`varchar(255)`</td>
      <td>NOT NULL</td>
      <td>File name</td>
    </tr>
    <tr>
      <td>`FileType`</td>
      <td>`varchar(50)`</td>
      <td>NOT NULL</td>
      <td>File type</td>
    </tr>
    <tr>
      <td>`FileData`</td>
      <td>`varbinary(max)`</td>
      <td>NOT NULL</td>
      <td>File contents</td>
    </tr>
    <tr>
      <td>`CreatedDate`</td>
      <td>`datetime2(0)`</td>
      <td>NOT NULL</td>
      <td>Creation timestamp</td>
    </tr>
  </tbody>
</table>

### Tables: `Newsletter` and `PublishedNewsletter`

`Newsletter` associates a `ContentDocument` with distribution and publication dates. `PublishedNewsletter` stores published delivery representations, including optional email recipient and URL references, with flags for email, HTML, and flyer forms.

---

## 6. System and Utility Tables

### Table: `SystemSettings`

Stores typed application and database configuration values.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`SettingID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`SettingKey`</td>
      <td>`varchar(50)`</td>
      <td>NOT NULL</td>
      <td>Unique uppercase setting key</td>
    </tr>
    <tr>
      <td>`SettingType`</td>
      <td>`varchar(50)`</td>
      <td>NOT NULL</td>
      <td>Uppercase type such as `STRING`, `JSON`, `GUID`, `INTEGER`, or `BOOLEAN`</td>
    </tr>
    <tr>
      <td>`SettingGroup`</td>
      <td>`varchar(50)`</td>
      <td>NOT NULL</td>
      <td>Uppercase group: `GLOBALVAR`, `APPLICATION`, `DATABASE`, or `SYSTEM`</td>
    </tr>
    <tr>
      <td>`SettingValue`</td>
      <td>`sql_variant`</td>
      <td>NULL</td>
      <td>Typed setting value</td>
    </tr>
    <tr>
      <td>`LastUpdated`</td>
      <td>`datetime2(7)`</td>
      <td>NOT NULL</td>
      <td>Defaults to `sysdatetime()`</td>
    </tr>
  </tbody>
</table>

The table enforces uppercase keys, types, and groups.md/"> valid setting types and groups.md/"> JSON and GUID validity where applicable.md/"> required values for non-string/list types.md/"> and a unique setting key.

### Table: `SystemSettings_Audit`

Stores historical setting values and update timestamps. It contains `AuditID`, the original setting identity and key/type/group/value fields, `LastUpdated`, and `AuditDate`.

### Table: `SystemTables`

Registers database tables for system discovery and diagnostics.

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Column</th>
      <th scope="col">Type</th>
      <th scope="col">Nullability</th>
      <th scope="col">Constraints / purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`TableID`</td>
      <td>`int identity(1,1)`</td>
      <td>NOT NULL</td>
      <td>Primary key</td>
    </tr>
    <tr>
      <td>`TableName`</td>
      <td>`varchar(50)`</td>
      <td>NOT NULL</td>
      <td>Unique table name</td>
    </tr>
    <tr>
      <td>`TableType`</td>
      <td>`varchar(15)`</td>
      <td>NOT NULL</td>
      <td>`Registration`, `Menu`, `Staging`, `Content`, `Lookup`, or `System`</td>
    </tr>
    <tr>
      <td>`SortOrder`</td>
      <td>`int`</td>
      <td>NOT NULL</td>
      <td>Display order</td>
    </tr>
  </tbody>
</table>

### Table: `Numbers`

Stores integer values used by database loops and set-based utility procedures. `Number` is the clustered primary key.

### Table: `ErrorLog`

Stores database diagnostics. It includes `ProcedureName`, error details, serialized `Parameters`, executing `UserName` and `HostName`, a constrained `LogLevel` (`DEBUG`, `INFO`, `WARNING`, or `ERROR`), and `LogDate`.

---

## 7. Test-Support Tables

These tables support database validation and test harness execution. They are included in the database project but are not part of the public runtime content model.

### Table: `TestHarness`

Stores test cases and execution results, including test hierarchy, category, expected and actual values, menu/content identifiers, processing state, and error details.

### Table: `MenuItemTestHarness`

Stores menu-specific test definitions and outcomes, including parent test relationships, expected results, menu title, route values, visitor mask, sort order, active state, processing state, and notes.

---

## 8. Views

### `MenuItemList`

Provides a flattened menu reporting and validation view. It includes the current menu item, parent menu attributes, route metadata, associated content-document metadata, parent content metadata, parent/child indicators, and a `MissingPlaceholder` flag when a content route lacks a document.

### `ContentDocumentList`

Joins `ContentDocument` to its menu item, route type, content type, and workflow status. It is intended for content validation, administration, and reporting.

### `ContentElementList`

Joins each `ContentElement` to its document, menu item, route type, content type, format type, MIME type, and workflow status. It exposes both element data and inherited document/menu metadata.

### `TableList`

Provides database table inventory information for system discovery.

### `MissingTableList`

Reports expected or registered tables that are missing from the database.

---

## 9. Functions

The project defines the following reusable functions:

* `Create_MetaData`
* `Get_SystemSetting`
* `Get_TableList`
* `Normalize_ErrorMessage`
* `Normalize_RouteTarget`
* `Normalize_RouteType`
* `Normalize_SettingKey`
* `Normalize_Slug`
* `Normalize_Title`
* `Normalize_Token`
* `Normalize_VisitorMask`
* `SplitCSVRow`
* `TableExists`
* `TablesExists`
* `Validate_Url`

Normalization functions enforce consistent values before validation or persistence. Discovery functions expose settings and table metadata. Existence and validation functions support deployment and database-health checks.

---

## 10. Stored Procedures

Stored procedures are organized by responsibility:

<table class="topic-table">
  <thead>
    <tr>
      <th scope="col">Responsibility</th>
      <th scope="col">Procedures</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Initialization and deployment</td>
      <td>`Initialize_Database`, `Create_Tables`, `Create_Lookup_Tables`, `Create_Content_Tables`, `Create_Staging_Tables`, `Create_System_Tables`, `Create_Registration_Tables`, `Create_Numbers_Table`, `Create_MenuItem_Table`, `Create_MasterMenu_Table`, `Create_ErrorLog_Table`, `Create_SystemSettings_Table`, `Create_SystemTables_Table`, `Create_TableList_Table`</td>
    </tr>
    <tr>
      <td>Content</td>
      <td>`Insert_ContentDocument`, `Insert_ContentElement`, `Insert_Content_Placeholder`, `Delete_Content`, `Populate_ContentDocument`</td>
    </tr>
    <tr>
      <td>Menu</td>
      <td>`Insert_MenuItem`, `Insert_MenuItem_Parent`, `Insert_MenuItem_Child`, `Delete_MenuItem`, `Populate_MenuItems`, `Populate_MasterMenu`, `Perform_MenuItem_Validation`</td>
    </tr>
    <tr>
      <td>Staging</td>
      <td>`Populate_Staging`, `Delete_Staging`, `Validate_Staging`</td>
    </tr>
    <tr>
      <td>Lookup population</td>
      <td>`Populate_ContentType`, `Populate_FormatType`, `Populate_MimeType`, `Populate_RouteType`, `Populate_VisitorType`, `Populate_WorkflowStatus`, `Populate_Lookup_Tables`</td>
    </tr>
    <tr>
      <td>System data</td>
      <td>`Populate_SystemSettings`, `Populate_SystemTables`, `Populate_Numbers_Table`, `Set_SystemSetting`, `Get_SystemInfo`</td>
    </tr>
    <tr>
      <td>Validation and inspection</td>
      <td>`Validate_Database`, `Validate_Content`, `Validate_MenuItem`, `Perform_Table_Check`, `Show_Tables`, `Show_Schema`, `Show_Foreign_Keys`</td>
    </tr>
    <tr>
      <td>Logging and messaging</td>
      <td>`Log_Error`, `Log_Debug`, `Clear_ErrorLog`, `Print_Messages`, `Opening_Message`, `Success_Message`</td>
    </tr>
    <tr>
      <td>Test support</td>
      <td>`Create_TestHarness`, `Populate_TestHarness`, `Execute_TestHarness`, `Create_TempTable_FromCSV`</td>
    </tr>
  </tbody>
</table>

The `Testing` folder contains non-build versions and focused scripts for setup, population, normalization, URL validation, menu validation, schema display, and test execution.

---

## 11. Deployment and Data Flow

1. SSDT builds the schema objects listed in the project file.
2. `Pre-Deployment.sql` and `Scripts\PreDeploy\01_Backup.sql` provide pre-deployment preparation and backup behavior.
3. Lookup, system, menu, and initial content data are populated through post-deployment scripts and population procedures.
4. Imported or authored content enters `StagingDocument` and `StagingElement`.
5. Validation procedures check staged menu, content, workflow, route, format, and metadata values.
6. Approved content is represented by `ContentDocument` and its `ContentElement` children.
7. Runtime menu queries use active `MenuItem` rows, visitor masks, route metadata, and sort order.
8. Runtime content queries use published `ContentDocument` rows and their associated elements.
9. Views provide flattened data for administration, diagnostics, and validation.

### Runtime relationship summary

```text
VisitorType
    |
Registration ---- Contact
    |
Email ---- EmailRecipient ---- Registration
  |
  +---- EmailAttachment

RouteType ---- MenuItem ---- ContentDocument ---- ContentElement
                  |                 |
                  |                 +---- ContentType
                  +---- parent MenuItem
                  +---- VisitorMask
                  +---- WorkflowStatus

ContentType ---- StagingDocument ---- StagingElement
FormatType ---- ContentElement / StagingElement
MimeType   ---- ContentElement / StagingElement
WorkflowStatus ---- ContentDocument / StagingElement
```

## 12. Source of Truth

This document describes the current SQL project, but the `.sql` object definitions remain authoritative when a description and implementation differ. Any future schema change should update the corresponding SQL object and this document in the same change.

