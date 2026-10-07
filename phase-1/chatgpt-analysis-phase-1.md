---
layout: page
title: ChatGPT Analysis
nav_label: Phase 1
description: What ChatGPT was used for in the planning process.
permalink: /phase-1/chatgpt-analysis/
---
# ChatGPT Analysis

**Website audited:** https://www.allthingspg.org/  <br>
**Audit date:** October 3, 2026  <br>
**Primary focus:** usability, information architecture, accessibility, task completion, maintainability, scalability, and future growth  <br>
**Secondary focus:** trust, SEO/discoverability, performance risk, and content governance where those affect usability  <br>
**Overall conclusion:** **Good foundation, but not yet a strong modern patient-service website.**<br>

### Instructions to create the report

***I need an in-depth analysis of our website www.allthingspg.org The focus should be on usability and scalability, not so much on content itself, although it should be helpful information to the target audience. I'm interested to know - is it a good web site or not, and areas for improvement. it can be as detailed as you like, as long as you long. Examine as many pages as you can, identify faults, compare to modern websites and standards, and make recommendations for improvement. Save the report as a .md file, using #, ### headers.***

## Overview

This audit is intentionally weighted toward how the site works as a product rather than whether every sentence or medical statement is correct. I reviewed the live site and a broad sample of primary pages, utility pages, articles, people pages, event pages, forms, and linked services. The site has a clear mission, clean URLs, a coherent basic navigation structure, and some genuinely valuable tools—especially the clinic finder, survey, support/community resources, and direct access to the board and organization.

The biggest opportunity is to move from a **collection of pages** to a **task-oriented patient information system**. That means organizing around what people are trying to accomplish, making the highest-value actions obvious, using real content types and structured data behind the scenes, and making accessibility/testing part of the design process rather than a final check.

## Executive Assessment

### The answer to “is it a good website?”

**Yes, in the sense that it is credible, useful, understandable, and functional. No, in the sense that it is not yet operating at the level of a modern, scalable patient-support website.**

I would characterize it as:

> **A solid first-generation nonprofit website with good bones that now needs a second-generation usability and information-architecture redesign.**

The site is particularly strong in these areas:

<table class="topic-table">
    <thead>
        <tr>
            <th scope="col">Area</th>
            <th scope="col">Score</th>
            <th scope="col">Assessment</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Purpose and mission clarity</td>
            <td>4.5/5</td>
            <td>Visitors quickly understand that the site is for the PG community.</td>
        </tr>
        <tr>
            <td>Basic navigation</td>
            <td>3.5/5</td>
            <td>Reasonable top-level structure, but it is organization-centric rather than user-journey-centric.</td>
        </tr>
        <tr>
            <td>Core PG education</td>
            <td>3.5/5</td>
            <td>The major topics exist and are easy to understand.</td>
        </tr>
        <tr>
            <td>Clinic-finder concept</td>
            <td>4.0/5</td>
            <td>Excellent strategic idea; the UX and underlying data model need to mature with it.</td>
        </tr>
        <tr>
            <td>Community/support orientation</td>
            <td>3.5/5</td>
            <td>The site communicates support, but support pathways are not prominent enough.</td>
        </tr>
        <tr>
            <td>Homepage task orientation</td>
            <td>2.5/5</td>
            <td>Too much promotional/rotating content relative to the user's likely immediate needs.</td>
        </tr>
        <tr>
            <td>Accessibility</td>
            <td>2.5/5</td>
            <td>Several likely semantic/accessibility issues are visible from the crawl and require a dedicated WCAG 2.2 audit.</td>
        </tr>
        <tr>
            <td>Forms and interaction design</td>
            <td>2.5/5</td>
            <td>Form and third-party-service dependencies need a more deliberate experience.</td>
        </tr>
        <tr>
            <td>Search/discovery</td>
            <td>2.0/5</td>
            <td>No obvious site-wide search or robust content discovery system.</td>
        </tr>
        <tr>
            <td>Content scalability</td>
            <td>2.5/5</td>
            <td>The current model can grow, but future volume will make page-by-page management increasingly difficult.</td>
        </tr>
        <tr>
            <td>Data scalability</td>
            <td>2.5/5</td>
            <td>Clinic/provider data is the biggest candidate for a proper structured data model.</td>
        </tr>
        <tr>
            <td>SEO foundation</td>
            <td>3.0/5</td>
            <td>Clean URLs and useful page topics are good; semantic structure and structured data should be strengthened.</td>
        </tr>
        <tr>
            <td>Performance risk</td>
            <td>3.0/5</td>
            <td>No lab score was available during this audit, but several external integrations and media patterns create avoidable risk.</td>
        </tr>
        <tr>
            <td>Governance/maintainability</td>
            <td>2.5/5</td>
            <td>The site needs reusable content models, QA controls, ownership, and lifecycle rules.</td>
        </tr>
    </tbody>
</table>

**Overall:** approximately **62/100 today**.

That is not a failing grade. It means the site is valuable and serviceable, but there is substantial room to make it easier to use, easier to maintain, and much more capable of supporting growth.

---

### What I Reviewed

### Live site pages and functions

The audit covered the homepage and the primary navigation destinations, including:

- Home
- What is PG?
- PG Symptoms
- PG Causes
- Diagnosis of PG
- Treatment of PG
- Associated Health Issues
- Take the PG Survey
- Talking About PG
- How to Identify PG
- Rare Disease Affiliates
- News & Events
- Our People
- Individual board/member pages
- Clinic Finder
- Mission Statement
- Contact
- Subscribe
- Donate
- Industry Partners
- PFAC
- Data and Privacy
- Several individual news/event pages
- External survey, newsletter, donation, video, and event destinations

The live site exposes a recurring global navigation containing About PG, All Things PG, News & Events, About Us, language choices, Contact Us, and Donate. The homepage also promotes the Clinic Finder, survey, newsletter, industry partners, and community-support content.

### Important limitations

This was a live-site usability and architecture review rather than a full penetration test or source-code audit.

I could inspect rendered page structure, navigation, links, headings, forms as exposed to the crawler, and a substantial set of pages. I could not reliably run a browser-based Lighthouse/PageSpeed lab test in this environment, so I am **not** assigning numerical Core Web Vitals scores.

Likewise, color contrast, exact touch-target dimensions, keyboard focus appearance, mobile breakpoints, screen-reader behavior, form error handling, and JavaScript-only interaction behavior need a hands-on accessibility/device test before being called confirmed defects.

Those items are nevertheless included as explicit test requirements where the current site gives reason to investigate them.

---

### The Current Site's Biggest Strength

### It has the right ingredients

The site already contains most of the building blocks a strong PG patient resource needs:

- disease education
- diagnosis information
- treatment information
- associated conditions
- patient/caregiver guidance
- community resources
- provider/clinic discovery
- research participation
- survey participation
- events and PFAC activities
- donation/support
- leadership transparency
- external rare-disease connections

That is an excellent starting position.

The problem is less “missing pages” and more **how these pieces are presented, connected, prioritized, and maintained**.

For example, the homepage separately promotes the survey, clinic finder, newsletter, industry partner support, community support, and a video/story. These are all individually reasonable, but a first-time patient is left to decide which path applies to them.

Modern patient organizations increasingly organize the experience around user intent. The Crohn’s & Colitis Foundation, for example, explicitly begins with journey choices such as newly diagnosed, living with a condition, and caregiver roles, and it provides an “I am a…” audience selector. The National Psoriasis Foundation similarly starts with user states such as “I’m not sure if I have psoriasis,” “I’m newly diagnosed,” “My treatment isn’t working,” “I’m supporting someone,” and “I’m a healthcare professional.” Those patterns reduce cognitive load because they mirror the user's mental model rather than the organization's internal structure.

Sources:
- https://www.crohnscolitisfoundation.org/
- https://www.crohnscolitisfoundation.org/patientsandcaregivers/ibdjourney
- https://www.psoriasis.org/
- https://www.psoriasis.org/navigationcenter/

---

### Homepage Assessment

### What works

The homepage immediately communicates the organization's purpose:

> “All Things PG: A Pyoderma Gangrenosum Community connecting patients and caregivers.”

That is strong positioning. It does not make people hunt to understand what the site is about.

The homepage also places three important actions near the top:

- find a clinic
- take the survey
- subscribe

That is strategically good. The site understands that it is not just an information library—it is also a service and community hub.

The clinic finder promotion is especially valuable because it solves a real task rather than just promoting the organization.

Source:
- https://www.allthingspg.org/

### The homepage's main weakness: too many competing “primary” messages

