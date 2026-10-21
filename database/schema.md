---
layout: page
title: Schema
nav_label: Database
description: Complete SQL Server table definitions, constraints, sample data, and database object purposes.
permalink: /database/schema/
updated: 2026-10-19
---

# Database Schema

The documentation site describes the schema for the AllThingsPG database in SQL Server.  AllThingsDB is a [**relational database**](/database/) that contains both data and business logic and will be used by the Phase 2 version of www.allthingspg.org. Refer to a link for a discusson on Databases.

 The schema for the database is created, maintained and deployed by a SSDT project in VS 2022 called **AllThingsPG.Database** contained in GitHub, and is considered the master source of all schema The database will be developed and tested on a local SQL Server, and when ready, will be deployed to a staging environment in Azure to a Azure SQL database. Refer to Builds and Deployments for more information.
 
 The VS2022 database project defines all implemented schema including tables, views, constraints, stored procedures, functions and other objects. The database is built and deployed from that source, and can either deploy to local development or Azure SQLh in staging.

### Database project inventory

<table class="topic-table">
  <thead><tr><th>Object type</th><th>Count</th><th>What is listed here</th></tr></thead>
  <tbody>
    <tr><td>Tables</td><td>36</td><td>34 of the 36 project tables are documented here; two legacy or supporting tables are omitted. The remaining table sections include columns, declared constraints, foreign keys, and sample data.</td></tr>
    <tr><td>Views</td><td>12</td><td>Purpose only.</td></tr>
    <tr><td>Functions</td><td>15</td><td>Purpose only.</td></tr>
    <tr><td>Stored procedures</td><td>75</td><td>Purpose only.</td></tr>
  </tbody>
</table>

Sample data shows project seed values or rows available in the supplied extract. Where no sample rows are available, the page says NO DATA AVAILABLE. A section with fewer than five available records shows all available records rather than invented rows. Two legacy or supporting tables are omitted from this reference.

## Table List with Classifications

<table class="topic-table">
  <thead><tr><th>Tablename</th><th>TableType</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td><a href="#table-SystemTables">SystemTables</a></td><td>System</td><td>Lists database tables with their catalog category and order.</td></tr>
    <tr><td><a href="#table-SystemSettings">SystemSettings</a></td><td>System</td><td>Stores application and database settings.</td></tr>
    <tr><td><a href="#table-Numbers">Numbers</a></td><td>System</td><td>Stores integers from 1 through 1,000 for utility use.</td></tr>
    <tr><td><a href="#table-ErrorLog">ErrorLog</a></td><td>System</td><td>Records database messages and errors.</td></tr>
    <tr><td><a href="#table-RouteType">RouteType</a></td><td>Lookup</td><td>Names the kinds of menu destinations.</td></tr>
    <tr><td><a href="#table-VisitorType">VisitorType</a></td><td>Lookup</td><td>Defines visitor audiences.</td></tr>
    <tr><td><a href="#table-ContentType">ContentType</a></td><td>Lookup</td><td>Classifies content documents.</td></tr>
    <tr><td><a href="#table-FormatType">FormatType</a></td><td>Lookup</td><td>Defines content block formats and file extensions.</td></tr>
    <tr><td><a href="#table-MimeType">MimeType</a></td><td>Lookup</td><td>Defines media types and rendering characteristics.</td></tr>
    <tr><td><a href="#table-WorkflowStatus">WorkflowStatus</a></td><td>Lookup</td><td>Defines content workflow states.</td></tr>
    <tr><td><a href="#table-MasterMenu">MasterMenu</a></td><td>Menu</td><td>Holds the imported source menu.</td></tr>
    <tr><td><a href="#table-MasterMenuStage">MasterMenuStage</a></td><td>Menu</td><td>Stages imported menu rows for processing.</td></tr>
    <tr><td><a href="#table-MenuItemTestHarness">MenuItemTestHarness</a></td><td>Menu</td><td>Stores menu test cases and their validation results.</td></tr>
    <tr><td><a href="#table-TestHarness">TestHarness</a></td><td>Menu</td><td>Stores menu test cases and results.</td></tr>
    <tr><td><a href="#table-MenuItem">MenuItem</a></td><td>Menu</td><td>Holds the website's navigation items and route targets.</td></tr>
    <tr><td><a href="#table-PortalMenu">PortalMenu</a></td><td>Menu</td><td>Holds visitor-specific portal tiles.</td></tr>
    <tr><td><a href="#table-BoardMember">BoardMember</a></td><td>Menu</td><td>Holds board member names, roles, biographies, and images.</td></tr>
    <tr><td><a href="#table-ContentDocument">ContentDocument</a></td><td>Content</td><td>Holds a page's content description and publication state.</td></tr>
    <tr><td><a href="#table-ContentElement">ContentElement</a></td><td>Content</td><td>Holds text, media, or file content blocks.</td></tr>
    <tr><td><a href="#table-StagingDocument">StagingDocument</a></td><td>Staging</td><td>Holds a content document being prepared.</td></tr>
    <tr><td><a href="#table-StagingElement">StagingElement</a></td><td>Staging</td><td>Holds content blocks being prepared.</td></tr>
    <tr><td><a href="#table-Registration">Registration</a></td><td>Registration</td><td>Holds a person's email, visitor type, and participation choices.</td></tr>
    <tr><td><a href="#table-Contact">Contact</a></td><td>Registration</td><td>Holds contact and address details for a registration.</td></tr>
    <tr><td><a href="#table-Newsletter">Newsletter</a></td><td>Registration</td><td>Connects a newsletter to its content and dates.</td></tr>
    <tr><td><a href="#table-Email">Email</a></td><td>Registration</td><td>Holds an email subject, body, and sent date.</td></tr>
    <tr><td><a href="#table-EmailRecipient">EmailRecipient</a></td><td>Registration</td><td>Connects an email to a registered recipient.</td></tr>
    <tr><td><a href="#table-EmailAttachment">EmailAttachment</a></td><td>Registration</td><td>Holds a file attached to an email.</td></tr>
    <tr><td><a href="#table-EmailRequest">EmailRequest</a></td><td>Registration</td><td>Holds an outbound email request for processing.</td></tr>
    <tr><td><a href="#table-MigrationDocument">MigrationDocument</a></td><td>Migration</td><td>Stores legacy page metadata captured for migration.</td></tr>
    <tr><td><a href="#table-MigrationElement">MigrationElement</a></td><td>Migration</td><td>Stores legacy page content blocks captured for migration.</td></tr>
    <tr><td><a href="#table-MigrationMapping">MigrationMapping</a></td><td>Migration</td><td>Maps legacy page titles to current menu items.</td></tr>
  </tbody>
</table>

## Tables

<a id="table-SystemTables"></a>
### SystemTables

