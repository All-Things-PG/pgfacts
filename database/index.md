---
layout: home
title: Database
nav_label: Database
breadcrumb: Database
description: Relational data model supporting DCMS and planned Phase 2 features.
permalink: /database/
topic_key: database
---
# Database

### Overview

<a href="/welcome/glossary/" target="_blank" rel="noopener">Phase 2</a> now has a SQL Server database that was originally created using SSMS (SQL Server Management Studio). This is a powerful industry-standard **relational database** used by companies around the world, and we have access to that power for free.

SQL (Structured Query Language) is a database language that has been a published standard since 1986 and has evolved into a powerful industry standard. I've been using SQL for 30 years to create database structures and program business logic for every company I've worked for. For most applications, the entire set of data and logic exists in a secure SQL database that is easily accessed, backed up daily, and, for large companies, managed by a DBA (Database Administrator).

Once you have a database, you can build a website that sits on top of it. The primary responsibility of the website is to create HTML pages for display. This is called a thin client. You create enough pages in the website to offer users all the interfaces and functions they need. Menu items, buttons, drop-down lists, and other controls make calls to the database to retrieve information for display or to perform an action. The website and the database work as a single unit, with most business logic performed in the database.

### What is a Relational Database?

A single SQL Server can have many databases, or just one. In our case, being a small organization, there is only a need for one database.

The name of our database within SQL Server is **AllThingsPG**. The AllThingsPG database contains a **schema**, which is metadata describing the list of tables, views, stored procedures, and more. Tables store data, views offer a way to see the data, and stored procedures hold business logic. Our database contains many of each type. The schema is created using **scripts**, and within each script, SQL is used as the programming language. For a professional SQL specialist, this programming language is easy to use, consistent because of the many years it has been around, and second nature. It is a predictable and reliable language.

SQL and the relational database AllThingsPG are the foundation for DCMS. The database stores lookup tables such as visitor types, format types, content types, and user types. It also stores our menuing system, content system, staging system, and user registration. All the data is broken down into these subsystems within **tables**. A table is similar to an Excel spreadsheet with rows and columns. This tabular data is **relational** in that one table can be joined to another table. The resulting view can combine data from both tables to make it look like a single table. Stored procedures contain programming logic that reads and writes data and performs application functions. SQL also includes scripts to perform backups and even send email using agents within the database. SQL is the home of the organization.