The page appears to use a rotating/slide-based promotional area. The crawl exposes “It's Our Anniversary” and “Take the Survey” as separate headline-level items along with “Welcome to Our Community” and “Connecting the PG Community.”

The crawl also exposes:

- “Previous”
- “Next”

This is characteristic of a carousel/slider experience.

That is not automatically bad, but it is usually a poor place to put critical patient tasks. Rotation makes content disappear, reduces discoverability, creates keyboard/focus requirements, and increases the chance that two different visitors see different “first” messages.

For this site, I would strongly prefer:

**one stable patient-oriented hero section + a small number of fixed task cards**

rather than a rotating promotional hero.

A stronger top of page would be something like:

### Pyoderma Gangrenosum Support & Information  
Trusted information, PG-experienced care, community support, and ways to participate in research.

Then:

**I need information**
- What is PG?
- Symptoms
- Diagnosis
- Treatment

**I need help**
- Find a PG-experienced clinic
- Talk with the community
- Find support resources

**I want to help advance PG care**
- Take the survey
- Participate in research
- Advocacy and events

This is much closer to how a stressed patient or caregiver thinks.

### Homepage recommendation

Make the homepage answer these five questions in the first screen or two:

1. **What is this site?**
2. **Where should I start?**
3. **How do I find PG-experienced care?**
4. **How do I get support?**
5. **How can I participate or help?**

Everything else should be secondary.

---

## Information Architecture

### Current top-level navigation

The current global navigation is approximately:

- About PG
- All Things PG
- News & Events
- About Us
- Contact Us
- Languages
- Donate

Under About PG:
- What is PG?
- PG Symptoms
- PG Causes
- Diagnosis of PG
- Treatment of PG
- Associated Health Issues
- Take the PG Survey

Under All Things PG:
- Talking About PG
- How to Identify PG
- Rare Disease Affiliates

About Us contains Our People, Clinic Finder, and Mission.

The structure is rational from the organization's perspective.

The problem is that **“All Things PG” is both the organization name and a navigation category**. That is likely to create ambiguity.

A patient does not naturally think:

> “I need to go to the All Things PG category.”

They think:

> “I was just diagnosed. What do I do now?”

### Recommended information architecture

I would consider a first-level model like:

- **Learn About PG**
- **Find Care**
- **Living With PG**
- **Support & Community**
- **Research & Advocacy**
- **News & Events**
- **About Us**
- **Donate**

Then expose the utility actions prominently:

- **Find a PG Clinic**
- **Get Support**
- **Take the PG Survey**

This does not mean adding a huge number of menu items. The goal is the opposite: make the top-level choices correspond to major user tasks.

### Proposed structure

```text
Learn About PG
    What Is PG?
    Symptoms
    Causes
    Diagnosis
    Treatment
    Associated Conditions

Find Care
    Clinic Finder
    How to Find a PG-Experienced Provider
    Preparing for a PG Appointment
    Questions to Ask Your Doctor

Living With PG
    Identifying PG
    Talking About PG
    Wound/Care Resources
    Emotional Support
    Caregiver Resources

Support & Community
    Support Groups
    PFAC
    Community Events
    Rare Disease Organizations
    Patient Stories

Research & Advocacy
    PG Survey
    Research Participation
    Clinical Trials
    Advocacy
    Industry Partners

News & Events
    News
    Events
    Newsletters
    Archived Events

About Us
    Mission
    Our People
    Medical/Scientific Leadership
    Partners
    Contact
    Privacy

Donate
```

This structure is much more scalable because new content has obvious homes.

---

## Navigation and Wayfinding

### Strength: global navigation is persistent

The global header appears consistently across the site. That is good.

Visitors can move from an education page to the clinic finder, contact form, or donation area without having to return to the homepage.

### Weakness: the site has no obvious breadcrumb system

The site contains multiple levels of content:

- topic
- article
- article category
- person
- event
- utility
- external tool

Yet the pages do not expose an obvious “You are here” path.

For a site that grows, breadcrumbs become valuable because they provide both orientation and an additional navigation path.

For example:

```text
Home > Learn About PG > Diagnosis
```

or:

```text
Home > Research & Advocacy > PFAC
```

Breadcrumbs are especially useful on long health-information pages where users arrive from Google rather than the homepage.

### Weakness: there is no obvious site-wide search

The crawlable navigation does not expose a site search.

At the current size of the site, this is survivable.

At 2–3x today's content volume, it will become increasingly important.

A search system should eventually cover:

- articles
- events
- people
- clinics/providers
- support resources
- research resources
- external resources

W3C's WCAG 2.2 guidance explicitly recognizes search as one of the ways a user can have multiple ways to locate content.

Source:
- https://www.w3.org/WAI/WCAG22/quickref/?versions=2.0

### Recommendation

Add a prominent global search, but do **not** simply add a generic search box and stop there.

The search should understand:

- PG terms and common variants
- provider/clinic names
- states/cities
- resources
- people
- article titles
- event titles

Eventually, the clinic finder should have its own specialized search rather than depending on the site search.

---

## Page Structure and Semantic HTML

### This is one of the most important technical/usability issues I found

The rendered page structure strongly suggests that interior-page titles are being presented at a low heading level.

For example, the crawl identifies the main title on “What is PG?” as:

> “What is Pyoderma Gangrenosum?”

but exposes it at a `###` level, with subsequent subheads at `####`.

The same pattern appears on “Treatment of PG,” “Find PG Care Near You,” “Talking About PG,” “Data and Privacy,” and others.

On the homepage, several major sections appear as top-level `#` headings.

That indicates the design may be using heading elements for styling rather than enforcing a consistent semantic document hierarchy.

### Why this matters

Headings are not just visual formatting.

They create a navigable outline for:

- screen readers
- browser accessibility tools
- search engines
- people scanning a page
- users who jump between headings

W3C's WCAG 2.2 specifically requires headings and labels to describe topic or purpose and provides guidance around heading structure.

Google also recommends that the main page title be clear and visually distinctive rather than presenting multiple equally prominent headings as competing titles.

Sources:
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/WCAG22/quickref/
- https://developers.google.com/search/docs/appearance/title-link

### Recommended semantic pattern

Every page template should have:

```html
<h1>Page Title</h1>

<h2>Major Section</h2>
<p>...</p>

<h2>Another Major Section</h2>
<h3>Subsection</h3>
```

The visual size should be controlled by CSS—not by choosing a heading level because it “looks right.”

This is a foundational template issue. Fixing it once in the page template can improve the whole site.

---

### Homepage Heading Problem

### Multiple competing H1-style messages

The homepage crawl exposes:

- Welcome to Our Community
- It's Our Anniversary
- Connecting the PG Community
- Take the Survey

as top-level headings.

A homepage can technically contain more than one H1 under modern HTML, but from a usability and accessibility perspective I would still establish one unmistakable page-level identity and use H2 for major sections.

The homepage should have one primary title and then clear content sections.

That also helps search engines determine the page's main subject.

Google's current guidance specifically warns that multiple equally prominent headings can make the primary title ambiguous.

Source:
- https://developers.google.com/search/docs/appearance/title-link

---

### Link Text

### Repeated “Read more” links

The News & Events page repeatedly uses “Read more” as the link label.

That is a very common design pattern, but it is not ideal for accessibility, scanning, or link-list navigation.

A user using a screen reader can pull up a list of links. A list of:

```text
Read more
Read more
Read more
Read more
Read more
```

is far less useful than:

```text
Read about the First PFAC Meeting in Michigan
Read the July 2026 All Things PG Newsletter
Read the First Year Anniversary Celebration
```

WCAG 2.2 requires link purpose to be understandable from the link text or its programmatically available context. W3C also explicitly recommends descriptive link text where possible.

Source:
- https://www.w3.org/WAI/WCAG22/quickref/?versions=2.0
- https://www.w3.org/WAI/WCAG22/Techniques/general/G53.html

### Recommendation

Use full link labels wherever practical.

If visual design requires “Read more,” make the accessible name something like:

```text
Read more about First PFAC Meeting in Michigan
```

while retaining the shorter visual treatment.

---

## Accessibility

### Accessibility should be treated as a primary design requirement

The target audience makes accessibility particularly important.

PG affects people dealing with:

- pain
- mobility limitations
- fatigue
- cognitive overload
- difficulty concentrating
- caregiver burden
- potentially older users
- potentially users who depend on keyboard, zoom, screen readers, or voice input

The site therefore should aim for **WCAG 2.2 AA**, not merely “good enough for most visitors.”

W3C currently recommends WCAG 2.2 as the conformance target for sites updating from earlier WCAG versions.