Complete list of the 31 tables classified by the project seed routine.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>TableID</td><td>INT          IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>TableName</td><td>VARCHAR (50) NOT NULL</td></tr>
    <tr><td>TableType</td><td>VARCHAR (15) NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT          NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([TableID] ASC)</td></tr>
    <tr><td>CK_SystemTables_TableType</td><td>CONSTRAINT [CK_SystemTables_TableType] CHECK ([TableType]=&#39;Migration&#39; OR [TableType]=&#39;Registration&#39; OR [TableType]=&#39;Menu&#39; OR [TableType]=&#39;Staging&#39; OR [TableType]=&#39;Content&#39; OR [TableType]=&#39;Lookup&#39; OR [TableType]=&#39;System&#39;)</td></tr>
    <tr><td>UQ_SystemTables_TableName</td><td>CONSTRAINT [UQ_SystemTables_TableName] UNIQUE NONCLUSTERED ([TableName] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>TableName</th><th>TableType</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>SystemTables</td><td>System</td><td>11</td></tr>
    <tr><td>SystemSettings</td><td>System</td><td>12</td></tr>
    <tr><td>Numbers</td><td>System</td><td>13</td></tr>
    <tr><td>ErrorLog</td><td>System</td><td>14</td></tr>
    <tr><td>RouteType</td><td>Lookup</td><td>21</td></tr>
    <tr><td>VisitorType</td><td>Lookup</td><td>22</td></tr>
    <tr><td>ContentType</td><td>Lookup</td><td>23</td></tr>
    <tr><td>FormatType</td><td>Lookup</td><td>24</td></tr>
    <tr><td>MimeType</td><td>Lookup</td><td>25</td></tr>
    <tr><td>WorkflowStatus</td><td>Lookup</td><td>26</td></tr>
    <tr><td>MasterMenu</td><td>Menu</td><td>30</td></tr>
    <tr><td>MasterMenuStage</td><td>Menu</td><td>31</td></tr>
    <tr><td>MenuItemTestHarness</td><td>Menu</td><td>32</td></tr>
    <tr><td>TestHarness</td><td>Menu</td><td>33</td></tr>
    <tr><td>MenuItem</td><td>Menu</td><td>34</td></tr>
    <tr><td>PortalMenu</td><td>Menu</td><td>35</td></tr>
    <tr><td>BoardMember</td><td>Menu</td><td>36</td></tr>
    <tr><td>ContentDocument</td><td>Content</td><td>41</td></tr>
    <tr><td>ContentElement</td><td>Content</td><td>42</td></tr>
    <tr><td>StagingDocument</td><td>Staging</td><td>51</td></tr>
    <tr><td>StagingElement</td><td>Staging</td><td>52</td></tr>
    <tr><td>Registration</td><td>Registration</td><td>61</td></tr>
    <tr><td>Contact</td><td>Registration</td><td>62</td></tr>
    <tr><td>Newsletter</td><td>Registration</td><td>63</td></tr>
    <tr><td>Email</td><td>Registration</td><td>64</td></tr>
    <tr><td>EmailRecipient</td><td>Registration</td><td>65</td></tr>
    <tr><td>EmailAttachment</td><td>Registration</td><td>66</td></tr>
    <tr><td>EmailRequest</td><td>Registration</td><td>67</td></tr>
    <tr><td>MigrationDocument</td><td>Migration</td><td>70</td></tr>
    <tr><td>MigrationElement</td><td>Migration</td><td>71</td></tr>
    <tr><td>MigrationMapping</td><td>Migration</td><td>72</td></tr>
  </tbody>
</table>

<a id="table-SystemSettings"></a>
### SystemSettings

Stores typed settings such as site configuration, menu source, and feature choices. These rows are from the database project's baseline settings.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>SettingID</td><td>INT           IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>SettingKey</td><td>VARCHAR (50)  NOT NULL</td></tr>
    <tr><td>SettingType</td><td>VARCHAR (50)  NOT NULL</td></tr>
    <tr><td>SettingGroup</td><td>VARCHAR (50)  NOT NULL</td></tr>
    <tr><td>SettingValue</td><td>SQL_VARIANT   NULL</td></tr>
    <tr><td>LastUpdated</td><td>DATETIME2 (7) CONSTRAINT [DF_SystemSettings_LastUpdated] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_SystemSettings_LastUpdated</td><td>CONSTRAINT [DF_SystemSettings_LastUpdated] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_SystemSettings</td><td>CONSTRAINT [PK_SystemSettings] PRIMARY KEY CLUSTERED ([SettingID] ASC)</td></tr>
    <tr><td>CK_SystemSettings_GroupUpper</td><td>CONSTRAINT [CK_SystemSettings_GroupUpper] CHECK (([SettingGroup]) collate Latin1_General_CS_AS=(upper([SettingGroup])) collate Latin1_General_CS_AS)</td></tr>
    <tr><td>CK_SystemSettings_GUID_Valid</td><td>CONSTRAINT [CK_SystemSettings_GUID_Valid] CHECK ([SettingType]&lt;&gt;&#39;GUID&#39; OR TRY_CAST([SettingValue] AS [uniqueidentifier]) IS NOT NULL)</td></tr>
    <tr><td>CK_SystemSettings_JSON_Valid</td><td>CONSTRAINT [CK_SystemSettings_JSON_Valid] CHECK ([SettingType]&lt;&gt;&#39;JSON&#39; OR isjson(CONVERT([nvarchar](max),[SettingValue]))=(1))</td></tr>
    <tr><td>CK_SystemSettings_KeyUpper</td><td>CONSTRAINT [CK_SystemSettings_KeyUpper] CHECK (([SettingKey]) collate Latin1_General_CS_AS=(upper([SettingKey])) collate Latin1_General_CS_AS)</td></tr>
    <tr><td>CK_SystemSettings_SettingGroup</td><td>CONSTRAINT [CK_SystemSettings_SettingGroup] CHECK ([SettingGroup]=&#39;GLOBALVAR&#39; OR [SettingGroup]=&#39;APPLICATION&#39; OR [SettingGroup]=&#39;DATABASE&#39; OR [SettingGroup]=&#39;SYSTEM&#39;)</td></tr>
    <tr><td>CK_SystemSettings_SettingType</td><td>CONSTRAINT [CK_SystemSettings_SettingType] CHECK ([SettingType]=&#39;LIST&#39; OR [SettingType]=&#39;JSON&#39; OR [SettingType]=&#39;GUID&#39; OR [SettingType]=&#39;DATETIME&#39; OR [SettingType]=&#39;DATE&#39; OR [SettingType]=&#39;MONEY&#39; OR [SettingType]=&#39;DECIMAL&#39; OR [SettingType]=&#39;INTEGER&#39; OR [SettingType]=&#39;STRING&#39; OR [SettingType]=&#39;BOOLEAN&#39; OR [SettingType]=&#39;BINARY&#39;)</td></tr>
    <tr><td>CK_SystemSettings_TypeUpper</td><td>CONSTRAINT [CK_SystemSettings_TypeUpper] CHECK (([SettingType]) collate Latin1_General_CS_AS=(upper([SettingType])) collate Latin1_General_CS_AS)</td></tr>
    <tr><td>CK_SystemSettings_Value_NotNull</td><td>CONSTRAINT [CK_SystemSettings_Value_NotNull] CHECK (([SettingType]=&#39;JSON&#39; OR [SettingType]=&#39;GUID&#39; OR [SettingType]=&#39;DATETIME&#39; OR [SettingType]=&#39;DATE&#39; OR [SettingType]=&#39;MONEY&#39; OR [SettingType]=&#39;DECIMAL&#39; OR [SettingType]=&#39;INTEGER&#39; OR [SettingType]=&#39;BOOLEAN&#39; OR [SettingType]=&#39;BINARY&#39;) AND [SettingValue] IS NOT NULL OR ([SettingType]=&#39;LIST&#39; OR [SettingType]=&#39;STRING&#39;))</td></tr>
    <tr><td>UQ_SystemSettings_Key</td><td>CONSTRAINT [UQ_SystemSettings_Key] UNIQUE NONCLUSTERED ([SettingKey] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

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

<a id="table-Numbers"></a>
### Numbers

Contains the integers 1 through 1,000.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>Number</td><td>INT NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([Number] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Number</th></tr></thead>
  <tbody><tr><td>1</td></tr><tr><td>2</td></tr><tr><td>3</td></tr><tr><td>4</td></tr><tr><td>5</td></tr></tbody>
</table>

<a id="table-ErrorLog"></a>
### ErrorLog

Records routine name, message, severity, parameters, and execution context. The following ten rows illustrate possible log entries; they are not captured incidents.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>ErrorLogID</td><td>INT             IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>ProcedureName</td><td>[sysname]       NOT NULL</td></tr>
    <tr><td>ErrorMessage</td><td>NVARCHAR (4000) NULL</td></tr>
    <tr><td>ErrorNumber</td><td>INT             NULL</td></tr>
    <tr><td>ErrorSeverity</td><td>INT             NULL</td></tr>
    <tr><td>ErrorState</td><td>INT             NULL</td></tr>
    <tr><td>Parameters</td><td>NVARCHAR (MAX)  NULL</td></tr>
    <tr><td>UserName</td><td>NVARCHAR (128)  DEFAULT (suser_sname()) NOT NULL</td></tr>
    <tr><td>HostName</td><td>NVARCHAR (128)  DEFAULT (host_name()) NOT NULL</td></tr>
    <tr><td>LogLevel</td><td>VARCHAR (10)    DEFAULT (&#39;ERROR&#39;) NOT NULL</td></tr>
    <tr><td>LogDate</td><td>DATETIME2 (7)   DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([ErrorLogID] ASC)</td></tr>
    <tr><td>CK_ErrorLog_LogLevel</td><td>CONSTRAINT [CK_ErrorLog_LogLevel] CHECK ([LogLevel]=&#39;DEBUG&#39; OR [LogLevel]=&#39;INFO&#39; OR [LogLevel]=&#39;WARNING&#39; OR [LogLevel]=&#39;ERROR&#39;)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>ProcedureName</th><th>ErrorMessage</th><th>LogLevel</th><th>LogDate</th></tr></thead>
  <tbody>
    <tr><td>Populate_MenuItems</td><td>Menu validation failed: route target is missing.</td><td>ERROR</td><td>Example timestamp</td></tr>
    <tr><td>Insert_MenuItem</td><td>Route type is not recognized.</td><td>ERROR</td><td>Example timestamp</td></tr>
    <tr><td>Insert_ContentDocument</td><td>Content type is not recognized.</td><td>ERROR</td><td>Example timestamp</td></tr>
    <tr><td>Insert_ContentElement</td><td>Content document was not found.</td><td>ERROR</td><td>Example timestamp</td></tr>
    <tr><td>Perform_MenuItem_Validation</td><td>Visitor mask contains an unsupported code.</td><td>WARNING</td><td>Example timestamp</td></tr>
    <tr><td>Populate_MasterMenu</td><td>Required source file could not be opened.</td><td>ERROR</td><td>Example timestamp</td></tr>
    <tr><td>Populate_TestHarness</td><td>Test case has no expected result.</td><td>WARNING</td><td>Example timestamp</td></tr>
    <tr><td>Publish_Staging</td><td>Staged menu item could not be published.</td><td>ERROR</td><td>Example timestamp</td></tr>
    <tr><td>Get_SystemSetting</td><td>Requested setting key was not found.</td><td>WARNING</td><td>Example timestamp</td></tr>
    <tr><td>Initialize_Database</td><td>Initialization completed with a logged diagnostic.</td><td>INFO</td><td>Example timestamp</td></tr>
  </tbody>
</table>

## Lookup tables

<a id="table-RouteType"></a>
### RouteType

Identifies how a menu item is opened. All current seed values:

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>Code</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>Folder</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>PK_RouteType</td><td>CONSTRAINT [PK_RouteType] PRIMARY KEY CLUSTERED ([Code] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Code</th><th>Description</th><th>Folder</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>V</td><td>Visitor</td><td>Visitor</td><td>1</td></tr>
    <tr><td>C</td><td>Content</td><td>Content</td><td>2</td></tr>
    <tr><td>P</td><td>Page</td><td>Page</td><td>3</td></tr>
    <tr><td>R</td><td>Redirect</td><td>Redirect</td><td>4</td></tr>
  </tbody>
</table>

<a id="table-VisitorType"></a>
### VisitorType

Defines the visitor types available to the site. All current seed values:

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>Code</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NOT NULL</td></tr>
    <tr><td>IsDefault</td><td>BIT            NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>PK_VisitorType</td><td>CONSTRAINT [PK_VisitorType] PRIMARY KEY CLUSTERED ([Code] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

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

<a id="table-ContentType"></a>
### ContentType

Classifies a content document. All current seed values:

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>Code</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Name</td><td>NVARCHAR (50)  NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>PK_ContentType</td><td>CONSTRAINT [PK_ContentType] PRIMARY KEY CLUSTERED ([Code] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

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

<a id="table-FormatType"></a>
### FormatType

Defines a content block's format and associated file extensions. All current seed values:

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>Code</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Name</td><td>NVARCHAR (50)  NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>FileTypes</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>PK_FormatType</td><td>CONSTRAINT [PK_FormatType] PRIMARY KEY CLUSTERED ([Code] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

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

<a id="table-MimeType"></a>
### MimeType

Identifies the media type and whether content is text, binary, or renderable. All current seed values:

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>Code</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>FormatType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Name</td><td>NVARCHAR (50)  NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>IsText</td><td>BIT            NOT NULL</td></tr>
    <tr><td>IsBinary</td><td>BIT            NOT NULL</td></tr>
    <tr><td>IsRenderable</td><td>BIT            NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>PK_MimeType</td><td>CONSTRAINT [PK_MimeType] PRIMARY KEY CLUSTERED ([Code] ASC)</td></tr>
    <tr><td>FK_MimeType_FormatType</td><td>CONSTRAINT [FK_MimeType_FormatType] FOREIGN KEY ([FormatType]) REFERENCES [dbo].[FormatType] ([Code])</td></tr>
  </tbody>
</table>

#### Sample Data

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

<a id="table-WorkflowStatus"></a>
### WorkflowStatus

Defines the content workflow stage. All current seed values:

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>Code</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Title</td><td>NVARCHAR (50)  NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>PK_WorkflowStatus</td><td>CONSTRAINT [PK_WorkflowStatus] PRIMARY KEY CLUSTERED ([Code] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

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

<a id="table-MasterMenu"></a>
### MasterMenu

Imported source menu entries, including hierarchy labels, route, audience, description, and notes. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>MenuID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>ParentMenuID</td><td>INT            NULL</td></tr>
    <tr><td>MenuItemID</td><td>INT            NULL</td></tr>
    <tr><td>ContentDocumentID</td><td>INT            NULL</td></tr>
    <tr><td>Parent</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>Child</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>SubMenu</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>MenuType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Title</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>VisitorMask</td><td>NVARCHAR (20)  NULL</td></tr>
    <tr><td>RouteType</td><td>NVARCHAR (10)  NULL</td></tr>
    <tr><td>RouteTarget</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>Notes</td><td>NVARCHAR (200) NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>PK_MasterMenu</td><td>CONSTRAINT [PK_MasterMenu] PRIMARY KEY CLUSTERED ([MenuID] ASC)</td></tr>
    <tr><td>UQ_MasterMenu</td><td>CONSTRAINT [UQ_MasterMenu] UNIQUE NONCLUSTERED ([Title] ASC, [RouteType] ASC, [VisitorMask] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-TestHarness"></a>
### TestHarness

Stores menu validation cases and their expected/actual results. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>TestHarnessID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>TestID</td><td>INT            NOT NULL</td></tr>
    <tr><td>ParentTestID</td><td>INT            NULL</td></tr>
    <tr><td>Category</td><td>VARCHAR (50)   NULL</td></tr>
    <tr><td>MenuType</td><td>CHAR (1)       NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (300) NULL</td></tr>
    <tr><td>Notes</td><td>NVARCHAR (300) NULL</td></tr>
    <tr><td>Title</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>RouteType</td><td>CHAR (1)       NULL</td></tr>
    <tr><td>RouteTarget</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>VisitorMask</td><td>VARCHAR (10)   NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NULL</td></tr>
    <tr><td>IsActive</td><td>BIT            NULL</td></tr>
    <tr><td>IsProcessed</td><td>BIT            NULL</td></tr>
    <tr><td>Expected</td><td>VARCHAR (10)   NULL</td></tr>
    <tr><td>Actual</td><td>VARCHAR (10)   NULL</td></tr>
    <tr><td>IsError</td><td>BIT            NULL</td></tr>
    <tr><td>ErrorNumber</td><td>INT            NULL</td></tr>
    <tr><td>ErrorMessage</td><td>NVARCHAR (500) NULL</td></tr>
    <tr><td>MenuItemID</td><td>INT            NULL</td></tr>
    <tr><td>ContentDocumentID</td><td>INT            NULL</td></tr>
  </tbody>
</table>

No constraints are declared in this table definition.

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-MenuItem"></a>
### MenuItem

The navigation records used by the site. For content routes, `RouteTarget` contains the associated `ContentDocumentID`. The examples below are grouped by route type and come from the supplied menu extract.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>MenuItemID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>ParentMenuItemID</td><td>INT            NULL</td></tr>
    <tr><td>Title</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>RouteType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>RouteTarget</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>VisitorMask</td><td>VARCHAR (10)   NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            CONSTRAINT [DF_MenuItem_SortOrder] DEFAULT ((0)) NOT NULL</td></tr>
    <tr><td>IsActive</td><td>BIT            CONSTRAINT [DF_MenuItem_IsActive] DEFAULT ((1)) NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_MenuItem_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_MenuItem_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_MenuItem_SortOrder</td><td>CONSTRAINT [DF_MenuItem_SortOrder] DEFAULT ((0)) NOT NULL</td></tr>
    <tr><td>DF_MenuItem_IsActive</td><td>CONSTRAINT [DF_MenuItem_IsActive] DEFAULT ((1)) NOT NULL</td></tr>
    <tr><td>DF_MenuItem_CreatedDate</td><td>CONSTRAINT [DF_MenuItem_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_MenuItem_ModifiedDate</td><td>CONSTRAINT [DF_MenuItem_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_MenuItem</td><td>CONSTRAINT [PK_MenuItem] PRIMARY KEY CLUSTERED ([MenuItemID] ASC)</td></tr>
    <tr><td>UQ_MenuItem_Title_RouteType_VisitorMask</td><td>CONSTRAINT [UQ_MenuItem_Title_RouteType_VisitorMask] UNIQUE NONCLUSTERED ([Title] ASC, [RouteType] ASC, [VisitorMask] ASC)</td></tr>
    <tr><td>CK_MenuItem_SortOrder</td><td>CONSTRAINT [CK_MenuItem_SortOrder] CHECK ([SortOrder]&gt;=(0))</td></tr>
    <tr><td>CK_MenuItem_Title_Normalized</td><td>CONSTRAINT [CK_MenuItem_Title_Normalized] CHECK (NOT [Title] like &#39;%[%?=&amp;#:/\&lt;&gt;]%&#39;)</td></tr>
    <tr><td>CK_MenuItem_VisitorMask</td><td>CONSTRAINT [CK_MenuItem_VisitorMask] CHECK (NOT [VisitorMask] like &#39;%[^PCMDVR]%&#39; AND len([VisitorMask])&gt;(0))</td></tr>
    <tr><td>FK_MenuItem_Parent</td><td>CONSTRAINT [FK_MenuItem_Parent] FOREIGN KEY ([ParentMenuItemID]) REFERENCES [dbo].[MenuItem] ([MenuItemID])</td></tr>
    <tr><td>FK_MenuItem_RouteType</td><td>CONSTRAINT [FK_MenuItem_RouteType] FOREIGN KEY ([RouteType]) REFERENCES [dbo].[RouteType] ([Code])</td></tr>
  </tbody>
</table>

**Visitor routes (V)**

#### Sample Data

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>ParentMenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody>
    <tr><td>1</td><td>NULL</td><td>Welcome</td><td>/visitor?target=Guest</td><td>PCMDV</td></tr>
    <tr><td>2</td><td>1</td><td>Patient</td><td>/visitor?target=Patient</td><td>PCMDV</td></tr>
  </tbody>
</table>

**Content routes (C)**

#### Sample Data

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th><th>ContentDocumentID</th><th>IsPublished</th></tr></thead>
  <tbody>
    <tr><td>8</td><td>About PG</td><td>/content?target=1</td><td>PCMDV</td><td>1</td><td>0</td></tr>
    <tr><td>9</td><td>What is PG</td><td>/content?target=2</td><td>PCMDV</td><td>2</td><td>0</td></tr>
    <tr><td>18</td><td>Emotional Journey</td><td>/content?target=11</td><td>PCMDV</td><td>11</td><td>0</td></tr>
    <tr><td>25</td><td>Emotional Journey</td><td>/content?target=18</td><td>P</td><td>18</td><td>0</td></tr>
    <tr><td>32</td><td>Emotional Journey</td><td>/content?target=25</td><td>C</td><td>25</td><td>0</td></tr>
    <tr><td>38</td><td>Being a Provider</td><td>/content?target=31</td><td>M</td><td>31</td><td>0</td></tr>
    <tr><td>39</td><td>Early Diagnosis</td><td>/content?target=32</td><td>M</td><td>32</td><td>0</td></tr>
  </tbody>
</table>

**Page routes (P)**

#### Sample Data

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody><tr><td>72</td><td>Clinic Finder</td><td>/page?target=clinicfinder.cshtml</td><td>PCMDV</td></tr></tbody>
</table>

**Redirect routes (R)**

#### Sample Data

<table class="topic-table">
  <thead><tr><th>MenuItemID</th><th>Title</th><th>RouteTarget</th><th>VisitorMask</th></tr></thead>
  <tbody><tr><td>74</td><td>All Things Pyoderma 4.2k members</td><td>/redirect?target=https://www.facebook.com/groups/368163159232</td><td>PCMDV</td></tr></tbody>
</table>

The repeated `Emotional Journey` title represents general, patient, and caregiver pages with separate menu and content IDs. The content rows shown are unpublished placeholders, not authored articles.

<a id="table-PortalMenu"></a>
### PortalMenu

Stores tiles shown for individual visitor types: title, short description, icon path, and linked menu item. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>PortalMenuID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>MenuItemID</td><td>INT            NOT NULL</td></tr>
    <tr><td>Title</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>IconPath</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>VisitorType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_PortalMenu_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_PortalMenu_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_PortalMenu_CreatedDate</td><td>CONSTRAINT [DF_PortalMenu_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_PortalMenu_ModifiedDate</td><td>CONSTRAINT [DF_PortalMenu_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_PortalMenu</td><td>CONSTRAINT [PK_PortalMenu] PRIMARY KEY CLUSTERED ([PortalMenuID] ASC)</td></tr>
    <tr><td>FK_PortalMenu_MenuItem</td><td>CONSTRAINT [FK_PortalMenu_MenuItem] FOREIGN KEY ([MenuItemID]) REFERENCES [dbo].[MenuItem] ([MenuItemID])</td></tr>
    <tr><td>FK_PortalMenu_VisitorType</td><td>CONSTRAINT [FK_PortalMenu_VisitorType] FOREIGN KEY ([VisitorType]) REFERENCES [dbo].[VisitorType] ([Code])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-BoardMember"></a>
### BoardMember

Stores board member names, roles, positions, descriptions, photos, and display order. These names and roles come from the database seed procedure.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>BoardMemberID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>Name</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>Role</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>Position</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (MAX) NULL</td></tr>
    <tr><td>PictureFileName</td><td>VARCHAR (255)  NULL</td></tr>
    <tr><td>PictureFileType</td><td>VARCHAR (50)   NULL</td></tr>
    <tr><td>PictureData</td><td>VARBINARY (MAX) NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            CONSTRAINT [DF_BoardMember_SortOrder] DEFAULT ((0)) NOT NULL</td></tr>
    <tr><td>IsActive</td><td>BIT            CONSTRAINT [DF_BoardMember_IsActive] DEFAULT ((1)) NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_BoardMember_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_BoardMember_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_BoardMember_SortOrder</td><td>CONSTRAINT [DF_BoardMember_SortOrder] DEFAULT ((0)) NOT NULL</td></tr>
    <tr><td>DF_BoardMember_IsActive</td><td>CONSTRAINT [DF_BoardMember_IsActive] DEFAULT ((1)) NOT NULL</td></tr>
    <tr><td>DF_BoardMember_CreatedDate</td><td>CONSTRAINT [DF_BoardMember_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_BoardMember_ModifiedDate</td><td>CONSTRAINT [DF_BoardMember_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_BoardMember</td><td>CONSTRAINT [PK_BoardMember] PRIMARY KEY CLUSTERED ([BoardMemberID] ASC)</td></tr>
    <tr><td>CK_BoardMember_SortOrder</td><td>CONSTRAINT [CK_BoardMember_SortOrder] CHECK ([SortOrder]&gt;=(0))</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Name</th><th>Role</th><th>Position</th><th>PictureFileName</th><th>SortOrder</th></tr></thead>
  <tbody>
    <tr><td>Dr. Alex Ortega Loayza</td><td>Founder</td><td>Medical Director</td><td>Founder.jpg</td><td>1</td></tr>
    <tr><td>Corlis Watkins-Nass</td><td>President</td><td>Marketing</td><td>President.jpg</td><td>2</td></tr>
    <tr><td>Dave DePottie</td><td>Chairman</td><td>Information Technology</td><td>Chairman.jpg</td><td>3</td></tr>
    <tr><td>Lasaunia Thompson</td><td>Treasurer</td><td>Fundraising</td><td>Treasurer.jpg</td><td>4</td></tr>
    <tr><td>LaGail Odoms</td><td>Secretary</td><td>Documentation</td><td>Secretary.jpg</td><td>5</td></tr>
  </tbody>
</table>

## Content tables

<a id="table-ContentDocument"></a>
### ContentDocument

One document-level record is associated with a menu item. Current extract examples are placeholders with `ContentType` U (Unknown), `WorkflowStatus` D (Draft), and `IsPublished` 0.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>ContentDocumentID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>MenuItemID</td><td>INT            NOT NULL</td></tr>
    <tr><td>ContentType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (500) NOT NULL</td></tr>
    <tr><td>MetaData</td><td>NVARCHAR (MAX) NOT NULL</td></tr>
    <tr><td>WorkflowStatus</td><td>CHAR (1)       DEFAULT (&#39;D&#39;) NOT NULL</td></tr>
    <tr><td>IsPublished</td><td>BIT            NOT NULL</td></tr>
    <tr><td>PublishedDate</td><td>DATETIME2 (0)  NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_ContentDocument_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_ContentDocument_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_ContentDocument_CreatedDate</td><td>CONSTRAINT [DF_ContentDocument_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_ContentDocument_ModifiedDate</td><td>CONSTRAINT [DF_ContentDocument_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_ContentDocument</td><td>CONSTRAINT [PK_ContentDocument] PRIMARY KEY CLUSTERED ([ContentDocumentID] ASC)</td></tr>
    <tr><td>CK_ContentDocument_MetaData_IsJSON</td><td>CONSTRAINT [CK_ContentDocument_MetaData_IsJSON] CHECK (isjson([MetaData])=(1))</td></tr>
    <tr><td>FK_ContentDocument_ContentType</td><td>CONSTRAINT [FK_ContentDocument_ContentType] FOREIGN KEY ([ContentType]) REFERENCES [dbo].[ContentType] ([Code])</td></tr>
    <tr><td>FK_ContentDocument_MenuItem</td><td>CONSTRAINT [FK_ContentDocument_MenuItem] FOREIGN KEY ([MenuItemID]) REFERENCES [dbo].[MenuItem] ([MenuItemID]) ON DELETE CASCADE</td></tr>
    <tr><td>FK_ContentDocument_WorkflowStatus</td><td>CONSTRAINT [FK_ContentDocument_WorkflowStatus] FOREIGN KEY ([WorkflowStatus]) REFERENCES [dbo].[WorkflowStatus] ([Code])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>ContentDocumentID</th><th>MenuItemID</th><th>ContentType</th><th>Description</th><th>WorkflowStatus</th><th>IsPublished</th></tr></thead>
  <tbody>
    <tr><td>1</td><td>8</td><td>U</td><td>About PG</td><td>D</td><td>0</td></tr>
    <tr><td>2</td><td>9</td><td>U</td><td>What is PG</td><td>D</td><td>0</td></tr>
    <tr><td>11</td><td>18</td><td>U</td><td>Emotional Journey</td><td>D</td><td>0</td></tr>
    <tr><td>18</td><td>25</td><td>U</td><td>Emotional Journey</td><td>D</td><td>0</td></tr>
    <tr><td>25</td><td>32</td><td>U</td><td>Emotional Journey</td><td>D</td><td>0</td></tr>
    <tr><td>31</td><td>38</td><td>U</td><td>Being a Provider</td><td>D</td><td>0</td></tr>
    <tr><td>32</td><td>39</td><td>U</td><td>Early Diagnosis</td><td>D</td><td>0</td></tr>
  </tbody>
</table>

<a id="table-ContentElement"></a>
### ContentElement

Stores a content block's format, media type, block information, and text, binary, or file content. It has no persisted `SortOrder`, so the schema does not define editorial order for multiple blocks. No authored content elements appear in the supplied extract. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>ContentElementID</td><td>INT             IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>ContentDocumentID</td><td>INT             NOT NULL</td></tr>
    <tr><td>FormatType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>MimeType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>BlockInfo</td><td>NVARCHAR (MAX)  NOT NULL</td></tr>
    <tr><td>TextContent</td><td>NVARCHAR (MAX)  NULL</td></tr>
    <tr><td>BinaryContent</td><td>VARBINARY (MAX) NULL</td></tr>
    <tr><td>LocalFilePath</td><td>NVARCHAR (255)  NULL</td></tr>
    <tr><td>ExternalFilePath</td><td>NVARCHAR (255)  NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_ContentElement_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_ContentElement_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_ContentElement_CreatedDate</td><td>CONSTRAINT [DF_ContentElement_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_ContentElement_ModifiedDate</td><td>CONSTRAINT [DF_ContentElement_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_ContentElement</td><td>CONSTRAINT [PK_ContentElement] PRIMARY KEY CLUSTERED ([ContentElementID] ASC)</td></tr>
    <tr><td>CK_ContentElement_BlockInfo_IsJSON</td><td>CONSTRAINT [CK_ContentElement_BlockInfo_IsJSON] CHECK (isjson([BlockInfo])=(1))</td></tr>
    <tr><td>FK_ContentElement_ContentDocument</td><td>CONSTRAINT [FK_ContentElement_ContentDocument] FOREIGN KEY ([ContentDocumentID]) REFERENCES [dbo].[ContentDocument] ([ContentDocumentID]) ON DELETE CASCADE</td></tr>
    <tr><td>FK_ContentElement_FormatType</td><td>CONSTRAINT [FK_ContentElement_FormatType] FOREIGN KEY ([FormatType]) REFERENCES [dbo].[FormatType] ([Code])</td></tr>
    <tr><td>FK_ContentElement_MimeType</td><td>CONSTRAINT [FK_ContentElement_MimeType] FOREIGN KEY ([MimeType]) REFERENCES [dbo].[MimeType] ([Code])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

## Staging tables

<a id="table-StagingDocument"></a>
### StagingDocument

Holds a content document while it is being prepared. No staging rows are included in the supplied extract. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>StagingDocumentID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>StagingMenuItemID</td><td>INT            NULL</td></tr>
    <tr><td>ContentType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (500) NOT NULL</td></tr>
    <tr><td>Metadata</td><td>NVARCHAR (MAX) NOT NULL</td></tr>
    <tr><td>WorkflowStatus</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_StagingDocument_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_StagingDocument_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_StagingDocument_CreatedDate</td><td>CONSTRAINT [DF_StagingDocument_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_StagingDocument_ModifiedDate</td><td>CONSTRAINT [DF_StagingDocument_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_StagingDocument</td><td>CONSTRAINT [PK_StagingDocument] PRIMARY KEY CLUSTERED ([StagingDocumentID] ASC)</td></tr>
    <tr><td>CK_StagingDocument_Metadata_IsJSON</td><td>CONSTRAINT [CK_StagingDocument_Metadata_IsJSON] CHECK (isjson([Metadata])=(1))</td></tr>
    <tr><td>FK_StagingDocument_ContentType</td><td>CONSTRAINT [FK_StagingDocument_ContentType] FOREIGN KEY ([ContentType]) REFERENCES [dbo].[ContentType] ([Code])</td></tr>
    <tr><td>FK_StagingDocument_StagingMenuItem</td><td>CONSTRAINT [FK_StagingDocument_StagingMenuItem] FOREIGN KEY ([StagingMenuItemID]) REFERENCES [dbo].[StagingMenuItem] ([StagingMenuItemID])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-StagingElement"></a>
### StagingElement

Holds a text, media, or file block associated with a staged document. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>StagingElementID</td><td>INT             IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>StagingDocumentID</td><td>INT             NOT NULL</td></tr>
    <tr><td>WorkflowStatus</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>FormatType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>MimeType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>BlockInfo</td><td>NVARCHAR (MAX)  NOT NULL</td></tr>
    <tr><td>TextContent</td><td>NVARCHAR (MAX)  NULL</td></tr>
    <tr><td>BinaryContent</td><td>VARBINARY (MAX) NULL</td></tr>
    <tr><td>LocalFilePath</td><td>NVARCHAR (255)  NULL</td></tr>
    <tr><td>ExternalFilePath</td><td>NVARCHAR (255)  NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_StagingElement_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_StagingElement_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_StagingElement_CreatedDate</td><td>CONSTRAINT [DF_StagingElement_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_StagingElement_ModifiedDate</td><td>CONSTRAINT [DF_StagingElement_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_StagingElement</td><td>CONSTRAINT [PK_StagingElement] PRIMARY KEY CLUSTERED ([StagingElementID] ASC)</td></tr>
    <tr><td>CK_StagingElement_BlockInfo_IsJSON</td><td>CONSTRAINT [CK_StagingElement_BlockInfo_IsJSON] CHECK (isjson([BlockInfo])=(1))</td></tr>
    <tr><td>FK_StagingElement_FormatType</td><td>CONSTRAINT [FK_StagingElement_FormatType] FOREIGN KEY ([FormatType]) REFERENCES [dbo].[FormatType] ([Code])</td></tr>
    <tr><td>FK_StagingElement_MimeType</td><td>CONSTRAINT [FK_StagingElement_MimeType] FOREIGN KEY ([MimeType]) REFERENCES [dbo].[MimeType] ([Code])</td></tr>
    <tr><td>FK_StagingElement_StagingDocument</td><td>CONSTRAINT [FK_StagingElement_StagingDocument] FOREIGN KEY ([StagingDocumentID]) REFERENCES [dbo].[StagingDocument] ([StagingDocumentID])</td></tr>
    <tr><td>FK_StagingElement_WorkflowStatus</td><td>CONSTRAINT [FK_StagingElement_WorkflowStatus] FOREIGN KEY ([WorkflowStatus]) REFERENCES [dbo].[WorkflowStatus] ([Code])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

## Registration tables

<a id="table-Registration"></a>
### Registration

Stores the email address, visitor type, optional account credentials, and participation preferences. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>RegistrationID</td><td>INT             IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>Email</td><td>NVARCHAR (500)  NOT NULL</td></tr>
    <tr><td>PasswordHash</td><td>VARBINARY (256) NULL</td></tr>
    <tr><td>PasswordSalt</td><td>VARBINARY (256) NULL</td></tr>
    <tr><td>VisitorType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>IsMember</td><td>BIT             NOT NULL</td></tr>
    <tr><td>IsVolunteer</td><td>BIT             NOT NULL</td></tr>
    <tr><td>IsNewsLetter</td><td>BIT             NOT NULL</td></tr>
    <tr><td>IsFundraising</td><td>BIT             NOT NULL</td></tr>
    <tr><td>IsActive</td><td>BIT             NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_Registration_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_Registration_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_Registration_CreatedDate</td><td>CONSTRAINT [DF_Registration_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_Registration_ModifiedDate</td><td>CONSTRAINT [DF_Registration_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([RegistrationID] ASC)</td></tr>
    <tr><td>FK_Registration_VisitorType</td><td>CONSTRAINT [FK_Registration_VisitorType] FOREIGN KEY ([VisitorType]) REFERENCES [dbo].[VisitorType] ([Code])</td></tr>
    <tr><td>UQ_Registration_Email</td><td>CONSTRAINT [UQ_Registration_Email] UNIQUE NONCLUSTERED ([Email] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-Contact"></a>
### Contact

Stores a registrant's name and optional contact and address details. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>ContactID</td><td>INT           IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>RegistrationID</td><td>INT           NOT NULL</td></tr>
    <tr><td>FirstName</td><td>VARCHAR (100) NOT NULL</td></tr>
    <tr><td>LastName</td><td>VARCHAR (100) NOT NULL</td></tr>
    <tr><td>MiddleName</td><td>VARCHAR (100) NULL</td></tr>
    <tr><td>MobilePhone</td><td>VARCHAR (20)  NULL</td></tr>
    <tr><td>HomePhone</td><td>VARCHAR (20)  NULL</td></tr>
    <tr><td>WorkPhone</td><td>VARCHAR (20)  NULL</td></tr>
    <tr><td>WorkEmail</td><td>VARCHAR (500) NULL</td></tr>
    <tr><td>AddressLine1</td><td>VARCHAR (200) NULL</td></tr>
    <tr><td>AddressLine2</td><td>VARCHAR (200) NULL</td></tr>
    <tr><td>ForeignAddress</td><td>VARCHAR (500) NULL</td></tr>
    <tr><td>City</td><td>VARCHAR (100) NULL</td></tr>
    <tr><td>StateProvince</td><td>VARCHAR (100) NULL</td></tr>
    <tr><td>PostalCode</td><td>VARCHAR (20)  NULL</td></tr>
    <tr><td>Country</td><td>VARCHAR (100) NULL</td></tr>
    <tr><td>DateOfBirth</td><td>DATE          NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0) CONSTRAINT [DF_Contact_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0) CONSTRAINT [DF_Contact_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_Contact_CreatedDate</td><td>CONSTRAINT [DF_Contact_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_Contact_ModifiedDate</td><td>CONSTRAINT [DF_Contact_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([ContactID] ASC)</td></tr>
    <tr><td>FK_Contact_Registration</td><td>CONSTRAINT [FK_Contact_Registration] FOREIGN KEY ([RegistrationID]) REFERENCES [dbo].[Registration] ([RegistrationID])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-Newsletter"></a>
### Newsletter

Connects a content document to a newsletter description and its distribution and publication dates. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>NewsletterID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>ContentDocumentID</td><td>INT            NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (MAX) NOT NULL</td></tr>
    <tr><td>NewsletterType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>DistributionDate</td><td>DATETIME2 (7)  DEFAULT (sysutcdatetime()) NOT NULL</td></tr>
    <tr><td>PublishDate</td><td>DATETIME2 (7)  DEFAULT (sysutcdatetime()) NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_Newsletter_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_Newsletter_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_Newsletter_CreatedDate</td><td>CONSTRAINT [DF_Newsletter_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_Newsletter_ModifiedDate</td><td>CONSTRAINT [DF_Newsletter_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([NewsletterID] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-Email"></a>
### Email

Stores the subject and body of a message and when it was sent. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>EmailID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>Subject</td><td>VARCHAR (200)  NOT NULL</td></tr>
    <tr><td>BodyText</td><td>NVARCHAR (MAX) NULL</td></tr>
    <tr><td>SentDate</td><td>DATETIME2 (7)  NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_Email_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_Email_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_Email_CreatedDate</td><td>CONSTRAINT [DF_Email_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_Email_ModifiedDate</td><td>CONSTRAINT [DF_Email_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([EmailID] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-EmailRecipient"></a>
### EmailRecipient

Connects a message to a registration and can record when it was sent. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>EmailRecipientID</td><td>INT           IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>EmailID</td><td>INT           NOT NULL</td></tr>
    <tr><td>RegistrationID</td><td>INT           NOT NULL</td></tr>
    <tr><td>DateSent</td><td>DATETIME2 (7) NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0) CONSTRAINT [DF_EmailRecipient_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_EmailRecipient_CreatedDate</td><td>CONSTRAINT [DF_EmailRecipient_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([EmailRecipientID] ASC)</td></tr>
    <tr><td>FK_EmailRecipient_Email</td><td>CONSTRAINT [FK_EmailRecipient_Email] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[Email] ([EmailID]) ON DELETE CASCADE</td></tr>
    <tr><td>FK_EmailRecipient_Registration</td><td>CONSTRAINT [FK_EmailRecipient_Registration] FOREIGN KEY ([RegistrationID]) REFERENCES [dbo].[Registration] ([RegistrationID]) ON DELETE CASCADE</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-EmailAttachment"></a>
### EmailAttachment

Stores an attached file's name, type, and binary contents; it may also refer to a newsletter. 

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>EmailAttachmentID</td><td>INT             IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>EmailID</td><td>INT             NOT NULL</td></tr>
    <tr><td>NewsLetterID</td><td>INT             NULL</td></tr>
    <tr><td>FileName</td><td>VARCHAR (255)   NOT NULL</td></tr>
    <tr><td>FileType</td><td>VARCHAR (50)    NOT NULL</td></tr>
    <tr><td>FileData</td><td>VARBINARY (MAX) NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_EmailAttachment_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_EmailAttachment_CreatedDate</td><td>CONSTRAINT [DF_EmailAttachment_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([EmailAttachmentID] ASC)</td></tr>
    <tr><td>FK_EmailAttachment_Email</td><td>CONSTRAINT [FK_EmailAttachment_Email] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[Email] ([EmailID])</td></tr>
    <tr><td>FK_EmailAttachment_Newsletter</td><td>CONSTRAINT [FK_EmailAttachment_Newsletter] FOREIGN KEY ([NewsLetterID]) REFERENCES [dbo].[Newsletter] ([NewsletterID])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

## Other SQL project tables

These supporting, migration, audit, and legacy tables are not assigned a `TableType` in `SystemTables`. No sample records are available for them in the supplied project data.

<a id="table-EmailRequest"></a>
### EmailRequest

Holds a requested message, its processing state, and the resulting `EmailID` when processed.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>EmailRequestID</td><td>INT             IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>RegistrationID</td><td>INT             NULL</td></tr>
    <tr><td>RequestType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>Subject</td><td>NVARCHAR (200)  NOT NULL</td></tr>
    <tr><td>RequestBody</td><td>NVARCHAR (MAX)  NOT NULL</td></tr>
    <tr><td>IsProcessed</td><td>BIT             NOT NULL CONSTRAINT [DF_EmailRequest_IsProcessed] DEFAULT ((0))</td></tr>
    <tr><td>ProcessedDate</td><td>DATETIME2 (7)   NULL</td></tr>
    <tr><td>ProcessedEmailID</td><td>INT             NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_EmailRequest_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_EmailRequest_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_EmailRequest_IsProcessed</td><td>CONSTRAINT [DF_EmailRequest_IsProcessed] DEFAULT ((0))</td></tr>
    <tr><td>DF_EmailRequest_CreatedDate</td><td>CONSTRAINT [DF_EmailRequest_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_EmailRequest_ModifiedDate</td><td>CONSTRAINT [DF_EmailRequest_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([EmailRequestID] ASC)</td></tr>
    <tr><td>FK_EmailRequest_Registration</td><td>CONSTRAINT [FK_EmailRequest_Registration] FOREIGN KEY ([RegistrationID]) REFERENCES [dbo].[Registration] ([RegistrationID])</td></tr>
    <tr><td>FK_EmailRequest_Email</td><td>CONSTRAINT [FK_EmailRequest_Email] FOREIGN KEY ([ProcessedEmailID]) REFERENCES [dbo].[Email] ([EmailID])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-MasterMenu_Stage"></a>
### MasterMenu_Stage

Menu-import staging rows with a load order and source menu fields.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>LoadOrder</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>Parent</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>Child</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>SubMenu</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>Type</td><td>NVARCHAR (10)  NOT NULL</td></tr>
    <tr><td>VisitorMask</td><td>NVARCHAR (20)  NULL</td></tr>
    <tr><td>RouteType</td><td>NVARCHAR (10)  NULL</td></tr>
    <tr><td>RouteTarget</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>Notes</td><td>NVARCHAR (200) NULL</td></tr>
  </tbody>
</table>

No constraints are declared in this table definition.

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-MasterMenuStage"></a>
### MasterMenuStage

Holds imported menu fields in the second menu-import staging table.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>MenuID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>Parent</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>Child</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>SubMenu</td><td>NVARCHAR (100) NOT NULL</td></tr>
    <tr><td>VisitorMask</td><td>NVARCHAR (20)  NULL</td></tr>
    <tr><td>RouteType</td><td>NVARCHAR (10)  NULL</td></tr>
    <tr><td>RouteTarget</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>Notes</td><td>NVARCHAR (200) NULL</td></tr>
  </tbody>
</table>

No constraints are declared in this table definition.

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-MenuItemTestHarness"></a>
### MenuItemTestHarness

Stores menu-specific test cases, expected outcomes, and processing results.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>TestID</td><td>INT            NOT NULL</td></tr>
    <tr><td>ParentTestID</td><td>INT            NULL</td></tr>
    <tr><td>Category</td><td>VARCHAR (50)   NOT NULL</td></tr>
    <tr><td>Type</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (300) NOT NULL</td></tr>
    <tr><td>Expected</td><td>VARCHAR (10)   NOT NULL</td></tr>
    <tr><td>Result</td><td>VARCHAR (10)   NULL</td></tr>
    <tr><td>IsError</td><td>BIT            NULL</td></tr>
    <tr><td>Notes</td><td>NVARCHAR (500) NULL</td></tr>
    <tr><td>Title</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>RouteType</td><td>CHAR (1)       NULL</td></tr>
    <tr><td>RouteTarget</td><td>NVARCHAR (200) NULL</td></tr>
    <tr><td>VisitorMask</td><td>VARCHAR (10)   NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            NULL</td></tr>
    <tr><td>IsActive</td><td>BIT            NULL</td></tr>
    <tr><td>IsProcessed</td><td>BIT            NULL</td></tr>
  </tbody>
</table>

No constraints are declared in this table definition.

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-MigrationDocument"></a>
### MigrationDocument

Holds captured legacy page titles, content classifications, descriptions, and metadata.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>MigrationDocumentID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>MenuTitle</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>ContentType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>Description</td><td>NVARCHAR (500) NOT NULL</td></tr>
    <tr><td>MetaData</td><td>NVARCHAR (MAX) NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_Migration_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_Migration_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_Migration_CreatedDate</td><td>CONSTRAINT [DF_Migration_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_Migration_ModifiedDate</td><td>CONSTRAINT [DF_Migration_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_Migration</td><td>CONSTRAINT [PK_Migration] PRIMARY KEY CLUSTERED ([MigrationDocumentID] ASC)</td></tr>
    <tr><td>CK_MigrationDocument_MetaData_IsJSON</td><td>CONSTRAINT [CK_MigrationDocument_MetaData_IsJSON] CHECK (isjson([MetaData])=(1))</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-MigrationElement"></a>
### MigrationElement

Holds a captured text or media block associated with a legacy document.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>MigrationElementID</td><td>INT             IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>MigrationDocumentID</td><td>INT             NOT NULL</td></tr>
    <tr><td>FormatType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>MimeType</td><td>CHAR (1)        NOT NULL</td></tr>
    <tr><td>BlockInfo</td><td>NVARCHAR (MAX)  NOT NULL</td></tr>
    <tr><td>TextMigration</td><td>NVARCHAR (MAX)  NULL</td></tr>
    <tr><td>BinaryMigration</td><td>VARBINARY (MAX) NULL</td></tr>
    <tr><td>LocalFilePath</td><td>NVARCHAR (255)  NULL</td></tr>
    <tr><td>ExternalFilePath</td><td>NVARCHAR (255)  NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_MigrationElement_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)   CONSTRAINT [DF_MigrationElement_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_MigrationElement_CreatedDate</td><td>CONSTRAINT [DF_MigrationElement_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_MigrationElement_ModifiedDate</td><td>CONSTRAINT [DF_MigrationElement_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_MigrationElement</td><td>CONSTRAINT [PK_MigrationElement] PRIMARY KEY CLUSTERED ([MigrationElementID] ASC)</td></tr>
    <tr><td>CK_MigrationElement_BlockInfo_IsJSON</td><td>CONSTRAINT [CK_MigrationElement_BlockInfo_IsJSON] CHECK (isjson([BlockInfo])=(1))</td></tr>
    <tr><td>FK_MigrationElement_FormatType</td><td>CONSTRAINT [FK_MigrationElement_FormatType] FOREIGN KEY ([FormatType]) REFERENCES [dbo].[FormatType] ([Code])</td></tr>
    <tr><td>FK_MigrationElement_MigrationDocument</td><td>CONSTRAINT [FK_MigrationElement_MigrationDocument] FOREIGN KEY ([MigrationDocumentID]) REFERENCES [dbo].[MigrationDocument] ([MigrationDocumentID]) ON DELETE CASCADE</td></tr>
    <tr><td>FK_MigrationElement_MimeType</td><td>CONSTRAINT [FK_MigrationElement_MimeType] FOREIGN KEY ([MimeType]) REFERENCES [dbo].[MimeType] ([Code])</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-MigrationMapping"></a>
### MigrationMapping

Connects an old menu title to its destination `MenuItemID` and records whether the match is correct.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>MigrationMappingID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>OldMenuTitle</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>MenuItemID</td><td>INT            NULL</td></tr>
    <tr><td>IsCorrect</td><td>BIT            NULL</td></tr>
  </tbody>
</table>

No constraints are declared in this table definition.

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>


<a id="table-StagingMenuItem"></a>
### StagingMenuItem

Holds a menu hierarchy and routes before they become active `MenuItem` records.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>StagingMenuItemID</td><td>INT            IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>ParentMenuItemID</td><td>INT            NULL</td></tr>
    <tr><td>Title</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>RouteType</td><td>CHAR (1)       NOT NULL</td></tr>
    <tr><td>RouteTarget</td><td>NVARCHAR (200) NOT NULL</td></tr>
    <tr><td>VisitorMask</td><td>VARCHAR (10)   NOT NULL</td></tr>
    <tr><td>SortOrder</td><td>INT            CONSTRAINT [DF_StagingMenuItem_SortOrder] DEFAULT ((0)) NOT NULL</td></tr>
    <tr><td>IsActive</td><td>BIT            CONSTRAINT [DF_StagingMenuItem_IsActive] DEFAULT ((1)) NOT NULL</td></tr>
    <tr><td>CreatedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_StagingMenuItem_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>ModifiedDate</td><td>DATETIME2 (0)  CONSTRAINT [DF_StagingMenuItem_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>DF_StagingMenuItem_SortOrder</td><td>CONSTRAINT [DF_StagingMenuItem_SortOrder] DEFAULT ((0)) NOT NULL</td></tr>
    <tr><td>DF_StagingMenuItem_IsActive</td><td>CONSTRAINT [DF_StagingMenuItem_IsActive] DEFAULT ((1)) NOT NULL</td></tr>
    <tr><td>DF_StagingMenuItem_CreatedDate</td><td>CONSTRAINT [DF_StagingMenuItem_CreatedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>DF_StagingMenuItem_ModifiedDate</td><td>CONSTRAINT [DF_StagingMenuItem_ModifiedDate] DEFAULT (sysdatetime()) NOT NULL</td></tr>
    <tr><td>PK_StagingMenuItem</td><td>CONSTRAINT [PK_StagingMenuItem] PRIMARY KEY CLUSTERED ([StagingMenuItemID] ASC)</td></tr>
    <tr><td>CK_StagingMenuItem_SortOrder</td><td>CONSTRAINT [CK_StagingMenuItem_SortOrder] CHECK ([SortOrder]&gt;=(0))</td></tr>
    <tr><td>CK_StagingMenuItem_Title_Normalized</td><td>CONSTRAINT [CK_StagingMenuItem_Title_Normalized] CHECK (NOT [Title] like &#39;%[%?=&amp;#:/\&lt;&gt;]%&#39;)</td></tr>
    <tr><td>CK_StagingMenuItem_VisitorMask</td><td>CONSTRAINT [CK_StagingMenuItem_VisitorMask] CHECK (NOT [VisitorMask] like &#39;%[^PCMDVR]%&#39; AND len([VisitorMask])&gt;(0))</td></tr>
    <tr><td>FK_StagingMenuItem_Parent</td><td>CONSTRAINT [FK_StagingMenuItem_Parent] FOREIGN KEY ([ParentMenuItemID]) REFERENCES [dbo].[StagingMenuItem] ([StagingMenuItemID])</td></tr>
    <tr><td>FK_StagingMenuItem_RouteType</td><td>CONSTRAINT [FK_StagingMenuItem_RouteType] FOREIGN KEY ([RouteType]) REFERENCES [dbo].[RouteType] ([Code])</td></tr>
    <tr><td>UQ_StagingMenuItem_Title_RouteType_VisitorMask</td><td>CONSTRAINT [UQ_StagingMenuItem_Title_RouteType_VisitorMask] UNIQUE NONCLUSTERED ([Title] ASC, [RouteType] ASC, [VisitorMask] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>

<a id="table-SystemSettings_Audit"></a>
### SystemSettings_Audit

Keeps prior setting values and the dates they were last updated and audited.

**Implemented columns**

<table class="topic-table">
  <thead><tr><th>Column</th><th>SQL definition</th></tr></thead>
  <tbody>
    <tr><td>AuditID</td><td>INT           IDENTITY (1, 1) NOT NULL</td></tr>
    <tr><td>SettingID</td><td>INT           NOT NULL</td></tr>
    <tr><td>SettingKey</td><td>VARCHAR (50)  NOT NULL</td></tr>
    <tr><td>SettingType</td><td>VARCHAR (50)  NOT NULL</td></tr>
    <tr><td>SettingGroup</td><td>VARCHAR (50)  NOT NULL</td></tr>
    <tr><td>SettingValue</td><td>SQL_VARIANT   NULL</td></tr>
    <tr><td>LastUpdated</td><td>DATETIME2 (7) NOT NULL</td></tr>
    <tr><td>AuditDate</td><td>DATETIME2 (7) DEFAULT (sysdatetime()) NOT NULL</td></tr>
  </tbody>
</table>

**Constraints and foreign keys**

<table class="topic-table">
  <thead><tr><th>Name</th><th>Definition</th></tr></thead>
  <tbody>
    <tr><td>Unnamed PRIMARY KEY</td><td>PRIMARY KEY CLUSTERED ([AuditID] ASC)</td></tr>
  </tbody>
</table>

#### Sample Data

<table class="topic-table">
  <thead><tr><th>Sample status</th></tr></thead>
  <tbody><tr><td>NO DATA AVAILABLE</td></tr></tbody>
</table>


## Database objects

The following lists cover every view, function, and stored procedure in the database project. They summarize each object by its role.

### Views

<table class="topic-table">
  <thead><tr><th>Name</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td>ContentDocumentList</td><td>Provides a unified view of ContentDocument records joined with MenuItem, RouteType, ContentType, and WorkflowStatus metadata for validation and reporting.</td></tr>
    <tr><td>ContentElementList</td><td>Provides a unified view of ContentElement records joined with ContentDocument, MenuItem, RouteType, ContentType, FormatType, MimeType, and WorkflowStatus metadata for validation and reporting.</td></tr>
    <tr><td>MasterMenuList</td><td>Provides the imported MasterMenu rows with a resolved Title based on the populated hierarchy column and resolved menu and content mappings.</td></tr>
    <tr><td>MenuItemList</td><td>Provides a unified view of MenuItem records joined with ContentDocument and parent MenuItem metadata for validation and reporting.</td></tr>
    <tr><td>MissingPlaceholders</td><td>Lists content-route menu items that do not yet have a ContentDocument placeholder.</td></tr>
    <tr><td>MissingTableList</td><td>Returns all tables from TableList that do not currently exist in the database. Used to determine which lookup tables must be created.</td></tr>
    <tr><td>PatientRegistry</td><td>Returns all Registration records that are Patients</td></tr>
    <tr><td>RegistrationList</td><td>Returns all Registration records joined to Contact</td></tr>
    <tr><td>StagingDocumentList</td><td>Provides a unified view of StagingDocument joined to StagingMenuItem with RouteType, ContentType and WorkflowStatus descriptions.</td></tr>
    <tr><td>StagingElementList</td><td>Shows staged content elements with their staged document, menu, and lookup details.</td></tr>
    <tr><td>StagingMenuItemList</td><td>Shows staged menu items with parent, route, and staged content details.</td></tr>
    <tr><td>TableList</td><td>Returns metadata for all system tables including existence, column count, index count, constraint count, record count, and creation/modification timestamps.</td></tr>
  </tbody>
</table>


### Functions

<table class="topic-table">
  <thead><tr><th style="white-space: nowrap; width: 1%;">Name</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td style="white-space: nowrap; width: 1%;">Create_MetaData</td><td>Generates a standardized JSON metadata object for documenting content. Accepts title, author, description, category, and comma-separated tags, returning a structured JSON object with creation/modification timestamps.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Get_SystemSetting</td><td>Returns the SettingValue for a given SettingKey from the SystemSettings table. Returns NULL if the key is invalid or not found.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Get_TableList</td><td>Returns a comma‑separated list of table names from SystemTables ordered by SortOrder. Accepts a table type filter such as &#39;Lookup&#39;, &#39;System&#39;, &#39;Content&#39;, etc. Use ALL, null, or empty string for all tables.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_ErrorMessage</td><td>Normalizes an error or debug message by removing trailing punctuation unless the message ends with an allowed emphasis sequence.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_RouteTarget</td><td>Builds a route target from the route type and supplied value, validating visitor, page, redirect, or content targets.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_RouteType</td><td>Uppercases a route type and returns its code only when it exists in RouteType.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_SettingKey</td><td>Normalizes a slug with optional uppercasing and a configurable separator. Despite its name, it processes a slug input rather than a setting key.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_Slug</td><td>Normalizes a slug string by converting to lowercase, replacing spaces with hyphens, removing special characters, and cleaning up multiple/leading/trailing hyphens. Returns a URL-friendly slug string.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_Title</td><td>Cleans a title string for safe use in URLs and query strings. Trims whitespace, removes URL-breaking characters, and collapses multiple spaces into a single space.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_Token</td><td>Normalizes a single token by trimming whitespace, removing all non-alphanumeric characters, and converting the result to uppercase.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Normalize_VisitorMask</td><td>Uppercases and validates visitor codes, removes duplicates, orders them by VisitorType, and expands ALL or A to the full mask.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">SplitCSVRow</td><td>Splits one CSV row into its field values while respecting quoted fields.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">TableExists</td><td>Returns 1 if a table exists in the dbo schema, otherwise 0.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">TablesExists</td><td>Checks whether all requested tables exist in the database.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Validate_Url</td><td>Validates an external URL string without using regular expressions. This function is intentionally strict and only accepts true external URLs. Accepts: - absolute URLs starting with http:// or https:// - hostnames such as example.com or www.example.com - hostnames with paths or queries - IPv4 addresses with optional paths Rejects: - internal paths starting with / - email addresses - non-http schemes (mailto:, ftp:, file:, tel:, sms:, etc.) - malformed URLs - protocol-relative URLs (//example.com) - file paths - query-only or fragment-only strings Returns 1 if valid, 0 otherwise.</td></tr>
  </tbody>
</table>


### Stored procedures

<table class="topic-table">
  <thead><tr><th style="white-space: nowrap; width: 1%;">Name</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td style="white-space: nowrap; width: 1%;">Clear_ErrorLog</td><td>Clears the ErrorLog table, reseeds the identity, inserts an initialization record, and logs opening and closing messages tied to @LogDate.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_BoardMember_Table</td><td>Drops and recreates the BoardMember table. Not part of the content system (no ContentType) -- the Board of Directors page is a static Page route (RouteType=&#39;P&#39;) that queries this table directly. Bio is deferred (not yet a column).</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Content_MetaData</td><td>Generates a standardized JSON metadata object for ContentDocument metadata. Accepts title, author, description, a category token, and a comma-separated list of tags, returning a structured JSON object with standard timestamps and version information.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Content_Tables</td><td>Creates ContentDocument and ContentElement tables using refactored naming conventions and JSON validation rules.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Element_MetaData</td><td>Generates a standardized JSON metadata object for content elements. Controls placement and tagging of the element within the content body.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_ErrorLog_Table</td><td>Drops and recreates the ErrorLog table using the latest schema standards. Inserts an initialization record and logs opening and closing messages tied to @LogDate.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Lookup_Tables</td><td>Drops and recreates all lookup tables, removes dependent foreign keys, repopulates lookup tables, and restores foreign key constraints.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_MasterMenu_Table</td><td>Drops and recreates the MasterMenu table used to store the raw menu definition imported from the MASTER_MENU CSV. The location of the file is a system setting</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Menu_Tables</td><td>Creates the master-menu and menu-related tables.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_MenuItem_Table</td><td>Drops and recreates the MenuItem table. Removes foreign key references from StagingDocument and ContentDocument, deletes all MenuItem records, recreates the table with full constraints, and optionally populates initial menu items.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Migration_Tables</td><td>Creates the legacy migration document, element, and mapping tables.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Numbers_Table</td><td>Creates and populates the Numbers tally table used by normalization functions. Recreates the table each time.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_PortalMenu_Table</td><td>Creates the PortalMenu table for visitor-specific portal tiles.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Registration_Tables</td><td>Create all the tables needed for Registration and various contacts with users</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Staging_Tables</td><td>Creates staging tables used for temporary content processing. Drops existing staging tables and recreates them with full constraints. Requires lookup tables to exist first.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_System_Tables</td><td>Recreates all core system tables if missing. Each table creation procedure is responsible for its own existence check. This routine simply orchestrates the creation of ErrorLog, SystemTables, SystemSettings, and Numbers tables.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_SystemSettings_Table</td><td>Drops and recreates the SystemSettings and SystemSettings_Audit tables. Applies all validation constraints and initializes settings using Populate_SystemSettings.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_SystemTables_Table</td><td>Drops and recreates the SystemTables lookup table, then inserts canonical system, lookup, content, staging, and menu table definitions.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_TableList_Table</td><td>Legacy routine that creates and seeds a physical TableList table. The current project defines TableList as a view, so this routine appears outdated.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_Tables</td><td>Creates all tables needed for the AllThingsPG database including system, lookup, menu, content, and staging tables. Executes individual table procedures in correct dependency order.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_TempTable_FromCSV</td><td>Reads the header row of a CSV file and dynamically creates a global temp table (##MenuCSV) with one NVARCHAR(MAX) column per header field.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Create_TestHarness_Table</td><td>Drops and recreates the TestHarness table used for testing menus</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Delete_Content</td><td>Deletes ContentDocument and related ContentElement records based on ContentDocumentID or MenuItemID Supports full purge with identity reseed</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Delete_MenuItem</td><td>Deletes a single MenuItem or all MenuItem records depending on the DeleteAll flag. Includes validation, reseeding, and full error handling.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Delete_Staging</td><td>Deletes StagingDocument and StagingElement records based on StagingDocumentID or StagingMenuItemID Supports full purge with identity reseed</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Execute_TestHarness</td><td>Executes the TestHarness table to insert parent and child MenuItems into StagingMenuItem table, capturing MenuItemID and ContentDocumentID results and marking tests as PASS/FAIL based on Expected vs Actual.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Get_RouteType</td><td>Normalizes a RouteType value by trimming whitespace, uppercasing the input, validating length, and returning the matching RouteType.Code value.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Get_SystemInfo</td><td>Retrieves a system setting by key. Returns the raw sql_variant value via output parameter. Throws if the key is not found.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Initialize_Database</td><td>Initializes the database by 1) creating missing 2) clearing logs 3) deleting core data 4) reseeding identities 5) repopulating system tables</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_BoardMember</td><td>Inserts a new BoardMember record.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_Content_Placeholder</td><td>Inserts a content record for a MenuItem that does not have one. Validates MenuItemID and Title before creating the ContentDocument record.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_ContentDocument</td><td>Inserts a new ContentDocument record after validating content type, workflow status, JSON metadata, and ensuring only one ContentDocument exists per MenuItemID.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_ContentElement</td><td>Inserts a new ContentElement record linked to a ContentDocument. Validates ContentDocumentID, FormatType, MimeType and JSON format for BlockInfo. Enforces mutual exclusivity between TextContent and BinaryContent.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_EmailRequest</td><td>Inserts a new outbound email request tied to a Registration when available.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_MenuItem</td><td>Inserts a StagingMenuItem record with full validation, normalization, auto-sort ordering, placeholder creation, and full logging/error handling</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_MenuItem_Child</td><td>Inserts a child MenuItem under a specified parent. Inherits RouteType, VisitorMask, and IsActive when not supplied. Auto-generates RouteTarget and SortOrder when needed.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_MenuItem_Parent</td><td>Adds a parent menu item to the staging menu.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_MissingContentPlaceholders</td><td>Iterates through all MenuItems with RouteType = &#39;C&#39; and ensures each has a ContentDocument placeholder. Calls Insert_Content_Placeholder for any missing ContentDocument record.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Insert_Registration</td><td>Inserts a new Registration + Contact, or if a Registration already exists for @Email, updates that Registration&#39;s VisitorType/flags and its existing Contact in place (never creates a second Registration or a second Contact for the same email).</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Log_Debug</td><td>Inserts a debug entry into the ErrorLog table. If the table does not exist, it is created automatically and a warning entry is logged. Used by all procedures to record debug messages tied to a specific LogDate.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Log_Error</td><td>Inserts an error entry into the ErrorLog table. If the table does not exist, it is created automatically and a warning entry is logged. This procedure is used by all error handling blocks to ensure consistent logging.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Opening_Message</td><td>Logs a standard opening debug message for a procedure, ensuring consistent logging behavior tied to a specific LogDate.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Perform_MenuItem_Validation</td><td>Puts a wrapper around Validate_MenuItem and raises an error if the validation fails. Can validate StagingMenuItem or Production Outputs ErrorLog entries if debug enabled.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Perform_Migration</td><td>Runs the legacy content migration and publication process.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Perform_Table_Check</td><td>Validates required system, content, lookup, staging, and menu tables. Optionally creates missing tables based on @IsCreateMissing. Throws an exception listing missing tables when creation is disabled.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_BoardMembers</td><td>Inserts a list of current Board Members</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_ContentDocument</td><td>Master procedure to populate all content types. Currently populates articles via Populate_Staging. Validates that the Content table is empty before proceeding.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_ContentType</td><td>Populates the ContentType table with the standard content type definitions used throughout the system. Clears existing rows and inserts deterministic values.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_FormatType</td><td>Populates the FormatType table with the standard format type definitions used throughout the system. Clears existing rows and inserts deterministic values.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_Lookup_Tables</td><td>Populates all lookup tables in correct dependency order. Ensures lookup tables exist, clears MenuItem, and reloads all lookup categories with deterministic values.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_MasterMenu</td><td>Loads the MasterMenu table from the MASTER_MENU CSV file with the location defined in SystemSettings. Performs a direct data dump matching the CSV column order exactly. Uses a staging table to load the data first, then copies to the MasterMenu table to resequence the MenuID. 1) Establish the parent/child relationship from the heirarchy in the spreadsheet by setting ParentMenuID for each child (type = &#39;C&#39;) 2) Set RouteTarget when RouteType = &#39;V&#39; based on the VisitorType table</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_MenuItems</td><td>Rebuilds menu data from the configured source, validates and stages the menu, publishes MenuItem records, then refreshes portal tiles.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_MimeType</td><td>Populates the MimeType table with the standard MIME type definitions used throughout the system. Clears existing rows and inserts deterministic values.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_Numbers_Table</td><td>Populates the Numbers table with values from 1 to 1000 using a recursive CTE.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_PortalMenu</td><td>Builds portal tile records for menu items assigned to a single visitor type.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_Registry</td><td>Populates repeatable local demonstration registrations. The patient registry is exposed as a view over Registration records with VisitorType = &#39;P&#39;. Seed records cover the available visitor types and demonstrate membership, volunteer, and newsletter preferences. Each registration receives a corresponding bogus Contact record. Fundraising is left disabled for all seed records.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_RouteType</td><td>Clears and repopulates the RouteType table with the supported routing types. Validates table existence, deletes dependent MenuItem rows, and inserts the canonical routing definitions.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_Staging</td><td>Placeholder procedure for staging population. Currently implements standard logging, error handling, and closing patterns without performing any data changes.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_SystemSettings</td><td>Populates the SystemSettings table with recommended baseline settings using Set_SystemSetting. Demonstrates valid examples for each supported SettingType and SettingGroup.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_SystemTables</td><td>Populates the SystemTables lookup with all system, lookup, content, staging, and menu tables in the correct sort order.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_TestHarness</td><td>Loads menu items into the test harness for validation.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_VisitorType</td><td>Populates the VisitorType table with the standard visitor type codes used throughout the system. Clears existing rows and inserts deterministic values.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Populate_WorkflowStatus</td><td>Populates the WorkflowStatus table with the standard workflow status codes used throughout the system. Clears existing rows and inserts deterministic values.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Print_Messages</td><td>Displays debug messages for a specific LogDate and optionally logs an additional message. Intended to be used inside the ClosingPattern to show debug output when @IsDebug = 1.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Publish_Migration</td><td>Transfers mapped legacy documents and elements into the content tables.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Publish_Staging</td><td>Publishes StagingMenuItem into production MenuItem.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Set_SystemSetting</td><td>Inserts or updates a system setting value in the SystemSettings table. Performs full validation and normalization for all supported SettingTypes.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Show_Foreign_Keys</td><td>Returns all foreign keys in the database, or only those referencing a specific parent table when @TableName is provided.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Show_Schema</td><td>Displays unified schema information for one or more tables. Supports filtering by table list or table type. Validates table existence, resolves table lists, and outputs columns, indexes, and constraints.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Show_Tables</td><td>Returns a filtered list of tables from TableList based on either a comma-separated list of table names or a table type such as Lookup, System, Content, Staging, or Menu.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Success_Message</td><td>Writes a standardized success message for procedures and optionally logs additional closing messages or parameters.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Validate_Content</td><td>Validates content documents and elements to ensure proper MenuItem relationships, ContentType, WorkflowStatus, RouteType, JSON metadata, and element format/mime types. Writes validation errors to ErrorLog and sets @IsValid accordingly.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Validate_Database</td><td>Runs all validation routines (MenuItem, Content, Staging) and aggregates their results into a single @IsValid flag. Writes validation errors to ErrorLog and supports debug output when enabled.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Validate_MenuItem</td><td>Validates Staging or Production MenuItem configuration and routing rules. Checks RouteType, RouteTarget, VisitorMask, folder alignment, querystring structure, title normalization, parent relationships, and duplicate SortOrder and Title within the same parent.</td></tr>
    <tr><td style="white-space: nowrap; width: 1%;">Validate_Staging</td><td>Validates staging content to ensure all StagingElements reference an existing StagingDocument. Writes validation errors to ErrorLog and sets @IsValid accordingly.</td></tr>
  </tbody>
</table>



