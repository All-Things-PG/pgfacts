---
layout: page
title: New Technology Platform
nav_label: Phase 2
description: Technology choices for the Phase 2 implementation.
permalink: /phase-2/technology-platform/
---

# New Technology Platform

<a href="/welcome/glossary/" target="_blank" rel="noopener">Phase 2</a> will be built for the Azure platform, which is the Microsoft version of AWS.  I've used both, and can honestly say that Azure is equal in capability, but as is often the case, much easier to use, with tons of documentation and support. There is nothing wrong with AWS, we just happen to be given a $2000 **annual** grant to use Azure, eliminating all costs. Over the lifespan say of 10 years, that's a whopping $20,000 for free because we are a nonprofit organization.

### What is Azure?

ChatGPT describes it as:

<div class="azure-summary">
  <p class="azure-summary-title"><strong>Azure at a glance</strong></p>
  <p>Microsoft Azure is a broad cloud computing platform for building, hosting, and operating software and digital services. Instead of buying and maintaining all the hardware and infrastructure themselves, organizations can use Microsoft’s worldwide network of data centers and pay for the services and capacity they need.</p>

  <p><strong>Azure includes several major categories of services:</strong></p>
  <ul>
    <li><strong>Compute:</strong> Run websites, applications, background jobs, virtual machines, and containers.</li>
    <li><strong>Data and storage:</strong> Store files, images, backups, and application data. Database services support structured records, relationships, transactions, and queries.</li>
    <li><strong>Networking:</strong> Connect applications and services, route traffic, and manage private or public access.</li>
    <li><strong>Identity and security:</strong> Manage user sign-in, permissions, encryption, secrets, monitoring, and threat protection.</li>
    <li><strong>Application development:</strong> Build APIs and web applications, connect services, and automate deployment.</li>
    <li><strong>Analytics and AI:</strong> Process large datasets, create reports, and use machine-learning or language-processing services.</li>
    <li><strong>Management and monitoring:</strong> Track performance, availability, costs, and operational health.</li>
  </ul>

  <p>Azure services can be combined in different ways. A simple website might use managed hosting and file storage. A more interactive application could add an API (SOA, WebService) and of course, a database . Larger systems can use separate services for search, messaging, identity, analytics, and other needs. Organizations choose Azure for different reasons, including integration with Microsoft products, access to managed services, global availability, and the ability to scale infrastructure without operating their own data centers.</p>

  <p><strong>Azure covers the operational side of software too—not just hosting and databases.</strong></p>
  <p>It can support the rest of the delivery lifecycle as well:</p>
  <ul>
    <li><strong>Builds and deployment:</strong> Azure Pipelines can automate compiling, checking, packaging, and deploying software when code changes. Teams can deploy to test environments first, then release to production with approvals or staged rollouts. Azure also supports GitHub Actions and other CI/CD tools.</li>
    <li><strong>Source control:</strong> Azure Repos provides Git repositories and pull-request workflows, or teams can use GitHub with Azure hosting.</li>
    <li><strong>Backups and recovery:</strong> Azure services offer backup options for virtual machines, databases, files, and other resources. Backup policies can set schedules and retention periods. Recovery features help restore data or services after accidental deletion, corruption, or infrastructure failure.</li>
    <li><strong>Deployment history and rollback:</strong> Teams can keep versioned build artifacts and deployment records, then redeploy a previous version if a release causes problems. Database changes need their own migration and rollback planning.</li>
    <li><strong>Infrastructure as code:</strong> Tools such as Bicep and Terraform can define cloud resources in files, making environments reproducible and changes reviewable.</li>
    <li><strong>Monitoring and alerts:</strong> Azure Monitor and related services collect logs and metrics, detect issues, and notify teams.</li>
  </ul>
  <p>These pieces work together in a typical workflow: code is committed, an automated pipeline builds and checks it, the release is deployed to a test environment, and then it is promoted to production. Backups and monitoring provide separate safeguards for data and service recovery. A deployment rollback restores an earlier software version; it does not necessarily restore data, so backups and recovery procedures should be planned and tested independently.</p>
</div>

Azure virtually eliminates all maintenance and scaling.  Scaling is automatic, which means that if the website grows so much that you need more powerful systems, Azure will provide that.  It also has a framework for builds and deployments, using GitHub.

### What is GitHub?

