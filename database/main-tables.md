---
layout: page
title: Main Tables
nav_label: Database
description: The database tables and the information they hold.
permalink: /database/main-tables/
---

# Main Tables

This page describes the 25 tables listed in the database's `SystemTables` catalog and shows representative rows. The `TableType` values are the classifications used by the project. Lookup sections show every row defined by the current seed scripts. Other examples come from the supplied schema extract when available; rows labeled **Illustrative** explain the table's shape and are not live database records.

<table class="topic-table">
  <thead><tr><th>Tablename</th><th>TableType</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td>SystemTables</td><td>System</td><td>Lists database tables with their catalog category and order.</td></tr>
    <tr><td>SystemSettings</td><td>System</td><td>Stores application and database settings.</td></tr>
    <tr><td>Numbers</td><td>System</td><td>Stores integers from 1 through 1,000 for utility use.</td></tr>
    <tr><td>ErrorLog</td><td>System</td><td>Records database messages and errors.</td></tr>
    <tr><td>RouteType</td><td>Lookup</td><td>Names the kinds of menu destinations.</td></tr>
    <tr><td>VisitorType</td><td>Lookup</td><td>Defines visitor audiences.</td></tr>
    <tr><td>ContentType</td><td>Lookup</td><td>Classifies <a href="/welcome/glossary/" target="_blank" rel="noopener">content</a> documents.</td></tr>
    <tr><td>FormatType</td><td>Lookup</td><td>Defines content block formats and file extensions.</td></tr>
    <tr><td>MimeType</td><td>Lookup</td><td>Defines media types and rendering characteristics.</td></tr>
    <tr><td>WorkflowStatus</td><td>Lookup</td><td>Defines content workflow states.</td></tr>
    <tr><td>MasterMenu</td><td>Menu</td><td>Holds the imported source menu.</td></tr>
    <tr><td>TestHarness</td><td>Menu</td><td>Stores menu test cases and results.</td></tr>
    <tr><td>MenuItem</td><td>Menu</td><td>Holds the website's navigation items and route targets.</td></tr>
    <tr><td>PortalMenu</td><td>Menu</td><td>Holds visitor-specific portal tiles.</td></tr>
    <tr><td>BoardMember</td><td>Menu</td><td>Holds board member names, roles, biographies, and images.</td></tr>
    <tr><td>ContentDocument</td><td>Content</td><td>Holds a page's content description and publication state.</td></tr>
    <tr><td>ContentElement</td><td>Content</td><td>Holds text, media, or file content blocks.</td></tr>
    <tr><td>StagingDocument</td><td>Staging</td><td>Holds a content document being prepared.</td></tr>
    <tr><td>StagingElement</td><td>Staging</td><td>Holds content blocks being prepared.</td></tr>
    <tr><td>Registration</td><td>Registration</td><td>Holds a person's email, visitor type, and participation choices.</td></tr>
    <tr><td>Contact</td><td>Registration</td><td>Holds contact and address details for a registration.</td></tr>
    <tr><td>Newsletter</td><td>Registration</td><td>Connects a newsletter to its content and dates.</td></tr>
    <tr><td>Email</td><td>Registration</td><td>Holds an email subject, body, and sent date.</td></tr>
    <tr><td>EmailRecipient</td><td>Registration</td><td>Connects an email to a registered recipient.</td></tr>
    <tr><td>EmailAttachment</td><td>Registration</td><td>Holds a file attached to an email.</td></tr>
  </tbody>
</table>

## System tables

### SystemTables

Catalog of the 25 tables classified on this page. This is a representative sample; the complete list appears above.

<table class="topic-table">
  <thead><tr><th>TableName</th><th>TableType</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>SystemTables</td><td>System</td><td>11</td></tr>
    <tr><td>VisitorType</td><td>Lookup</td><td>22</td></tr>
    <tr><td>MenuItem</td><td>Menu</td><td>33</td></tr>
    <tr><td>ContentDocument</td><td>Content</td><td>41</td></tr>
    <tr><td>Registration</td><td>Registration</td><td>61</td></tr>
  </tbody>
</table>

### SystemSettings