Source:
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/

### Specific accessibility concerns visible from this review

### Heading semantics

As described above, the apparent H3/H4 page-title structure needs correction.

**Priority: High**

### Image alternative text

The homepage exposes one image simply as “Image,” while some content images have more descriptive alternatives and others use very minimal text such as “5.”

Examples observed include:

- generic “Image”
- “Image: 5”
- descriptive board-member image alternatives

That inconsistency suggests an image authoring/governance problem.

Decorative images should use empty alt text.

Meaningful images should describe their purpose.

Images containing text should not rely solely on an unhelpful alt string such as “5.”

**Priority: High**

### Keyboard and focus

The site needs a full keyboard pass for:

- top navigation
- mobile navigation
- carousel/slider controls
- clinic finder sorting/filtering
- map interactions
- forms
- external-service embeds
- modal/pop-up components, if present
- newsletter/signup experiences

WCAG 2.2 adds specific requirements around focus visibility and focus not being obscured.

Source:
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/
- https://www.w3.org/TR/WCAG22/

**Priority: High**

### Touch target size

WCAG 2.2 includes a minimum target-size requirement of 24×24 CSS pixels for pointer inputs, subject to exceptions.

Small text links, map controls, menu controls, sort controls, and icon-only buttons should be tested.

Source:
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/

**Priority: Medium/High**

### Form labels and error handling

The contact page exposes fields for:

- name
- email
- phone
- interest/message/question

W3C recommends explicit labels, clear instructions, and useful error feedback. Accessible forms are easier for everyone, not just assistive-technology users.

Sources:
- https://www.w3.org/WAI/tutorials/forms/
- https://www.w3.org/WAI/tutorials/forms/labels/
- https://www.w3.org/WAI/test-evaluate/preliminary/

**Priority: High**

#### Color contrast

I could not reliably measure the exact color ratios from the rendered crawl.

This should be included in a dedicated automated accessibility test.

WCAG AA requires, among other things, a 4.5:1 contrast ratio for normal text and 3:1 for large text.

**Priority: High to verify**

#### Zoom/reflow

The site should be tested at:

- 200% zoom
- 400% zoom where practical
- narrow mobile widths
- large text settings
- Windows high-contrast/contrast themes where relevant

Health-oriented sites should remain useful at large text sizes.

---

## Forms

### Contact form: unnecessary friction

The contact page marks:

> *Your phone number

as a required field.

For a general nonprofit contact form, a phone number is usually not essential to answer a question.

Requiring it can cause unnecessary abandonment and makes users wonder why it is needed.

W3C's forms guidance explicitly notes that users prefer simpler forms and recommends asking only for information required to complete the process.

Source:
- https://www.w3.org/WAI/tutorials/forms/

### Recommendation

Use:

- Name — required
- Email — required
- Message — required
- Phone — optional

Then explain why phone is useful if you truly need it.

### Even more important: discourage health disclosures

The free-text field says:

> “Your interest, message or question”

That invites people to tell the organization about a personal health situation.

The privacy page audited is specifically framed around newsletter collection, not a full website privacy model.

I strongly recommend adding a visible instruction above the contact form:

> **Please do not include medical records, detailed medical history, photographs of wounds, prescription information, or other sensitive health information in this form.**

Provide an appropriate route for information that genuinely needs to be shared.

This is both a risk-management and usability improvement.

---

### Newsletter Experience

### Current implementation

The site has a dedicated `/subscribe` page and links to a Constant Contact page as a fallback.

The crawl shows the signup form area itself as largely empty while exposing:

> “Click here to sign up if you're unable to complete the form above.”

That strongly suggests an embedded third-party form with an external fallback.

Source:
- https://www.allthingspg.org/subscribe

### UX issue

A newsletter signup is one of the simplest actions on the site.

It should feel instant, obvious, and trustworthy.

The ideal experience is:

```text
Email address
[____________]

[Subscribe to PG updates]

We send occasional news, research and community updates.
```

Then confirmation should clearly explain what happens next.

### Recommendation

Keep the email platform if it is working operationally, but wrap it in a first-party experience:

- visible field labels
- concise explanation
- explicit consent language where needed
- clear validation errors
- no surprise redirect
- clear success state
- privacy link immediately adjacent
- mobile-friendly interaction
- keyboard accessibility
- accessible fallback

---

### Survey Experience

### Current implementation

The PG survey page links to an OHSU Qualtrics survey.

The external survey page presents a JavaScript-required shell to the audit crawler.

Source:
- https://www.allthingspg.org/take-the-pg-survey
- https://ohsu.ca1.qualtrics.com/jfe/form/SV_1Rgun9506UbVoEe

Qualtrics is a reasonable platform choice, but the site should treat the survey as an **important application**, not merely an outbound link.

### Recommended UX

Before leaving the site, show:

- who can participate
- approximate time required
- whether it is anonymous
- who sponsors/administers it
- what happens with the information
- whether participation is voluntary
- any age requirements
- accessibility/contact support
- external-site indicator

Then:

**Start the PG Survey →**

This makes the transition much less abrupt.

---

### Clinic Finder: The Most Important Product on the Site

### Strategic assessment

The Clinic Finder is arguably the most valuable service feature on the entire site.

The page says it provides an interactive, searchable map of clinics and providers who evaluate and treat PG.

The current visible data includes:

- provider name
- clinic name
- city/state
- provider type
- telehealth availability
- clinical trial availability
- “more info”
- sorting by provider name or clinic name

Source:
- https://www.allthingspg.org/pyoderma-gangrenosum-clinic-finder

That is an excellent foundation.

### The current UX is not yet mature enough for the importance of the task

The crawl does not expose an obvious user-facing search input or sophisticated filter set, even though the page describes the tool as searchable.

This may be because the interactive map/search layer is JavaScript-rendered, so it should not automatically be called a defect.

But because this is a core service, it needs an explicit usability test.

### Ideal clinic-finder task flow

A user should be able to say:

> “I live near Charleston, South Carolina. Show me the closest PG-experienced providers.”

The interface should support:

```text
ZIP code / City / State
[ 29577                       ]

Distance
[ 25 miles ▼ ]

Provider type
[x] Dermatologist
[ ] Rheumatologist
[ ] Wound care
[ ] Other

Telehealth
[x] Available

Clinical trials
[ ] Available

[ Find PG care ]
```

Then return:

```text
18 providers found

Map                         Results

1. Provider Name
   Clinic
   Charleston, SC
   Dermatology
   Telehealth available
   Clinical trials
   12 miles

   View provider
```

### Essential capabilities to add

#### Geographic search

- ZIP
- city
- state
- optionally “use my location” with permission

#### Filters

- provider specialty
- clinic type
- telehealth
- clinical trials
- accepting new patients if verifiable
- pediatric/adult where applicable

#### Sorting

- nearest
- provider name
- clinic name

#### Result count

Always show:

> 12 providers found

This helps users understand whether their search worked.

#### Map/list synchronization

Clicking a map marker should highlight the corresponding card.

Clicking a card should highlight/pan the map.

#### Mobile-first design

On mobile:

- list first
- map toggle
- large tap targets
- sticky “filters” action
- no tiny map-only controls

#### Clear provider detail

A provider record should ideally contain:

- provider name
- credentials
- specialty
- clinic name
- full address
- phone
- clinic website
- appointment/contact route
- telehealth coverage
- clinical trials
- referral requirements where known
- insurance note where verified
- last verified date
- data source

### The key scalability recommendation: normalize the data

Do not treat every clinic record as a blob of page text.

Use separate structured entities such as:

```text
Provider
    provider_id
    name
    credentials
    specialties
    status

Clinic
    clinic_id
    name
    address
    city
    state
    ZIP
    phone
    website

ProviderClinic
    provider_id
    clinic_id
    role
    telehealth
    clinical_trials

Verification
    record_id
    verified_date
    verified_by
    source
    notes
```

This lets one provider work at multiple clinics and prevents duplicate data.

### Add “last verified”

This is extremely important.

A clinic directory is only trustworthy if users know how current it is.

Show:

> Verified September 2026

or:

> Last reviewed September 2026

and provide:

> Report an update

That creates a sustainable maintenance loop.

---

## Data Model and Scalability

### The site should move toward real content types

The current site can probably handle incremental growth, but a page-by-page publishing model will become painful once the organization has dozens or hundreds of resources.

At minimum, define these content types:

### Page

For durable informational content.

Fields:
- title
- slug
- summary
- body
- hero image
- audience
- topic
- related pages
- medical reviewer
- last reviewed
- sources
- SEO title
- SEO description

### Resource

