---
layout: page
title: Proof of Concept
nav_label: Welcome
breadcrumb: Welcome > Proof of Conceptv
description: Proof of Concept
permalink: /welcome/proof-of-concept/
work_in_progress: false
---
# Proof of Concept

### Overview

The Phase 2 Proof of Concept (POC) is a fully functional website and working prototype, that demonstrates the feasibility, architecture, and core capabilities of the proposed DCMS database platform. The whole point of the POC is to go beyond documentation, and prove that the underlying design actually works.  It does.  It also offers a visual opportunity for stakeholders to see something 'real' on a few number of pages.  The POC  tests mechanical behaviors such as database access and routing, which validates the architecutre of the website itself.

The purpose of THIS POC is simple: demonstrate that a modern, data-driven platform can successfully organize, manage, and present Pyoderma Gangrenosum information in new ways that are meaningful to different user types: patients, caregivers, healthcare providers, industry partners and guests through the use of Portals, Dynamic Content and Dynamic Menus (DCMS).

### Why the Proof of Concept Was Created

During the early planning stages of the project, it became apparent that a traditional static website could not adequately support the long-term vision for All Things PG, or even add new capabilities. The organization requires a platform that allows growth, because the organization is growing.

The Proof of Concept was created to answer several critical key questions:

> - Can we build a knowledge base to store all kinds of content for Pyoderma Gangrenosum
> - Can content be managed dynamically through a database rather than static web pages?
> - Can menus be managed dynamically through a database rather than static web pages?
> - Can information be organized around user needs rather than fixed for all users?
> - Can the platform scale as content volume and traffic increases?
> - Can we migrate content and functionality in Phase 1 to Phase 2?
{: .simple-blockquote}

The answer is **yes** to all these, thus proving the technology works!

### Phase 1 Migration into Phase 2

Although the new platform will use a different technology platform, architecture and database, the content and capabilities established in Phase 1 still remains valuable. There is no need to throw away what we have now, rather we perform a migratoin to copy the conten from Phase 1 into Phase 2.

The POC includes a limited migration test to demonstrate how existing website content can be transferred into the new data model using AI.  Current POC testing uses AI-assisted discovery to 'scrape' content on the existing site and map it into migration tables in the database, and then merge the migration content into regular content tables. 

Some of this may be a manual effort of discovery and review to get it right.  The POC is a limited effort towards migration, mostly to show the concept.  The real migration would be a thorough analysis and more advanced discovery and confirmaton of curated/vetted content.

### What the Proof of Concept Shows

The current prototype includes a functional database, dynamic menu generation, content management capabilities, dynamic navigation and an operational web interface, some with screens that are similar to the original.

Content is succdssfully stored within a database and uses the DCMS routing to dynamically generate menu items based on the Visitor Type. Menus and navigattional structures are generated from data rather vs hard-coded into individual web pages. This approach enables far greater flexibility, maintainability, and scalability compared to traditional website designs. It also offers the ability to present different menu items and content  to different types of users.

The Proof of Concept also serves as the primary demonstration platform, and is an essential part of any proposal.  Anyone interest can receive a demo of the prototype through a Teams meeting.  The POC is not available on the internet.

<style>
.poc-screenshot-frame {
  width: min(100%, 923px);
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  gap: 12px;
  margin: 1rem 0 1.5rem;
  padding: 12px;
  overflow: hidden;
  border: 1px solid #cbd5e1;
  border-radius: 6px;
  background: #f8fafc;
}

.poc-screenshot-frame h3,
.poc-screenshot-frame h4 {
  flex: none;
  margin: 0;
  text-align: center;
  font-size: 1rem;
  line-height: 1.3;
}

.poc-screenshot-frame img {
  max-width: 100%;
  max-height: calc(100% - 3rem);
  width: auto;
  height: auto;
  object-fit: contain;
}

.poc-screenshot-frame--home {
  aspect-ratio: 923 / 560;
}

.poc-screenshot-frame--patient-menu {
  aspect-ratio: 923 / 420;
}

.poc-screenshot-frame--provider-menu {
  aspect-ratio: 923 / 380;
}

@media (max-width: 600px) {
  .poc-screenshot-frame {
    width: 100%;
    aspect-ratio: auto;
  }

  .poc-screenshot-frame img {
    max-height: none;
    max-width: 100%;
  }
}
</style>

 An intentional attempt was made to make the home page look similar to the current web site.  Some other pages have some basic HTML and intentionally look pretty.  This page has not be carefully created with every small detail., with some pages looking pretty., like the home page to prove we can do something similar to what we have now.  This page has not be carefully created with every small detail.

<p><a class="oldsite-donate-button" href="mailto:suggestions@allthingspg.org?cc=dave@allthingspg.org&amp;subject=Schedule%20a%20demo%20for%20PG%20Facts%20Phase%202&amp;body=Please%20contact%20me%20to%20schedule%20a%20demo%20of%20the%20Phase%202%20proof%20of%20concept.%0D%0A%0D%0A">Schedule a Demo</a></p>

<div class="poc-screenshot-frame poc-screenshot-frame--home">
  <h3>Home Page</h3>
  <img src="/assets/images/poc-home-visitor-experiences.png" alt="The POC home page presents five visitor experiences: Patient, Caregiver, Provider, Pharmaceutical, and Guest.">
</div>

### User-Specific Menus and Portals

The prototype demonstrates a design principle: visitors should be able to find information based on their needs. A patient, caregiver, and provider may be interested in some of the same PG information, while also needing different resources and navigation. The examples below show how the prototype presents patient and provider menus and portal pages.

<div class="poc-screenshot-frame poc-screenshot-frame--patient-menu">
  <h4>Patient Menu</h4>
  <img src="/assets/images/poc-patient-menu.png" alt="The patient menu presents navigation options tailored to patients.">
</div>

<div class="poc-screenshot-frame poc-screenshot-frame--provider-menu">
  <h4>Provider Menu</h4>
  <img src="/assets/images/poc-provider-menu.png" alt="The provider menu presents navigation options tailored to healthcare providers.">
</div>

### Summary

These examples illustrate that you can have a different menus for a Patient vs a Doctor, and how different menus can lead to zdifferent content relevant to each audience. The content and navigation shown here is not a complete representation of production resource and capabilities.  It's only a POC.