Stores typed settings such as site configuration, menu source, and feature choices. These rows are from the database project's baseline settings.

<table class="topic-table">
  <thead><tr><th>SettingKey</th><th>SettingType</th><th>SettingGroup</th><th>SettingValue</th></tr></thead>
  <tbody>
    <tr><td>SITE_NAME</td><td>STRING</td><td>SYSTEM</td><td>AllThingsPG</td></tr>
    <tr><td>MASTER_MENU</td><td>STRING</td><td>SYSTEM</td><td>C:\ATPG\Master_Menu.csv</td></tr>
    <tr><td>ENABLE_REGISTRATION</td><td>BOOLEAN</td><td>APPLICATION</td><td>TRUE</td></tr>
    <tr><td>DEFAULT_PAGE_SIZE</td><td>INTEGER</td><td>GLOBALVAR</td><td>25</td></tr>
    <tr><td>SUPPORT_EMAIL</td><td>STRING</td><td>GLOBALVAR</td><td>support@allthingspg.org</td></tr>
  </tbody>
</table>

### Numbers

Contains the integers 1 through 1,000.

<table class="topic-table">
  <thead><tr><th>Number</th></tr></thead>
  <tbody><tr><td>1</td></tr><tr><td>2</td></tr><tr><td>3</td></tr><tr><td>…</td></tr><tr><td>1,000</td></tr></tbody>
</table>

### ErrorLog

Records routine name, message, severity, parameters, and execution context. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>ProcedureName</th><th>ErrorMessage</th><th>LogLevel</th><th>LogDate</th></tr></thead>
  <tbody><tr><td>Populate_MenuItems</td><td>Example validation message</td><td>ERROR</td><td>Example timestamp</td></tr></tbody>
</table>

## Lookup tables

### RouteType

Identifies how a menu item is opened. All current seed values:

<table class="topic-table">
  <thead><tr><th>Code</th><th>Description</th><th>Folder</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>V</td><td>Visitor</td><td>Visitor</td><td>1</td></tr>
    <tr><td>C</td><td>Content</td><td>Content</td><td>2</td></tr>
    <tr><td>P</td><td>Page</td><td>Page</td><td>3</td></tr>
    <tr><td>R</td><td>Redirect</td><td>Redirect</td><td>4</td></tr>
  </tbody>
</table>

### VisitorType

Defines the visitor types available to the site. All current seed values:

<table class="topic-table">
  <thead><tr><th>Code</th><th>Description</th><th>SortOrder</th><th>IsDefault</th></tr></thead>
  <tbody>
    <tr><td>P</td><td>Patient</td><td>1</td><td>0</td></tr>
    <tr><td>C</td><td>Caregiver</td><td>2</td><td>0</td></tr>
    <tr><td>M</td><td>Provider</td><td>3</td><td>0</td></tr>
    <tr><td>D</td><td>Pharmaceutical</td><td>4</td><td>0</td></tr>
    <tr><td>V</td><td>Guest</td><td>5</td><td>1</td></tr>
  </tbody>
</table>

### ContentType

Classifies a content document. All current seed values:

<table class="topic-table">
  <thead><tr><th>Code</th><th>Name</th><th>Description</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>A</td><td>Article</td><td>Long-form educational content</td><td>1</td></tr>
    <tr><td>N</td><td>NewsItem</td><td>News updates and announcements</td><td>2</td></tr>
    <tr><td>F</td><td>FAQ</td><td>Question and answer pairs</td><td>3</td></tr>
    <tr><td>T</td><td>Testimonial</td><td>Patient and caregiver stories</td><td>4</td></tr>
    <tr><td>P</td><td>Profile</td><td>Board members, staff, medical experts</td><td>5</td></tr>
    <tr><td>E</td><td>Event</td><td>Events, webinars, fundraisers</td><td>6</td></tr>
    <tr><td>L</td><td>Link</td><td>External resource or reference</td><td>8</td></tr>
    <tr><td>R</td><td>Research</td><td>Clinical trial or research study</td><td>9</td></tr>
    <tr><td>X</td><td>External</td><td>External file</td><td>10</td></tr>
    <tr><td>G</td><td>Gallery</td><td>Image gallery metadata</td><td>11</td></tr>
    <tr><td>D</td><td>Document</td><td>PDF or downloadable file reference</td><td>12</td></tr>
    <tr><td>U</td><td>Unknown</td><td>Content has not been populated</td><td>99</td></tr>
  </tbody>