For downloadable or external resources.

Fields:
- title
- resource type
- audience
- topic
- language
- file/external URL
- date
- expiration/review date

### Article

Fields:
- title
- excerpt
- body
- publish date
- author
- categories
- tags
- featured image
- external/internal
- review date

### Event

Fields:
- title
- date
- start time
- end time
- time zone
- location
- virtual/in-person
- registration URL
- recording URL
- status

### Person

Fields:
- name
- role
- photo
- short bio
- long bio
- credentials
- specialty
- organization
- publications
- social/external links

### Clinic

Structured record as discussed above.

### Partner

Fields:
- organization
- category
- URL
- logo
- description
- relationship type

### Translation

Never treat translated pages as unrelated copies.

Each localized page should know:

```text
English page ID
Spanish page ID
French page ID
...
```

That makes translation management possible.

---

### News & Events

### Current state

The News & Events page contains a chronological list of announcements, newsletters, videos, survey notices, PFAC events, external media coverage, and older items.

Source:
- https://www.allthingspg.org/news-and-events

This is fine at low volume.

It will degrade as the organization publishes more frequently.

### Current problems

The content types are mixed.

For example:

- newsletter
- organization announcement
- local event
- podcast
- YouTube video
- survey
- Zoom event
- third-party media story

all appear together.

A user looking for an upcoming event has to scan through unrelated articles.

### Recommendation

Split discovery by content type:

```text
News
Events
Newsletters
Videos
Research/Study Updates
```

Then provide filters:

- topic
- year
- category
- audience

### Future event lifecycle

An event should move automatically through:

```text
Upcoming
    ↓
Today
    ↓
Completed
    ↓
Recording available
    ↓
Archived
```

This prevents manual maintenance and keeps the page clean.

---

### Date and Editorial Governance

### Small examples matter because they signal system quality

The site contains minor editorial inconsistencies in event/article content, such as “Kalamzoo” rather than “Kalamazoo” in one event listing.

That is not a major website problem by itself.

What it demonstrates is a broader governance issue:

**The system needs a publish/review process that catches small errors before they become part of a public archive.**

This matters more as the site grows.

### Recommended publishing workflow

Every page should have:

```text
Draft
Internal review
Medical review where applicable
Accessibility check
Publish
Review date
Next review due
```

For health information, the system should also support:

- reviewed by
- source/references
- medical owner
- last medically reviewed
- next review date

---

## Medical Trust Without Turning the Site Into a Medical Textbook

### The site should distinguish “information” from “authority”

I intentionally did not evaluate the accuracy of the medical material in depth because that was not the requested focus.

However, the structure of a modern health site should make trust easy to assess.

Mayo Clinic's current PG material makes source/review information, staff attribution, references, treatment sections, “when to see a doctor,” and appointment-preparation guidance part of the experience.

Source:
- https://www.mayoclinic.org/diseases-conditions/pyoderma-gangrenosum/symptoms-causes/syc-20350386
- https://www.mayoclinic.org/diseases-conditions/pyoderma-gangrenosum/diagnosis-treatment/drc-20350392

All Things PG can keep its patient-friendly tone while adding small trust signals:

```text
Medically reviewed by Dr. ______
Last reviewed: September 2026
Sources
```

This is much more useful than simply adding a generic disclaimer at the bottom.

---

### “Living With PG” Is Underdeveloped as a Navigation Concept

### The content exists, but the experience does not fully reflect it

The site already has:

- Talking About PG
- How to Identify PG
- support-related content
- clinic finding
- associated conditions

But the global IA does not make “Living with PG” a dominant destination.

The Crohn’s & Colitis Foundation is a good reference point because it explicitly organizes a user journey around being newly diagnosed, living with the condition, treatment decisions, support, and related resources.

Source:
- https://www.crohnscolitisfoundation.org/patientsandcaregivers/ibdjourney

The National Psoriasis Foundation similarly organizes around user states and provides a dedicated patient navigation center.

Sources:
- https://www.psoriasis.org/
- https://www.psoriasis.org/navigationcenter/

### Recommended change

Make “Living With PG” a real destination rather than an implied collection.

That page could become the practical launchpad for:

- emotional support
- talking to doctors
- caregiver information
- wound-care resources
- preparing for appointments
- tracking symptoms
- workplace/disability issues
- insurance/navigation
- peer support
- patient stories

This would significantly increase the site's usefulness without needing huge amounts of new content.

---

### Audience Segmentation

### The site currently serves multiple audiences but does not clearly separate them

The site is relevant to:

- patients
- caregivers
- dermatologists
- other clinicians
- researchers
- advocates
- donors/industry
- partner organizations

Yet the IA primarily organizes by internal topic.

That causes different audiences to enter the same navigation structure.

### Recommended audience entry points

Near the top of the homepage:

```text
Who are you?

[ I have PG ]
[ I care for someone with PG ]
[ I am looking for a diagnosis ]
[ I am a healthcare professional ]
[ I am a researcher ]
```

You do not need to force registration or collect personal data.

These are simply shortcuts.

### Why this matters

Recognition is easier than recall.

Nielsen Norman Group's usability heuristics include “Recognition Rather Than Recall” and emphasize making relevant options visible instead of forcing users to remember where a task is located.

Source:
- https://www.nngroup.com/articles/ten-usability-heuristics/

---

### Content Discovery

### Current weakness

The site depends heavily on navigation plus search-engine entry.

That works while there are relatively few pages.

As content grows, users will need:

- related content
- topic hubs
- tags
- search
- filters
- “next step” calls to action
- recommendation blocks

### Every durable page should end with a “What next?” block

For example:

**After reading about diagnosis:**

```text
What should I do next?

[ Find a PG-experienced provider ]
[ Learn about treatment ]
[ Prepare for your appointment ]
```

**After reading about symptoms:**

```text
You may also want to read:

Diagnosis of PG
How to Identify PG
Find a PG Clinic
```

This is more useful than a generic newsletter CTA after every page.

---

### Footer Strategy

### Current footer is functional but underpowered

The footer repeats About PG and Living With PG links and includes Data and Privacy.

That is fine, but the footer could become a more useful secondary navigation hub.

Recommended footer columns:

```text
LEARN
What is PG?
Symptoms
Diagnosis
Treatment

GET HELP
Find a Clinic
Support
Caregiver Resources
Contact

GET INVOLVED
PG Survey
Research
PFAC
Advocacy

ABOUT
Mission
Our People
Partners
News & Events
Donate

LEGAL
Privacy
Accessibility
Terms
```

Add:

- social links if actively maintained
- organization email
- contact route
- copyright
- accessibility statement
- language selector

---

### Language Support

### This needs attention immediately

The global header exposes:

- English
- Spanish
- French
- Italian
- German

However, during this audit the non-English language controls did not expose corresponding localized pages in the crawl; the navigation returned to the primary homepage behavior rather than showing clearly localized content.

That makes the controls potentially misleading.

### Three acceptable strategies

#### Strategy A — fully implement multilingual content

Best long-term solution if the audience genuinely needs it.

Use structured translation relationships and proper language metadata.

#### Strategy B — support only English for now

Remove the unused language links until translations are live.

This is better than promising translations that do not exist.

#### Strategy C — translate a carefully selected subset

For example:

- What is PG?
- Symptoms
- Diagnosis
- Treatment
- Find a Clinic
- Support
- Contact

This can be a very effective interim solution.

### Technical requirements

A multilingual implementation should use:

- correct `lang` attributes
- `hreflang`
- translated titles/descriptions
- translated navigation
- equivalent content relationships
- language-aware URLs
- no fake language links

Google's mobile-first guidance explicitly recommends maintaining equivalent content and metadata across localized/mobile representations.

Source:
- https://developers.google.com/search/docs/crawling-indexing/mobile/mobile-sites-mobile-first-indexing

---

## Privacy and Trust

### Current privacy statement is too narrow for a growing site

The Data and Privacy page describes newsletter information such as name and email and explains general protections.

Source:
- https://www.allthingspg.org/data-and-privacy

However, the broader ecosystem now involves:

- contact form
- newsletter provider
- Qualtrics/OHSU survey
- Givebutter donation system
- Constant Contact PFAC/event forms
- YouTube/video services
- potentially map/location features

That creates a broader data-processing environment than the current page describes.

### Recommendation

Create a site-wide privacy framework that distinguishes:

```text
Website visitor data
Contact form data
Newsletter data
Survey data
Donation data
Event registration data
Clinic-finder/location interactions
External services
Cookies/analytics
Retention
User rights
How to request corrections/deletion
```

This does not need to become an enormous legal document on every page.

