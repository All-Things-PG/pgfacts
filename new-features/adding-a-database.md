---
layout: page
title: Adding a Database
nav_label: New Features in Phase 2
breadcrumb: New Features in Phase 2 > Adding a Database
description: Why a database is needed to support the planned feature set.
permalink: /new-features/adding-a-database/
work_in_progress: false
---

# Adding a Database

In truth, if <a href="/welcome/glossary/" target="_blank" rel="noopener">Phase 1</a> had a database, we would not be adding Phase 2.  All we really want to do is add **Leo Enhancements** and a few of our own.  Of course, once you see what is possible with a Database, and now a Wish-List, you realize why we need to add a Database if we want to grow as an organization, and not just a website.

Phase 1 uses a custom cms editing tool written by Krobe.  We can use it to add basic things to enhance our static website (one means no database or server-side coe), but you can only allow items that the tool is designed to support. This is not a knock against Phase 1, or the tool, that is normal for a nonprofit and a quick release.  Many nonprofit organizations start out, and remain as, static websites because there is rarely any change. It costs money to develop 'an application'.  I do not envision All Things PG to be without change.  Look what we have accomplished in only 1 year?  Look at the attention we have received from outside organizations?  This has brought us new opportunites for exansion, and we have broadened out to many new areas that we can add to our website.  New areas and new capabilities.

We need to communicate in these new areas to our PG community, let them know what we've been doing, and continue to add new areas and features. This is growth, and will continue on into the future.  Additionally, PG itself is always changing, with new understanding, diagnostics and treatment.  We can always find new information to tuck away into the KB.

We will always be adding new content and new capabilities, and the only way to do that is with a Database.

There are also major short-comings of the current website, such as no search ability, the difficulty of adding anything new, and the lack of entries and functionality in the Clinic Finder. 

### How do you add a Database?

A database is not a difficult concept, but it is not a static website either.  It is a major programming change, requiring new architecture, software, hosting and cost.  Nothing good is free, and we have to pay for a Database.  That said, we have a $2000 Azure grant from Microsoft, and Azure happens to be a world-wide major hosting platform, like AWS.

So hosting a website with a databas is standard with AZure, and Azure makes that part much easier.  But it still involve technical skill and hosting and is not built by an edit tool or site builder.  Modern site builders, especially in the MS world can create websites that look just as good as a programmer, and some can even create them in Azure with a database. But a site builder will always remain less flexbile to get exactly what you want vs just creating HTML pages within a website folder.

A database exists outside a web application.  It exist and survives on it own.  You create schema, and then add data, and you have a database.  The website sits on top the database, and draws data from the database, making the webisite data-driven.  Most busines logic goes in the database, close to the data where it belongs. The HTML page do not contain the business rules, even if it looks that way.  When you click a button to add a user, the HTML page is not adding the user.  I collects data on the screen and sends it to the database, and the database adds the user.  Same in reverse.  When you click a menu item, the menu item  makes a reques to the database for content, and the database supplies it, and the HTML page displays it.

That make the website a 'thin-client' and 'data-driven'.

In our environement, there is a database management consolel called SSMS. Its very good. You run SSMS and click Add Database, it asks you for the name AllThingsPG, in 1 second you have a database. Done. Go home.  Not entirely. The next step is to define schema. This is where the experience comes in. This is designing a database according to relational database standards and theory.  These are university level type courses and takes years of practical experiene.  I've been doing database for about 30.

After you correctly deine schema then you populate the database with system tables, lookup tables and support tables, error logs etc and you ready to add real content, real menu item. Once the database is ready to go, then so is the website.

### How does the website access data?

Modern tools like Visual Studio do that automatically. It is expected that you have a database, and it asks you what is the . name of your database and where is it located.  It then make connections for you, called the Entity Framework (EF).  If you change your code, it changes the database. If you change the database it will change you code, in an effort to always be in sync.  It provides the routines and data objects you need to push and pull data as needed. This leaves you free to write HTML code and server side business logic that makes pages look pretty and goes and gets the data for display.

It sounds like a lot but its been like this from the beginning and is second nature to any programmer, but you do need a programmer. Just like Rusty is a programmer and charges an hourly rate.  Even a site builder tool requires technical skills and you have to pay for the skills they've spent a career developing.

### What do you do once you have a website and a database.

Once you have everything working locally, now it is time to deploy your creation to Azure, and once in Azure, then everyone can see it on the internet.  Not before then.  You never want to deply from your local machine to the website, because it must be tested first.  You always deply to a staging environment first, and once everything gooks ok, you then deploy to production and you now have an active website using a database.