</table>

### FormatType

Defines a content block's format and associated file extensions. All current seed values:

<table class="topic-table">
  <thead><tr><th>Code</th><th>Name</th><th>Description</th><th>FileTypes</th></tr></thead>
  <tbody>
    <tr><td>T</td><td>Text</td><td>Plain Text</td><td>.txt</td></tr>
    <tr><td>R</td><td>RTF</td><td>Rich Text</td><td>.rtf</td></tr>
    <tr><td>H</td><td>HTML</td><td>Web Page Markup</td><td>.html, .htm</td></tr>
    <tr><td>E</td><td>EPUB</td><td>Electronic Pub</td><td>.epub</td></tr>
    <tr><td>P</td><td>PDF</td><td>Portable Doc</td><td>.pdf</td></tr>
    <tr><td>M</td><td>MD</td><td>Markdown</td><td>.md</td></tr>
    <tr><td>J</td><td>JSON</td><td>JSON</td><td>.json</td></tr>
    <tr><td>I</td><td>IMAGE</td><td>Binary Image</td><td>.gif, .jpg, .svg, .webp, .png</td></tr>
    <tr><td>A</td><td>AUDIO</td><td>Binary Audio</td><td>.mp3, .wav, .ogg</td></tr>
    <tr><td>W</td><td>WORD</td><td>MS Word Document</td><td>.docx, .docm, .dotx, .dotm</td></tr>
    <tr><td>S</td><td>EXCEL</td><td>MS Spreadsheet</td><td>.xls, .xlsx</td></tr>
    <tr><td>N</td><td>PPT</td><td>Powerpoint</td><td>.ppt, .pptx, .pps, .ppsx, .pot, .potx, .pptm, .ppsm, .potm</td></tr>
    <tr><td>G</td><td>GDOC</td><td>Google Document</td><td>.gdoc</td></tr>
    <tr><td>D</td><td>OPEN</td><td>Open Document</td><td>.odt</td></tr>
    <tr><td>?</td><td>UNKNOWN</td><td>Unknown</td><td>.bin</td></tr>
  </tbody>
</table>

### MimeType

Identifies the media type and whether content is text, binary, or renderable. All current seed values:

<table class="topic-table">
  <thead><tr><th>Code</th><th>FormatType</th><th>Name</th><th>Description</th><th>Text</th><th>Binary</th><th>Renderable</th></tr></thead>
  <tbody>
    <tr><td>T</td><td>T</td><td>TXT</td><td>text/plain</td><td>1</td><td>0</td><td>1</td></tr>
    <tr><td>M</td><td>M</td><td>MD</td><td>text/markdown</td><td>1</td><td>0</td><td>1</td></tr>
    <tr><td>H</td><td>H</td><td>HTML</td><td>text/html</td><td>1</td><td>0</td><td>1</td></tr>
    <tr><td>C</td><td>H</td><td>HTM</td><td>text/htm</td><td>1</td><td>0</td><td>1</td></tr>
    <tr><td>R</td><td>R</td><td>RTF</td><td>application/rtf</td><td>1</td><td>0</td><td>0</td></tr>
    <tr><td>J</td><td>J</td><td>JSON</td><td>application/json</td><td>1</td><td>0</td><td>0</td></tr>
    <tr><td>E</td><td>E</td><td>EPUB</td><td>application/epub+zip</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>P</td><td>P</td><td>PDF</td><td>application/pdf</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>I</td><td>I</td><td>JPG</td><td>image/jpeg</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>N</td><td>I</td><td>PNG</td><td>image/png</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>F</td><td>I</td><td>GIF</td><td>image/gif</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>S</td><td>I</td><td>SVG</td><td>image/svg+xml</td><td>1</td><td>0</td><td>1</td></tr>
    <tr><td>W</td><td>I</td><td>WEBP</td><td>image/webp</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>A</td><td>A</td><td>MP3</td><td>audio/mpeg</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>U</td><td>A</td><td>WAV</td><td>audio/wav</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>Q</td><td>A</td><td>OGG</td><td>audio/ogg</td><td>0</td><td>1</td><td>1</td></tr>
    <tr><td>D</td><td>W</td><td>DOCX</td><td>application/vnd.openxmlformats-officedocument.wordprocessingml.document</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>X</td><td>W</td><td>DOCM</td><td>application/vnd.ms-word.document.macroEnabled.12</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>Y</td><td>W</td><td>DOTX</td><td>application/vnd.openxmlformats-officedocument.wordprocessingml.template</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>Z</td><td>W</td><td>DOTM</td><td>application/vnd.ms-word.template.macroEnabled.12</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>L</td><td>S</td><td>XLS</td><td>application/vnd.ms-excel</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>K</td><td>S</td><td>XLSX</td><td>application/vnd.openxmlformats-officedocument.spreadsheetml.sheet</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>!</td><td>N</td><td>PPT</td><td>application/vnd.ms-powerpoint</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>@</td><td>N</td><td>PPTX</td><td>application/vnd.openxmlformats-officedocument.presentationml.presentation</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>#</td><td>N</td><td>PPS</td><td>application/vnd.ms-powerpoint</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>$</td><td>N</td><td>PPSX</td><td>application/vnd.openxmlformats-officedocument.presentationml.slideshow</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>%</td><td>N</td><td>POT</td><td>application/vnd.ms-powerpoint</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>^</td><td>N</td><td>POTX</td><td>application/vnd.openxmlformats-officedocument.presentationml.template</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>&amp;</td><td>N</td><td>PPTM</td><td>application/vnd.ms-powerpoint.presentation.macroEnabled.12</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>*</td><td>N</td><td>PPSM</td><td>application/vnd.ms-powerpoint.slideshow.macroEnabled.12</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>+</td><td>N</td><td>POTM</td><td>application/vnd.ms-powerpoint.template.macroEnabled.12</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>G</td><td>G</td><td>GDOC</td><td>application/vnd.google-apps.document</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>O</td><td>D</td><td>ODT</td><td>application/vnd.oasis.opendocument.text</td><td>0</td><td>1</td><td>0</td></tr>
    <tr><td>B</td><td>?</td><td>BIN</td><td>application/octet-stream</td><td>0</td><td>1</td><td>0</td></tr>
  </tbody>
</table>

### WorkflowStatus

Defines the content workflow stage. All current seed values:

<table class="topic-table">
  <thead><tr><th>Code</th><th>Title</th><th>Description</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>D</td><td>Draft</td><td>Content is newly curated or created</td><td>1</td></tr>
    <tr><td>R</td><td>Review</td><td>Content needs review</td><td>2</td></tr>
    <tr><td>A</td><td>Approved</td><td>Content has been approved but not published</td><td>3</td></tr>
    <tr><td>X</td><td>Rejected</td><td>Content has been rejected</td><td>4</td></tr>
    <tr><td>P</td><td>Published</td><td>Content has been published</td><td>5</td></tr>
    <tr><td>S</td><td>Staging</td><td>Content is linked to a staged menu item</td><td>6</td></tr>
  </tbody>
</table>

## Menu tables

### MasterMenu

Imported source menu entries, including hierarchy labels, route, audience, description, and notes. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>MenuID</th><th>Parent</th><th>Child</th><th>Title</th><th>MenuType</th><th>RouteType</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody><tr><td>1</td><td></td><td>Welcome</td><td>Welcome</td><td>P</td><td>V</td><td>/visitor?target=Guest</td><td>PCMDV</td></tr></tbody>
</table>

### TestHarness

Stores menu validation cases and their expected/actual results. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>TestID</th><th>Title</th><th>RouteType</th><th>Expected</th><th>Actual</th><th>IsError</th></tr></thead>
  <tbody><tr><td>1</td><td>Welcome</td><td>V</td><td>PASS</td><td>PASS</td><td>0</td></tr></tbody>