It should simply be accurate, centralized, and linked wherever users provide data.

---

## Third-Party Dependencies

### Current site ecosystem

Observed external dependencies include:

- OHSU Qualtrics for the survey
- Constant Contact for newsletter/PFAC signup
- Givebutter for donations
- YouTube for at least one video
- Zoom for at least one meeting/event
- external partner organizations
- third-party media outlets

This is normal for a nonprofit.

It becomes a scalability issue when users cannot tell which experience is still “All Things PG” and which is a third-party service.

### Recommendation

Standardize all external transitions:

```text
Take the PG Survey ↗
Donate securely via Givebutter ↗
Register for PFAC ↗
Watch on YouTube ↗
```

For important workflows, include a short “You are leaving All Things PG” cue only when it is genuinely useful.

Do not use popups for every external link.

---

## Performance and Core Web Vitals

### I am deliberately not giving the site a fake performance score

I was not able to obtain a reliable PageSpeed/Lighthouse lab result during this audit, so any numeric performance claim would be invented.

The relevant current standard is Google's Core Web Vitals:

- LCP — loading
- INP — responsiveness
- CLS — visual stability

Google currently recommends good user experience at the 75th percentile around:

- LCP ≤ 2.5s
- INP ≤ 200ms
- CLS ≤ 0.1

Source:
- https://web.dev/articles/vitals

### What I would test on this site

At minimum:

1. Homepage
2. What is PG?
3. Treatment of PG
4. Clinic Finder
5. News & Events
6. Our People
7. Individual article
8. Subscribe
9. Contact
10. Donate

Test both desktop and mobile.

### Performance risks to investigate

#### Hero and promotional images

Large image-based sections can hurt LCP.

#### Third-party embeds

Constant Contact, Qualtrics, maps, YouTube, and donation services can add:

- JavaScript
- DNS lookups
- layout changes
- tracking requests
- interaction delays

#### Image formats

Use modern responsive image delivery:

- AVIF/WebP where supported
- correctly sized variants
- `srcset`
- width/height attributes
- lazy loading below the fold
- priority loading only for the main LCP image

#### Fonts

Limit custom font families/weights.

#### Carousels

Avoid loading a large group of slides/images just to display one.

---

### Search Engine Optimization

### Good foundation

The site already has several SEO-friendly characteristics:

- descriptive URLs
- focused topic pages
- individual news pages
- individual people pages
- clear page subjects
- crawlable navigation

Examples:

- `/what-is-pg`
- `/pg-symptoms`
- `/diagnosis-of-pg`
- `/treatment-of-pg`
- `/pyoderma-gangrenosum-clinic-finder`

These are good URL patterns.

### Areas to improve

#### Page titles

Ensure every page has a unique, descriptive title.

Google recommends that each page have a concise and descriptive `<title>` and warns against repeated boilerplate titles.

Source:
- https://developers.google.com/search/docs/appearance/title-link

Ideal examples:

```text
Pyoderma Gangrenosum Symptoms | All Things PG

Diagnosing Pyoderma Gangrenosum | All Things PG

PG Clinic Finder | Find a Pyoderma Gangrenosum Specialist
```

#### Meta descriptions

Each important page should have a unique, useful description that explains the page's purpose.

#### Organization structured data

The homepage should use `Organization` structured data with relevant properties such as:

- name
- logo
- URL
- sameAs
- contact information where appropriate

Google explicitly recommends Organization structured data to help it understand and disambiguate an organization.

Source:
- https://developers.google.com/search/docs/appearance/structured-data/organization

#### Article structured data

News/articles should use appropriate structured data.

#### Event structured data

Events should use Event schema with:

- date
- time
- location
- virtual status
- registration URL

#### Breadcrumb structured data

Use breadcrumbs where appropriate.

#### Author/profile data

People pages should have clear metadata connecting a person to the organization and role.

---

## Indexing and Crawlability

### The sitemap could not be directly verified in this environment

Attempts to access the site's robots.txt and sitemap.xml through the browser tool were not successful.

That is not proof that these files do not exist.

A production audit should verify:

```text
/robots.txt
/sitemap.xml
```

and then inspect:

- canonical URLs
- indexing directives
- sitemap coverage
- lastmod values
- redirect chains
- orphan pages
- duplicate pages
- broken internal links

Google recommends crawlable URL structures, standard anchor links, and appropriate sitemap use.

Source:
- https://developers.google.com/search/docs/crawling-indexing/troubleshoot-crawling-errors

---

## Content Architecture vs. Content Volume

### The site does not need 5x more pages

This is an important strategic point.

The goal should not be:

> “We need more content.”

The goal should be:

> “We need better paths through the content we already have.”

For example, the pages:

- What is PG?
- Symptoms
- Causes
- Diagnosis
- Treatment
- Associated Health Issues

already create a basic information set.

A stronger system would connect these through:

```text
What is PG?
    ↓
What are the signs?
    ↓
How is PG diagnosed?
    ↓
How do I find an experienced provider?
    ↓
What treatment options exist?
    ↓
How do I live with PG?
```

That is a patient journey.

The present architecture is more like:

```text
Here are six pages. Choose one.
```

That distinction is one of the biggest usability opportunities.

---

## News, Articles, and Evergreen Information Should Be Different Things

### Current site blurs these categories

A durable medical-information page is not the same thing as:

- an event announcement
- a newsletter
- a news item
- a patient story
- a third-party media link

These should have different templates.

### Recommended content lifecycle

#### Evergreen medical information

Review every 6–12 months.

#### News

Time-sensitive; archive automatically.

#### Events

Expire into archive after event.

#### External media

Preserve source date and external link.

#### Patient stories

Keep indefinitely, but allow topic/category tagging.

#### Research updates

Add publication date and review/source information.

This approach reduces clutter and makes the website much easier to maintain.

---

### Search and Filtering as the Site Grows

### The first search problem is not “search everything”

It is discovering the right things.

NORD's current Resource Library is a useful example: it provides keyword search plus audience/collection categories and a paginated resource set.

Source:
- https://rarediseases.org/resource-library/

That model is more scalable than a single flat News & Events page.

### Recommended resource library

Eventually add:

```text
Search resources

Audience
[ Patient ]
[ Caregiver ]
[ Clinician ]
[ Researcher ]

Topic
[ Diagnosis ]
[ Treatment ]
[ Support ]
[ Research ]
[ Advocacy ]

Format
[ Article ]
[ PDF ]
[ Video ]
[ External website ]
[ Tool ]

Language
[ English ]
[ Spanish ]
...
```

This makes the site significantly more useful without requiring sophisticated artificial intelligence.

---

## Mobile Experience

### Responsive design should be assumed, then tested—not assumed sufficient

Google recommends responsive web design and emphasizes that the mobile version is used for indexing.

Source:
- https://developers.google.com/search/docs/crawling-indexing/mobile/mobile-sites-mobile-first-indexing

The site should be tested at:

- 320px
- 375px
- 390px
- 414px
- tablet
- desktop
- large desktop

### Mobile-specific tasks

Pay particular attention to:

- opening the navigation
- returning to the previous page
- clinic-finder filtering
- map/list toggle
- long medical pages
- donation process
- newsletter signup
- forms
- external redirects
- image/text reflow
- fixed headers/footers

### Clinic Finder is the highest-value mobile test

Someone searching for a specialist may be doing it from:

- a phone
- a hospital room
- a doctor's office
- while traveling
- while helping a family member

That is exactly where the interface needs to be excellent.

---

### Visual Hierarchy

### The site should feel calmer

The subject matter is emotionally heavy.

Modern patient-support sites benefit from:

- strong white space
- restrained motion
- large readable type
- obvious buttons
- short sections
- clear cards
- fewer competing promotions
- reassuring visual consistency

The site should not feel like a marketing brochure.

It should feel like:

> **a trustworthy patient resource center.**

### Use visual hierarchy to show importance

For example:

**Primary**
- Find a PG Clinic
- Get Support

**Secondary**
- Learn About PG
- Take the Survey
- Research

**Tertiary**
- News
- Partners
- Organization history

That ordering reflects user value rather than organizational priority.

---

### Calls to Action

### Current calls to action are somewhat repetitive

The site repeatedly promotes:

- newsletter
- survey
- clinic finder

This is not inherently bad, but repetition without contextual relevance makes calls to action feel like advertising.

### Use contextual CTAs

Instead of:

> Sign up for updates

at the end of every page, do:

**Diagnosis page**

> Find an experienced PG provider.

**Treatment page**

> Learn how to find PG-aware wound care.

**Talking About PG**

