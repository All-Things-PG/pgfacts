---
layout: page
title: Welcome to Phase 2
nav_label: Home
description: Welcome to Phase 2 Documentation Site
---
# Phase 2 is coming together.

The design and documentation of Phase 2 of www.allthingspg.org is well under way.  As a software engineering project, the tasks are to:
<table class="topic-table">
	<thead>
		<tr>
			<th>Item</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>discuss with everyone, get people involved</td>
		</tr>
		<tr>
			<td>2</td>
			<td>work together to decide what goes in Phase 2</td>
		</tr>
		<tr>
			<td>3</td>
			<td>document planned changes</td>
		</tr>
		<tr>
			<td>4</td>
			<td>make a demostration and proposal</td>
		</tr>
		<tr>
			<td>5</td>
			<td>seek approval</td>
		</tr>
		<tr>
			<td>6</td>
			<td>develop the website.</td>
		</tr>
		<tr>
			<td>7</td>
			<td>get folks involved in testing, feedback</td>
		</tr>
		<tr>
			<td>8</td>
			<td>release (6 months or less)</td>
		</tr>
	</tbody>
</table>

This plan allows stakeholders an opportunity to provide input and review of all changes before accepting any proposal, and then have something to gauge later on if the new features are performing as expected.  It also allows the developer to fully understand the work to be done, by writing the documentaiton first and having agreement with stakeholders.   Planning is essential in building a website, except perhaps for the simplist of static pages.  No design document is a contract, and not all code will adhere to the design.  Documentation is a tool, not a contract.  It will never be perfect.  Documentation is more like guidelines, to avoid issues down the road, like a dispute of what was SUPPOSED to changed and not changed.  Documentation often becomes out of date quickly as time goes on.  

As such, I prefer a Documentation Site (pgfacts.org) because it is much easier to maintain vs a document folder or even written documentation stored on paper or emails.  With the website there is only one source of truth, and distribution is simply visiting pgfacts.org.  Why is it called pgfacts?  All Things PG purchased a number of domains early on, anythihng that sounded interesting.  This one was of them not being used and seemed closest as a domain name for the purpose intended.  It didn't cost anything extra to use it and we were paying for it anyway.

## What will be the key features of Phase?

The key vision and objectives for Phase 2 will be:

<table class="topic-table">
	<thead>
		<tr>
			<th>Item</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>clarify the mission of All Things PG and the goals of the website (always the central goal)</td>
		</tr>
		<tr>
			<td>2</td>
			<td>identify the audience, who will be using the website and why (also referred to as Use Cases)</td>
		</tr>
		<tr>
			<td>3</td>
			<td>identify Phase 2 features that will support the mission and purpose of the ATPG website</td>
		</tr>
		<tr>
			<td>4</td>
			<td>create a well designed and powerful database that supports all the new features and beyond</td>
		</tr>
		<tr>
			<td>5</td>
			<td>enhance the user experience and make it easier to find what you're looking for (a more guided experience)</td>
		</tr>
		<tr>
			<td>6</td>
			<td>collect data to support development of future releases (usuage data, logs, error logs, profile information etc)</td>
		</tr>
		<tr>
			<td>7</td>
			<td>store data to support lists of patients, caregivers, providers, pharma, trials, research etc for the purpose of fundraising, newsletters, sending emails and more</td>
		</tr>
		<tr>
			<td>8</td>
			<td>store data to have a data-drive website with menus and content</td>
		</tr>
		<tr>
			<td>9</td>
			<td>provide better help and support to users of the website (maybe even an AI agent)</td>
		</tr>
	</tbody>
</table>

## What is the implementation plan?

<table class="topic-table">
	<thead>
		<tr>
			<th>Item</th>
			<th>Description</th>
			<th>Status</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>Design and create a FULL database that supports mission objectives</td>
			<td>Mostly done</td>
		</tr>
		<tr>
			<td>2</td>
			<td>Plan some of the new features as opportunities</td>
			<td>Mostly done, not all need to be listed</td>
		</tr>
		<tr>
			<td>3</td>
			<td>Apply for and build a nonprofit technology platform for Office and Development</td>
			<td>Approved - MS Nonprofit Tenant, M365 Business Basic (300 users), $2000 Azure grant per year, Copilot Premium</td>
		</tr>
		<tr>
			<td>4</td>
			<td>Figure out the technology, given the current environment and circumstances</td>
			<td>MS SQL, ASP.NET Core, GitHub Pages, Azure, AI</td>
		</tr>
		<tr>
			<td>5</td>
			<td>Estimate costs for developing and hosting Phase 2</td>
			<td>By the numbers</td>
		</tr>
		<tr>
			<td>6</td>
			<td>Document planned changes in writing, host on pgfacts.org</td>
			<td>On-going</td>
		</tr>
		<tr>
			<td>7</td>
			<td>Build a proof of concept (POC) that proves the new design concepts</td>
			<td>Virtually done</td>
		</tr>
		<tr>
			<td>8</td>
			<td>Create a project proposal with costs and timeline</td>
			<td>Not started</td>
		</tr>
		<tr>
			<td>9</td>
			<td>Develop, test, deploy, approve</td>
			<td>Pending</td>
		</tr>
	</tbody>
</table>


## How best to review the documentation?

1. Read and ask questions by submitting comments (Contact Us).  There is a lot to learn and understand about Phase 2 but can be worth the effort if you are a stakeholder.  Be involved in the discovery process.  If there is a concern, or if there are new feature you might be interested in, now is the time to make that known.  Once the system is designed or even developed it becomes difficult to stop mid-stream to add anything significant without a redesign and reintegration.  This happens all the time in the real world because things do change, but also because of the initial lack of attention to detail.

2. Start by learning about DCMS as a design.  DCMS was invented for curating dynamic content and associating with dynamic menu items.  Figure out what DCMS is, and why we need it.

3. Learn about the enhanced User Experience, which I refer to as a Portal.  Each user has a visitor type, either Patient, Caregiver, Provider, Pharmaceutical or Guest.  Each visitor type has a unique portal which provides a customized user experience.  You do not need to 'log in' or register to use a portal, you can simply view the website as a generic Guest.  Or you can easily indicate what type of users you are, such as a Provider or Caregiver.  Each portal is a unqiue experience, even if all portals look basicaly the same.  The key difference is in the list of menu items presented, which controls which content is presented.  The effort of a portal then is to present different content to a doctor that you might to a patient. A doctor may want an indepth discussion on diagnosis, and caregiver may not.

4. Identify the new features that interest you.  Ask questions, submit feedback early and often.

5. Identify mistakes. Very much appreciated.

## Use of Titles

At the top of every page you may see titles, or bubbles.  These may be the most interesting documents within a particular topic.  They act like buttons so just click on them.  

## What are some of the key documents to get me started?

- [Executive Summary]({{ '/dcms/DCMS_Executive_Summary.html' | relative_url }})
- [What is a DCMS Database]({{ '/dcms/DCMS_Portal_Experience.html' | relative_url }})
- [Creating a Portal Experience]({{ '/dcms/DCMS_Portal_Experience.html' | relative_url }})
- [Curating and Publishing Content]({{ '/dcms/DCMS_Curating_Content.html' | relative_url }})