</table>

### MenuItem

The navigation records used by the site. For content routes, `RouteTarget` contains the associated `ContentDocumentID`. The examples below are grouped by route type and come from the supplied menu extract.

#### Visitor routes (V)

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>ParentMenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody>
    <tr><td>1</td><td>NULL</td><td>Welcome</td><td>/visitor?target=Guest</td><td>PCMDV</td></tr>
    <tr><td>2</td><td>1</td><td>Patient</td><td>/visitor?target=Patient</td><td>PCMDV</td></tr>
  </tbody>
</table>

#### Content routes (C)

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th><th>ContentDocumentID</th><th>IsPublished</th></tr></thead>
  <tbody>
    <tr><td>8</td><td>About PG</td><td>/content?target=1</td><td>PCMDV</td><td>1</td><td>0</td></tr>
    <tr><td>25</td><td>Emotional Journey</td><td>/content?target=18</td><td>P</td><td>18</td><td>0</td></tr>
    <tr><td>32</td><td>Emotional Journey</td><td>/content?target=25</td><td>C</td><td>25</td><td>0</td></tr>
    <tr><td>39</td><td>Early Diagnosis</td><td>/content?target=32</td><td>M</td><td>32</td><td>0</td></tr>
  </tbody>
</table>

#### Page routes (P)

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody><tr><td>72</td><td>Clinic Finder</td><td>/page?target=clinicfinder.cshtml</td><td>PCMDV</td></tr></tbody>
</table>

#### Redirect routes (R)

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody><tr><td>74</td><td>All Things Pyoderma 4.2k members</td><td>/redirect?target=https://www.facebook.com/groups/368163159232</td><td>PCMDV</td></tr></tbody>
</table>

The repeated `Emotional Journey` title represents general, patient, and caregiver pages with separate menu and content IDs. The content rows shown are unpublished placeholders, not authored articles.

### PortalMenu

Stores tiles shown for individual visitor types: title, short description, icon path, and linked menu item. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>Title</th><th>Description</th><th>IconPath</th><th>VisitorType</th></tr></thead>
  <tbody><tr><td>25</td><td>Emotional Journey</td><td>Understand the emotional impact of PG — from fear and frustration to strength and acceptance.</td><td>/img/portal-icons/Patient.svg</td><td>P</td></tr></tbody>
</table>

### BoardMember

Stores board member names, roles, positions, descriptions, photos, and display order. These names and roles come from the database seed procedure.

<table class="topic-table">
  <thead><tr><th>Name</th><th>Role</th><th>Position</th><th>PictureFileName</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>Dr. Alex Ortega Loayza</td><td>Founder</td><td>Medical Director</td><td>Founder.jpg</td><td>1</td></tr>
    <tr><td>Corlis Watkins-Nass</td><td>President</td><td>Marketing</td><td>President.jpg</td><td>2</td></tr>
    <tr><td>Dave DePottie</td><td>Chairman</td><td>Information Technology</td><td>Chairman.jpg</td><td>3</td></tr>
  </tbody>
</table>

## Content tables

### ContentDocument

One document-level record is associated with a menu item. Current extract examples are placeholders with `ContentType` U (Unknown), `WorkflowStatus` D (Draft), and `IsPublished` 0.

<table class="topic-table">
  <thead><tr><th>ContentDocumentID</th><th>MenuItemID</th><th>ContentType</th><th>Description</th><th>WorkflowStatus</th><th>IsPublished</th></tr></thead>
  <tbody>
    <tr><td>1</td><td>8</td><td>U</td><td>About PG</td><td>D</td><td>0</td></tr>
    <tr><td>18</td><td>25</td><td>U</td><td>Emotional Journey</td><td>D</td><td>0</td></tr>
    <tr><td>25</td><td>32</td><td>U</td><td>Emotional Journey</td><td>D</td><td>0</td></tr>
  </tbody>
</table>

### ContentElement