> Find support from people who understand PG.

**Research page**

> Take the PG patient survey.

This is much more persuasive and less intrusive.

---

## Our People

### What works

The organization is unusually transparent about its leadership.

The board page exposes:

- names
- roles
- photos
- biographies

and individual profile pages exist.

Source:
- https://www.allthingspg.org/our-people

This is excellent for a patient advocacy organization.

### Scalability issue

Individual profiles should have structured fields, not just long narrative blocks.

For example:

```text
Name
Role
PG connection
Professional credentials
Short bio
Full bio
Areas of expertise
Publications
External credentials
Contact/organizational link
```

That would allow the site to create:

- leadership listings
- expert directory
- clinician profiles
- research contributors
- conference speakers

without creating completely different templates.

---

### Industry Partners

### Current approach is primarily narrative

The Industry Partners page explains why support matters but does not appear to operate like a structured partner directory.

Source:
- https://www.allthingspg.org/industry-partners

As the number of partners grows, this should become a proper partner content type.

Useful fields:

- organization name
- logo
- partner level/type
- website
- year
- sponsorship/program
- description
- disclosure/relationship language

This avoids a giant page that has to be manually rearranged every time a sponsor changes.

---

### Rare Disease Affiliates

### Good concept, but likely underused

The Rare Disease Affiliates page currently links to a small set of relevant organizations, including Global Skin, the Hidradenitis Suppurativa Foundation, and NORD.

Source:
- https://www.allthingspg.org/rare-disease-affiliates

As the directory grows, use:

- organization cards
- category
- condition
- purpose
- country
- website
- verification date

This can become a genuinely useful rare-disease resource directory.

---

### PFAC

### Valuable program, but currently feels like an event page

The PFAC page contains a clear purpose, agenda, date/time options, and signup links.

Source:
- https://www.allthingspg.org/pfac

The current text also contains spacing/authoring problems such as:

> “meetingaccessible to as many aspossible.Please”

That is minor editorially but important as a signal of template/publishing quality.

### Better PFAC structure

Create a permanent PFAC landing page:

```text
Patient & Family Advisory Committee

What PFAC is
Who can participate
How PFAC works
Upcoming meetings
Past meetings
Recordings
How to join
Contact
```

Then events become children of that program rather than standalone pages.

This is a classic scalability principle:

> **Programs should own events, not the other way around.**

---

### Donation Experience

### Current state

The donation page explains the mission and sends users to Givebutter.

Source:
- https://www.allthingspg.org/donate

That is a reasonable implementation.

### Recommendation

The page should make the decision easy:

```text
Support All Things PG

Your donation helps us:

✓ connect patients with PG-experienced care
✓ support patient education
✓ strengthen research participation
✓ build community resources

[ Donate Now ]

Other ways to help
[ Volunteer ]
[ Share PG information ]
[ Participate in research ]
```

The donation page should feel like an action page, not an essay.

---

### Trust Architecture

### Add a persistent “reviewed” model

For health information, every significant evergreen page should eventually display something similar to:

> **Medically reviewed by Dr. ______**  
> **Last reviewed: September 2026**

Optional:

> **Medical review due: September 2027**

This helps users distinguish stable information from event/news material.

### Add source blocks

At the bottom:

```text
Sources & Further Reading
- ...
- ...
```

This is especially valuable on diagnosis and treatment pages.

The goal is not to make the page academic. It is to make it auditable.

---

### Scalability: What Will Break First?

### 1. Clinic directory

This is the highest-risk area because data changes and duplication grows.

### 2. News/events

The current flat chronological feed will become harder to navigate.

### 3. Translations

Five language links imply a much larger publishing burden than the current English-only experience suggests.

### 4. Resource discovery

As soon as you have 50–100 resources, navigation alone becomes inadequate.

### 5. People and partner pages

Narrative profiles are fine at six people. They become difficult at 30–50.

### 6. External services

More forms and tools can create a fragmented user experience.

### 7. Manual QA

Every new content type multiplies the chance of broken links, inconsistent headings, wrong dates, image problems, and stale information.

---

### Recommended Technical Direction

### Do not rebuild the site simply for visual reasons

A rebuild should happen because the underlying model needs to support:

- structured content
- reusable components
- accessibility
- search
- filtering
- multilingual content
- clinic data
- events
- review workflows
- structured SEO
- analytics
- automated QA

The visual redesign should sit on top of those foundations.

### Core architecture principles

#### One shared design system

Define reusable:

- buttons
- cards
- notices
- headings
- article headers
- provider cards
- event cards
- link styles
- forms
- alert boxes
- call-to-action sections

#### One content model per content type

Do not create each new event by manually copying an old page and changing the text.

#### Structured metadata

Every page should have:

- page type
- audience
- topic
- review status
- author
- review date
- related content
- SEO fields

#### Centralized navigation

Header/footer should exist as reusable components.

#### Automated link checking

Run regularly against:

- internal links
- external links
- PDF resources
- partner sites
- event URLs
- YouTube URLs

#### Automated accessibility checks

Run in CI or publishing QA where possible.

#### Content expiry

Especially:

- events
- time-sensitive announcements
- clinical trial links
- partner programs
- external resources

---

#3 Analytics

### The site needs a task-oriented measurement plan

Do not only measure pageviews.

Measure tasks:

```text
Clinic Finder starts
Clinic Finder searches
Clinic Finder result clicks
Clinic detail views
Survey clicks
Newsletter starts
Newsletter completions
Contact starts
Contact completions
Donation clicks
Donation completions
External-resource clicks
Search queries
Zero-result searches
```

### Most valuable metric

The most important measurement should be:

> **Did the visitor successfully complete what they came here to do?**

For example:

> Visitor searched for PG care → found provider → clicked provider/contact information.

That tells you more than traffic alone.

---

### Search Analytics

### Zero-result searches will be especially valuable

When the site gets internal search, log searches that return nothing.

Examples:

```text
“wound care”
“biopsy”
“prednisone”
“insurance”
“support group”
“Florida”
```

A large number of zero-result searches identifies missing content or terminology gaps.

This is one of the easiest ways to let the website tell you what it needs next.

---

### Content Governance

### Assign an owner to every content class

Example:

| Content | Owner |
|---|---|
| PG medical education | Medical/content lead |
| Clinic directory | Directory administrator |
| Events | Program coordinator |
| PFAC | PFAC owner |
| News | Communications |
| Board profiles | Executive/board admin |
| Privacy | Admin/legal owner |
| Translations | Translation/content owner |

This prevents “everyone owns it, so nobody maintains it.”

---

### Publishing Checklist

### Every new page should pass this checklist

```text
[ ] Correct page template
[ ] Correct URL
[ ] Exactly one clear H1
[ ] Logical H2/H3 structure
[ ] Useful page title
[ ] Meta description
[ ] Descriptive link text
[ ] Alt text reviewed
[ ] Mobile layout checked
[ ] Keyboard navigation checked
[ ] Focus visible
[ ] External links identified where appropriate
[ ] Related content included
[ ] Primary CTA included
[ ] Medical review recorded if applicable
[ ] Sources recorded if applicable
[ ] Review date recorded
[ ] Broken links checked
```

This is far more scalable than relying on individual editors to remember every requirement.

---

### Recommended Redesign of the Homepage

### Proposed wireframe

```text
--------------------------------------------------
LOGO

Learn About PG   Find Care   Living With PG
Support          Research   News & Events
                         [Donate]
--------------------------------------------------

Pyoderma Gangrenosum Support & Information

Trusted information, PG-experienced care,
community support, and ways to participate.

[ FIND A PG CLINIC ]   [ GET SUPPORT ]
--------------------------------------------------

WHERE SHOULD I START?

[ I am newly diagnosed ]
Learn what PG is and what to do next.

[ I think I may have PG ]
Learn the common signs and why diagnosis is difficult.

[ I care for someone with PG ]
Support and practical guidance for caregivers.

[ I am a healthcare professional ]
Clinical and research resources.

--------------------------------------------------

FIND PG CARE NEAR YOU

Search for PG-experienced providers.

[ ZIP / CITY / STATE ]
[ FIND CARE ]
--------------------------------------------------

LIVING WITH PG

Talking about PG
Support resources
Caregiver resources
Preparing for appointments
--------------------------------------------------

RESEARCH & ADVOCACY

Take the PG Survey
Clinical research
PFAC
Advocacy
--------------------------------------------------

LATEST

3–4 current items

[View all news & events]
--------------------------------------------------

ABOUT ALL THINGS PG

Mission
Leadership
Partners

[Donate]
[Contact Us]
--------------------------------------------------
```