<div class="platform-summary">
  <p class="platform-summary-title"><strong>GitHub at a glance</strong></p>
  <p>GitHub is extremely popular among software developers and organizations. It is a web-based platform for managing software projects. In its 2025 Octoverse report, GitHub said it had over 180 million developers and hosted 630 million projects. It reported that about 230 new repositories were created per minute that year. GitHub records changes to files and keeps their history in a secure, versioned repository. It is widely used for software, documentation, configuration, and other project files.</p>

  <p>A project is kept in a repository. The repository contains the files and their history, so you can see what changed, when it changed, and who changed it. If an update causes a problem, the history can help you inspect or restore an earlier version.</p>

  <p><strong>GitHub also includes tools for managing the work around the files:</strong></p>
  <ul>
    <li><strong>Issues</strong> track bugs, questions, and requested improvements.</li>
    <li><strong>Projects</strong> organize and track work.</li>
    <li><strong>Actions</strong> can automatically build, test, or deploy a project when changes are made.</li>
    <li><strong>Releases</strong> package specific versions of a project.</li>
    <li><strong>Permissions</strong> control who can view or change a repository.</li>
  </ul>

  <p>For example, a website project might keep its pages, images, and configuration in a GitHub repository. A developer changes a page on a branch, opens a pull request for review, and merges it when it is ready. An automated workflow can then publish the updated site. GitHub stores and coordinates the project and its change history. It does not automatically provide the website’s database or hosting; those are separate services that can be connected to the repository.</p>
</div>

GitHub is not free.  We were approved for a nonprofit grant which gives us an upgraded version, but GitHub is heavily integrated with AI (Copilot or ChatGPT), and you have to buy a subscription to cover usage.  I'm paying for that now in my Personal Repository, but I've also created a separate repository and I plan on moving GitHub to the business repo.  Charges can then be associated with the Azure billing, so it will be free as well.  Right now my subscription is $40 per month and gives me $70 in usuage credits.

## Developer Platform

Database are created using the software in the Microsoft Developer Platform, which consists of AI Models, a DB application called SSMS (SQL Server Management System), and various source code editors like VS 2022, VS 2026 and VS Code (Visual Studio). They used to be extremely expensive, and developers had to buy annual subscriptions to cover the costs, but that has all changed with the movement to open source. Microsoft now supplies their devloper tools for free.

The database itself is accessed directly by the website to retrieve and display data using the  **Entity Frameworks (EF)**, which makes access bullet-proof and secure.  EF exists within the website source code editors, which supplies built-in capabilites to retrieve content from the database.  When you click on a Menu Item in the website, it reads the associated content and displays in a web page.  You can also do any manner of search on data stored in a database using **Full Text Indexing**. All of this exists within the Microsoft Platform called .NET that came out around the year 2000.  .NET is a library of routines to build all sorts of applications, including Windows and Websites.  It uses a standard web server called **IIS (Internet Information Server)**,  which has a typical wwwroot directory and serves up standard html pages.  There have been many webapp styles over the years including Winforms, WebForms ASP.NET,  MVC, and now ASP.NET Core.  With Webforms you could design a page graphyically, using WYSIWYG editors (what you see is what you get), by drag and drop of components on the screen.  You could slide things around until you love the way it looks and that page would render exactly as you would expect.  .NET developers loved it, 'real' web developers thought it was cheating (although highly productive), so it fell out of favor claiming you were not a real HTML developer. Then something called **Design Patterns** became popular, and the UML (unified modeling language) encapculated all of industry knowledge and standards on how to build software. There are maybe 30-40 design patterns, very complex and based on OOP (object oriented programming).  That led to better development practices, and reduced the need for designer type development and replaced it with MVC (Model View  Controller pattern), which is a separation of responsibility.  All of this, combined with the industry shift to standardized programming and open source, led to ASP.NET Core with Razor or Blazer pages.  Razoer pages are pure HTML programming with business logic that executes on the server side, Blazer executes in the Browser using Java.  Which is better? Neither. It depends on the application.  Blazer is highly interactive and focuses on fancy interfaces, Razer focuses on content retrieval and building HTML pages on the server  where data originates. Clearly ASP.NET Core with Razor pages fits All Things PG perfectly, and in many ways, is far less complicated and less prone to issues (always good).

I will be developing using VS 2026, VS 2022, APS.NET Core (Razor Pages), SQL Server database, and porting to Azure SQL (same thing), with the website hosted in IIS on the Azure platform (very much like AWS). All development tools are free, and the web hosting is free. This technology has been around for 30 years or so, and .NET since early 2000.  I started developing in .NET on the very first release.

### Use of AI for Development

One key factor that did NOT play into the AI analysis, and that is the use of AI. All modern development tools use AI extensively as a companion to the developer. The developer needs to know both technologies, and I do.  AI is a huge time saver, but does not replace the developer.  When I get an idea, and I talk through the strategy with AI, we have back and forth dicussions to settle on the final design, even create database  scripts and C# code, but since AI isn't perfect, the developer uses what's generated as potential, not real.  The developer always controls and monitor development, but the AI does a lot of the time consuming stuff. I think the real advantage is in strategy sessions.

That same AI works in both website and database development, and in learning Azure. Copilot is everywhere within our nonprofit Tenant.  Copilot is built on ChatGPT modles plus numberours Microsoft extensions and integration.  AI is a critical timesaver and in many cases produces bug-free code.  It is not something that exists, and never will exist, in Phase 1.

AI increases speed of development, accuracy, security, architecture and everything about the database and website projects, to work in unison with  the developer and avoid failures.  If there's a bug you can often get AI to find it, and fix it.  Its truely valuable and an amazing time saver.  It won't replace a Software Engineer now, but that time is coming.