Stores a content block's format, media type, block information, and text, binary, or file content. No authored content elements appear in the supplied extract. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>ContentElementID</th><th>ContentDocumentID</th><th>FormatType</th><th>MimeType</th><th>BlockInfo</th><th>TextContent</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>H</td><td>H</td><td>{"block":"body"}</td><td>Example page text</td></tr></tbody>
</table>

## Staging tables

### StagingDocument

Holds a content document while it is being prepared. No staging rows are included in the supplied extract. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>StagingDocumentID</th><th>StagingMenuItemID</th><th>ContentType</th><th>Description</th><th>WorkflowStatus</th></tr></thead>
  <tbody><tr><td>1</td><td>8</td><td>A</td><td>About PG draft</td><td>S</td></tr></tbody>
</table>

### StagingElement

Holds a text, media, or file block associated with a staged document. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>StagingElementID</th><th>StagingDocumentID</th><th>WorkflowStatus</th><th>FormatType</th><th>MimeType</th><th>TextContent</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>S</td><td>H</td><td>H</td><td>Example staged text</td></tr></tbody>
</table>

## Registration tables

### Registration

Stores the email address, visitor type, optional account credentials, and participation preferences. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>RegistrationID</th><th>Email</th><th>VisitorType</th><th>IsMember</th><th>IsVolunteer</th><th>IsNewsLetter</th><th>IsFundraising</th><th>IsActive</th></tr></thead>
  <tbody><tr><td>1</td><td>person@example.org</td><td>P</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td></tr></tbody>
</table>

### Contact

Stores a registrant's name and optional contact and address details. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>ContactID</th><th>RegistrationID</th><th>FirstName</th><th>LastName</th><th>City</th><th>StateProvince</th><th>Country</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>Example</td><td>Person</td><td>Portland</td><td>Oregon</td><td>United States</td></tr></tbody>
</table>

### Newsletter

Connects a content document to a newsletter description and its distribution and publication dates. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>NewsletterID</th><th>ContentDocumentID</th><th>Description</th><th>NewsletterType</th><th>DistributionDate</th><th>PublishDate</th></tr></thead>
  <tbody><tr><td>1</td><td>10</td><td>Community research update</td><td>N</td><td>2026-10-01</td><td>2026-10-01</td></tr></tbody>
</table>

### Email

Stores the subject and body of a message and when it was sent. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>EmailID</th><th>Subject</th><th>BodyText</th><th>SentDate</th></tr></thead>
  <tbody><tr><td>1</td><td>Research update</td><td>A short message to registered recipients.</td><td>2026-10-01</td></tr></tbody>
</table>

### EmailRecipient

Connects a message to a registration and can record when it was sent. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>EmailRecipientID</th><th>EmailID</th><th>RegistrationID</th><th>DateSent</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>1</td><td>2026-10-01</td></tr></tbody>
</table>

### EmailAttachment

Stores an attached file's name, type, and binary contents; it may also refer to a newsletter. **Illustrative row:**

<table class="topic-table">
  <thead><tr><th>EmailAttachmentID</th><th>EmailID</th><th>NewsLetterID</th><th>FileName</th><th>FileType</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>1</td><td>newsletter.pdf</td><td>application/pdf</td></tr></tbody>
</table>

## Other SQL project tables

These supporting, migration, audit, and legacy tables are not assigned a `TableType` in `SystemTables`. Their examples are illustrative because the supplied data extract does not include rows for them.

### EmailRequest

Holds a requested message, its processing state, and the resulting `EmailID` when processed.

<table class="topic-table">
  <thead><tr><th>EmailRequestID</th><th>RegistrationID</th><th>RequestType</th><th>Subject</th><th>IsProcessed</th><th>ProcessedEmailID</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>N</td><td>Research update</td><td>0</td><td>—</td></tr></tbody>
</table>

### MasterMenu_Stage

Menu-import staging rows with a load order and source menu fields.

<table class="topic-table">
  <thead><tr><th>LoadOrder</th><th>Parent</th><th>Child</th><th>SubMenu</th><th>Type</th><th>RouteType</th><th>RouteTarget</th></tr></thead>
  <tbody><tr><td>1</td><td></td><td>Welcome</td><td></td><td>Parent</td><td>V</td><td>/visitor?target=Guest</td></tr></tbody>