This is dramatically more useful than a promotional carousel because it provides a visible path for every major audience.

---

### Recommended Redesign of an Educational Page

### Example: Diagnosis page

```text
<h1>Diagnosing Pyoderma Gangrenosum</h1>

Short answer:
PG is difficult to diagnose because ...

[Find a PG-experienced provider]

<h2>How PG is diagnosed</h2>

<h2>What other conditions can look similar?</h2>

<h2>Diagnostic frameworks</h2>

<h2>When to seek specialist care</h2>

<h2>How to prepare for an appointment</h2>

<h2>Related resources</h2>

[Find a Clinic]
[Talking About PG]
[Treatment of PG]

Medical review:
Reviewed by ______
Last reviewed: ______
```

This makes the page a journey rather than a wall of information.

---

### Recommended Redesign of the Clinic Finder

### Desktop

```text
----------------------------------------------------------
FIND PG CARE NEAR YOU

Search by ZIP, city, or state

[____________________________] [ SEARCH ]

Filters:
Distance  Specialty  Telehealth  Clinical Trials

----------------------------------------------------------
18 providers found

MAP                        RESULTS

     [map]                 Provider Name
                           Clinic Name
                           City, ST
                           Dermatology
                           Telehealth
                           Clinical trials
                           [View details]

                           Provider Name
                           ...
----------------------------------------------------------
```

### Mobile

```text
Find PG Care

[ ZIP / City / State ]

[ Search ]

18 providers found

[ Filters ]

[ Map ] [ List ]

Provider card
----------------
Name
Clinic
City, ST
12 miles
Telehealth
Clinical trials

[ View details ]
```

This is the kind of focused application experience the current site can grow into.

---

### Recommended Search Experience

### Global search

```text
Search All Things PG

[ search __________________ ] [Search]

Suggested:
“diagnosis”
“clinic”
“wound care”
“support”
“research”
```

### Results

```text
12 results

Clinical information
    Diagnosing PG

Living with PG
    Talking About PG

Care
    Find a PG Clinic

Resources
    ...
```

Search should highlight the matching words and allow filtering.

---

### Modern-Website Comparison

### NORD

NORD provides a large resource library with search and filtering.

This is the direction to emulate for resource discovery—not necessarily the visual design.

Source:
- https://rarediseases.org/resource-library/

**Lesson for All Things PG:** structured content beats giant lists.

### National Psoriasis Foundation

NPF prominently asks visitors to identify where they are in their journey and provides a Patient Navigation Center.

Sources:
- https://www.psoriasis.org/
- https://www.psoriasis.org/navigationcenter/

**Lesson for All Things PG:** start with the user state, not the organization structure.

### Crohn's & Colitis Foundation

The IBD Journey explicitly supports newly diagnosed users, diagnosed users, support-seeking, provider discovery, and decision-making.

Sources:
- https://www.crohnscolitisfoundation.org/patientsandcaregivers/ibdjourney
- https://www.crohnscolitisfoundation.org/

**Lesson for All Things PG:** build a journey model.

### Mayo Clinic

Mayo's PG pages clearly separate overview, symptoms, diagnosis, treatment, support, preparation for appointments, and related care options.

Sources:
- https://www.mayoclinic.org/diseases-conditions/pyoderma-gangrenosum/symptoms-causes/syc-20350386
- https://www.mayoclinic.org/diseases-conditions/pyoderma-gangrenosum/diagnosis-treatment/drc-20350392

**Lesson for All Things PG:** use predictable medical-information patterns and strong next steps.

---

### Heuristic Evaluation

### Nielsen's 10 heuristics

Using Nielsen Norman Group's classic heuristics as a framework:

Source:
- https://www.nngroup.com/articles/ten-usability-heuristics/

### Visibility of system status — 3/5

Good for ordinary page navigation.

Needs improvement for:

- clinic search status
- filtering
- form submission
- external transitions
- newsletter/registration success
- errors

### Match with the real world — 3/5

The language is understandable.

The IA, however, still maps somewhat to organization structure instead of patient journey.

### User control and freedom — 3/5

Standard browsing is straightforward.

Interactive tools and third-party transitions need testing.

### Consistency and standards — 3/5

The global structure is consistent, but heading levels, link text, multilingual navigation, and content templates are not consistent enough.

### Error prevention — 2.5/5

The contact form asks for unnecessary phone information as a required field and does not make the purpose/handling of personal information sufficiently obvious.

### Recognition rather than recall — 2.5/5

Users have to know which top navigation section contains their task.

The homepage should expose more task-oriented choices.

### Flexibility and efficiency — 2.5/5

The site is easy to browse if you already know where things are.

Search, filters, topic hubs, and shortcuts are needed for efficient repeat use.

### Aesthetic/minimalist design — 3/5

The site has a clean nonprofit feel, but promotional repetition and sliders compete with the core patient tasks.

### Error recovery — 2.5/5

This needs dedicated form and interactive-tool testing.

### Help and documentation — 3/5

The site has useful educational pages but lacks a stronger “where do I start?” and “what should I do next?” layer.

---

### Priority Matrix

### P0 — Fix immediately

#### P0.1 Language navigation

Either implement the advertised languages or remove the inactive options.

#### P0.2 Heading semantics

Audit every page template for proper H1/H2/H3 structure.

#### P0.3 Contact form

Make phone optional unless there is a clear operational need. Add a warning not to submit sensitive medical information.

#### P0.4 Clinic Finder reliability

Test the complete workflow on desktop/mobile/keyboard and document how provider data is maintained.

---

### P1 — Major improvements

### P1.1 Rebuild information architecture around user tasks

Move from organization-centric categories to:

- Learn
- Find Care
- Living With PG
- Support
- Research/Advocacy
- News/Events

### P1.2 Replace promotional carousel with stable task-oriented hero

Use one primary message and fixed actions.

### P1.3 Introduce search

Start simple.

### P1.4 Create structured content types

Especially:

- Clinic
- Provider
- Event
- Article
- Resource
- Person
- Partner

### P1.5 Add review dates/medical review metadata

Especially on diagnosis/treatment pages.

### P1.6 Create a dedicated accessibility audit

Target WCAG 2.2 AA.

---

### P2 — Strategic improvements

### P2.1 Resource library

Search and filters.

### P2.2 Program pages

PFAC, research, advocacy, support.

### P2.3 Multilingual architecture

Implement properly rather than simply adding language links.

### P2.4 Event lifecycle

Upcoming → live → recording → archive.

### P2.5 Directory maintenance workflow

Verified dates and update requests.

### P2.6 Analytics tied to user tasks

Measure clinic searches, survey starts/completions, donation completions, and search success.

---

### P3 — Polish and optimization

### P3.1 SEO structured data

Organization, Article, Event, Breadcrumb.

### P3.2 Performance optimization

Images, third parties, fonts, JavaScript, caching.

### P3.3 Design-system refinement

Reusable components and consistent page patterns.

### P3.4 Editorial QA automation

Broken links, missing alt text, missing page descriptions, orphan pages.

---

### Suggested 30-Day Plan

### Week 1 — Fix obvious UX defects

- remove or repair nonfunctional language controls
- review heading hierarchy
- review alt text
- make phone optional on contact
- add health-information warning to contact form
- review “Read more” link labels
- document clinic finder behavior
- remove unnecessary homepage repetition

### Week 2 — User journeys

Design five entry paths:

```text
I think I have PG
I have been diagnosed with PG
I care for someone with PG
I need a PG-experienced provider
I want to participate in research
```

### Week 3 — Clinic Finder

Document and prototype:

- search
- filters
- result cards
- provider detail
- verification dates
- update requests
- mobile workflow

### Week 4 — Analytics and accessibility

Set up/verify:

- Search Console
- analytics events
- accessibility scanner
- link checker
- Core Web Vitals monitoring

---

### Suggested 90-Day Plan

### Month 1

Fix P0 issues and prototype the new IA.

### Month 2

Build the new design system and structured content types.

### Month 3

Launch:

- redesigned homepage
- new navigation
- search
- improved clinic finder
- resource taxonomy
- stronger accessibility
- updated page templates

Do not wait for every piece of the site to be redesigned before improving the highest-value user tasks.

---

### Suggested 6–12 Month Plan

### Phase 1

Patient journey architecture.

### Phase 2

Clinic/provider directory database.

### Phase 3

Resource library and search.

### Phase 4

Multilingual implementation.

### Phase 5

Program pages for research, PFAC, advocacy, community.

### Phase 6

Personalized navigation/role-based experiences if analytics demonstrate a need.

---

### What Not To Do

### Do not simply make it “prettier”

A visual redesign without information-architecture changes would leave the major problems intact.

### Do not add more top-level menu items

There are already enough.

The solution is better categorization, not a larger menu.

### Do not create hundreds of hand-built pages

Use structured content.

### Do not add an AI chatbot as the first response

A chatbot can be useful later, but it should not compensate for weak navigation, search, or content architecture.

### Do not make the homepage a news billboard

The primary job is helping patients and caregivers accomplish important tasks.

### Do not overuse carousels

Stable, visible content is better for accessibility and decision-making.

### Do not hide important information behind animation

Users should not have to wait for a slide.

---

### Long-Term Vision

### What this site should become

The opportunity is much bigger than “a better nonprofit website.”

All Things PG can become a **patient-facing PG information and care-navigation platform**.

The site could eventually provide:

```text
Learn
    trusted PG information

Find Care
    providers
    clinics
    telehealth
    clinical trials

Live With PG
    practical resources
    caregivers
    emotional support
    appointment preparation

Community
    support groups
    PFAC
    patient stories

Research
    surveys
    studies
    publications
    clinical trials

Advocacy
    awareness
    policy
    events

Resources
    searchable library

Directory
    clinics
    experts
    organizations
```

That is the scalable product architecture.

---

# Final Verdict

### Is All Things PG a good website?

**It is a good and worthwhile website with a solid foundation, but it is not yet a best-in-class modern patient-support website.**

The positive side is important:

- The purpose is clear.
- The organization looks real and accountable.
- The primary PG topics exist.
- The site has real community resources.
- The clinic finder is strategically excellent.
- The organization exposes its people and mission.
- The donation/survey/newsletter infrastructure exists.
- The site uses generally clean and understandable URLs.

The weaknesses are also clear:

- The information architecture is more organization-centric than task-centric.
- The homepage has too many competing messages.
- The carousel/promo model is not ideal for accessibility or patient task completion.
- The apparent heading hierarchy needs correction.
- Link labels such as repeated “Read more” are weaker than they need to be.
- Search/discovery is underdeveloped.
- The clinic finder needs to be treated as a real product with a scalable data model.
- The multilingual controls are misleading unless the translations are actually available.
- The contact form creates unnecessary friction.
- Third-party services create a fragmented experience unless wrapped carefully.
- Content types, review dates, and governance need to be formalized before the site gets much larger.
- Accessibility needs a dedicated WCAG 2.2 AA program.
- Performance should be measured rather than guessed.
- SEO should add stronger metadata and structured data.

### The single most important recommendation

Do not start with a visual redesign.

Start with:

> **“What are the 5–7 things a patient, caregiver, clinician, researcher, or donor is actually trying to accomplish here?”**

Then rebuild the navigation, homepage, content types, clinic finder, and related-content system around those tasks.

That change would make the site feel dramatically more modern even before the colors, fonts, graphics, or page layouts changed.

### The second most important recommendation

Treat the **Clinic Finder as a product**, not a page.

It is the feature with the strongest potential to make All Things PG uniquely useful. A well-designed, verified, searchable PG provider directory would give the site a lasting practical advantage that a generic information website cannot provide.

### The third most important recommendation

Build the site so that growth makes it better instead of making it harder to manage.

That means:

**structured content + reusable templates + search + filters + metadata + review dates + analytics + accessibility + automated QA.**

That is the foundation for the next 5 years of the organization.

---

# Audit Evidence / Pages Reviewed

### All Things PG pages

- Home — https://www.allthingspg.org/
- What is PG? — https://www.allthingspg.org/what-is-pg
- PG Symptoms — https://www.allthingspg.org/pg-symptoms
- PG Causes — https://www.allthingspg.org/pg-causes
- Diagnosis of PG — https://www.allthingspg.org/diagnosis-of-pg
- Treatment of PG — https://www.allthingspg.org/treatment-of-pg
- Associated Health Issues — https://www.allthingspg.org/associated-health-issues
- Take the PG Survey — https://www.allthingspg.org/take-the-pg-survey
- Talking About PG — https://www.allthingspg.org/talking-about-pg
- How to Identify PG — https://www.allthingspg.org/how-to-identify-pg
- Rare Disease Affiliates — https://www.allthingspg.org/rare-disease-affiliates
- News & Events — https://www.allthingspg.org/news-and-events
- Our People — https://www.allthingspg.org/our-people
- Clinic Finder — https://www.allthingspg.org/pyoderma-gangrenosum-clinic-finder
- Mission — https://www.allthingspg.org/mission-statement
- Contact — https://www.allthingspg.org/contact
- Subscribe — https://www.allthingspg.org/subscribe
- Donate — https://www.allthingspg.org/donate
- Industry Partners — https://www.allthingspg.org/industry-partners
- PFAC — https://www.allthingspg.org/pfac
- Data & Privacy — https://www.allthingspg.org/data-and-privacy
- First PFAC Meeting in Michigan — https://www.allthingspg.org/first-pfac-meeting-in-michigan
- July 2026 Newsletter — https://www.allthingspg.org/1-yr-anniversary-celebration-newsletter
- First Year Anniversary Celebration — https://www.allthingspg.org/anniversary-celebration
- Individual board/member profiles, including:
  - https://www.allthingspg.org/dave-depottie
  - https://www.allthingspg.org/dr-alex-ortega-loayza
  - https://www.allthingspg.org/corlis-watkins-nass
  - https://www.allthingspg.org/lasaunia-thompson
  - https://www.allthingspg.org/gina-castelli

### External services observed

- Qualtrics/OHSU survey — https://ohsu.ca1.qualtrics.com/jfe/form/SV_1Rgun9506UbVoEe
- Givebutter donation flow — linked from https://www.allthingspg.org/donate
- Constant Contact signup — linked from https://www.allthingspg.org/subscribe and PFAC
- YouTube video — linked from News & Events

---

### Standards and Reference Sites

### Accessibility

- W3C WCAG 2.2 — https://www.w3.org/TR/WCAG22/
- W3C WCAG 2.2 Quick Reference — https://www.w3.org/WAI/WCAG22/quickref/
- W3C Forms Tutorial — https://www.w3.org/WAI/tutorials/forms/
- W3C Form Labels — https://www.w3.org/WAI/tutorials/forms/labels/
- W3C Accessibility First Review — https://www.w3.org/WAI/test-evaluate/preliminary/

### Usability

- Nielsen Norman Group — 10 Usability Heuristics — https://www.nngroup.com/articles/ten-usability-heuristics/

### Performance

- web.dev Core Web Vitals — https://web.dev/articles/vitals

### Search / SEO

- Google Search — Mobile-first indexing best practices — https://developers.google.com/search/docs/crawling-indexing/mobile/mobile-sites-mobile-first-indexing
- Google Search — Title links — https://developers.google.com/search/docs/appearance/title-link
- Google Search — Organization structured data — https://developers.google.com/search/docs/appearance/structured-data/organization
- Google Search — Crawl troubleshooting — https://developers.google.com/search/docs/crawling-indexing/troubleshoot-crawling-errors

### Comparison sites

- National Organization for Rare Disorders resource library — https://rarediseases.org/resource-library/
- NORD “How NORD Can Help” — https://rarediseases.org/living-with-a-rare-disease/how-nord-can-help/
- Crohn’s & Colitis Foundation — https://www.crohnscolitisfoundation.org/
- Crohn’s & Colitis IBD Journey — https://www.crohnscolitisfoundation.org/patientsandcaregivers/ibdjourney
- National Psoriasis Foundation — https://www.psoriasis.org/
- NPF Patient Navigation Center — https://www.psoriasis.org/navigationcenter/
- Mayo Clinic PG information — https://www.mayoclinic.org/diseases-conditions/pyoderma-gangrenosum/symptoms-causes/syc-20350386
- Mayo Clinic PG diagnosis/treatment — https://www.mayoclinic.org/diseases-conditions/pyoderma-gangrenosum/diagnosis-treatment/drc-20350392

---

### Bottom Line

### If the organization does nothing

The current site will continue to be useful, but as content, providers, events, resources, translations, partners, and programs grow, the navigation and maintenance burden will increase.

### If the organization makes the recommended changes

All Things PG could become a much stronger destination:

- easier for a newly diagnosed patient
- easier for a caregiver
- easier for a clinician
- easier for researchers and advocates
- more accessible
- easier to search
- easier to maintain
- more trustworthy
- more scalable
- more useful on mobile
- more measurable
- more defensible as a long-term patient resource

**The site does not need to be thrown away. It needs to evolve from a good information website into a well-structured patient-service platform.**