</table>

### MasterMenuStage

Holds imported menu fields in the second menu-import staging table.

<table class="topic-table">
  <thead><tr><th>MenuID</th><th>Parent</th><th>Child</th><th>SubMenu</th><th>RouteType</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody><tr><td>1</td><td></td><td>Welcome</td><td></td><td>V</td><td>/visitor?target=Guest</td><td>PCMDV</td></tr></tbody>
</table>

### MenuItemTestHarness

Stores menu-specific test cases, expected outcomes, and processing results.

<table class="topic-table">
  <thead><tr><th>TestID</th><th>Category</th><th>Title</th><th>RouteType</th><th>Expected</th><th>Result</th><th>IsError</th></tr></thead>
  <tbody><tr><td>1</td><td>MENU</td><td>Welcome</td><td>V</td><td>PASS</td><td>—</td><td>0</td></tr></tbody>
</table>

### MigrationDocument

Holds captured legacy page titles, content classifications, descriptions, and metadata.

<table class="topic-table">
  <thead><tr><th>MigrationDocumentID</th><th>MenuTitle</th><th>ContentType</th><th>Description</th><th>MetaData</th></tr></thead>
  <tbody><tr><td>1</td><td>About PG</td><td>A</td><td>Legacy About PG page</td><td>{}</td></tr></tbody>
</table>

### MigrationElement

Holds a captured text or media block associated with a legacy document.

<table class="topic-table">
  <thead><tr><th>MigrationElementID</th><th>MigrationDocumentID</th><th>FormatType</th><th>MimeType</th><th>TextMigration</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>H</td><td>H</td><td>Example legacy page content</td></tr></tbody>
</table>

### MigrationMapping

Connects an old menu title to its destination `MenuItemID` and records whether the match is correct.

<table class="topic-table">
  <thead><tr><th>MigrationMappingID</th><th>OldMenuTitle</th><th>MenuItemID</th><th>IsCorrect</th></tr></thead>
  <tbody><tr><td>1</td><td>About PG</td><td>8</td><td>1</td></tr></tbody>
</table>

### PublishedNewsletter

Records newsletter delivery forms and an optional recipient or URL reference.

<table class="topic-table">
  <thead><tr><th>PublishedNewsletter</th><th>EmailRecipientID</th><th>URL</th><th>IsEmail</th><th>IsHtml</th><th>IsFlyer</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>/newsletters/research-update</td><td>1</td><td>1</td><td>0</td></tr></tbody>
</table>

### save_menuitem

Contains a second set of menu-item fields. The project does not document its specific use; **illustrative row:**

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>ParentMenuItemID</th><th>Title</th><th>RouteType</th><th>RouteTarget</th><th>VisitorMask</th><th>IsActive</th></tr></thead>
  <tbody><tr><td>1</td><td>—</td><td>Welcome</td><td>V</td><td>/visitor?target=Guest</td><td>PCMDV</td><td>1</td></tr></tbody>
</table>

### StagingMenuItem

Holds a menu hierarchy and routes before they become active `MenuItem` records.

<table class="topic-table">
  <thead><tr><th>StagingMenuItemID</th><th>ParentMenuItemID</th><th>Title</th><th>RouteType</th><th>RouteTarget</th><th>VisitorMask</th><th>SortOrder</th></tr></thead>
  <tbody><tr><td>1</td><td>—</td><td>Welcome</td><td>V</td><td>/visitor?target=Guest</td><td>PCMDV</td><td>1</td></tr></tbody>
</table>

### SystemSettings_Audit

Keeps prior setting values and the dates they were last updated and audited.

<table class="topic-table">
  <thead><tr><th>AuditID</th><th>SettingID</th><th>SettingKey</th><th>SettingType</th><th>SettingValue</th><th>AuditDate</th></tr></thead>
  <tbody><tr><td>1</td><td>1</td><td>SITE_NAME</td><td>STRING</td><td>AllThingsPG</td><td>Example timestamp</td></tr></tbody>
</table>

For field definitions, constraints, and foreign keys, see the [database schema](/database/schema/).
