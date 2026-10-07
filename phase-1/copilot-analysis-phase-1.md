---
layout: page
title: Copilot Analysis
nav_label: Phase 1
description: How Copilot was used to support the work.
permalink: /phase-1/copilot-analysis/
---
# Copilot Analysis

**Website reviewed:** https://www.allthingspg.org/<br>
**Review date:** October 2026<br>
**Primary focus:** usability and scalability<br>
**Secondary focus:** content quality as it affects the target audience, modern web standards, and areas for improvement<br>

### Instructions to create the report

***I need an in-depth analysis of our website www.allthingspg.org The focus should be on usability and scalability, not so much on content itself, although it should be helpful information to the target audience. I'm interested to know - is it a good web site or not, and areas for improvement. it can be as detailed as you like, as long as you long. Examine as many pages as you can, identify faults, compare to modern websites and standards, and make recommendations for improvement. Save the report as a .md file, using #, ### headers.***

## Executive Summary

www.allthingspg.org is a small nonprofit website built to support patients and caregivers affected by Pyoderma Gangrenosum (PG), a rare and painful skin disease. The content is a genuine strength: the site explains an obscure, frightening medical condition in plain, compassionate language, offers a real self-service tool (a provider Clinic Finder), and runs several active community and research programs — a Patient & Family Advisory Committee (PFAC), a patient survey, an industry-partner program, and a rare-disease affiliate network.

As a piece of software, the site behaves like a simple brochure built page by page rather than a modern content system. There is no on-site search, no filtering or categorization anywhere, and every program (PFAC, survey, clinic finder, news) lives as a handful of disconnected pages rather than a connected journey. Several small but telling defects — a password published in plain text, duplicated page titles, repeated typos, and run-together text with missing spaces — suggest a publishing process with no proofing or quality-control step. None of this makes the site unusable today, but it does mean the site is not yet built to absorb growth gracefully: more providers, more events, more trials, more languages, and more partners will each require manually building more one-off pages rather than filling in a structured template.

**Is it a good website?** Yes, in the sense that it is honest, readable, and functional for a visitor who already knows what they're looking for. No, in the sense that it is not yet a modern, scalable platform: it is missing most of the content-management and discovery capabilities — search, filtering, structured data, audience-specific pathways — that comparable health-nonprofit sites increasingly offer, and the gap will widen as the organization's programs mature.

### Scorecard

<table class="topic-table">
<tr><th scope="col">Area</th><th scope="col">Assessment</th></tr>
<tr><td>Mission clarity</td><td>Strong — the homepage states its purpose in one sentence.</td></tr>
<tr><td>Core medical education content</td><td>Strong — plain-language, reassuring, well organized by topic.</td></tr>
<tr><td>Clinic Finder (concept)</td><td>Strong idea, underdeveloped execution and data model.</td></tr>
<tr><td>Homepage focus</td><td>Weak — too many competing calls to action with no clear "start here" path.</td></tr>
<tr><td>Navigation structure</td><td>Adequate but organization-centric rather than built around what a visitor is trying to do.</td></tr>
<tr><td>Search and content discovery</td><td>Missing entirely.</td></tr>
<tr><td>Forms and interaction design</td><td>Functional but has avoidable friction and a missing sensitive-data warning.</td></tr>
<tr><td>Content scalability (data model)</td><td>Weak — no evidence of structured, reusable content types.</td></tr>
<tr><td>Editorial governance / consistency</td><td>Weak — typos, run-together text, and duplicated titles recur across pages.</td></tr>
<tr><td>Accessibility</td><td>Unverified from this review method, but several observable patterns (repeated vague link text, a password posted in plain view) are worth a dedicated audit.</td></tr>
<tr><td>Internationalization</td><td>Questionable — a five-language switcher is advertised but could not be confirmed to produce translated content.</td></tr>
<tr><td>Third-party integration clarity</td><td>Adequate — external tools are used reasonably but are not clearly distinguished from the main site.</td></tr>
</table>

---

## 1. Methodology and Limitations

This review was conducted by retrieving and reading the publicly available text of each page listed in the appendix, following the site's own navigation and internal links as far as they could be followed. It did not include:

- a rendered, in-browser view of the site (so exact colors, layout, animation, and visual contrast could not be directly observed);
- inspection of the underlying page source code (so heading-tag levels, alt-text values, ARIA attributes, and other DOM-level details could not be confirmed);
- a Core Web Vitals / Lighthouse-style performance test;
- a keyboard-only or screen-reader walkthrough;
- access to `robots.txt` or `sitemap.xml`, which could not be retrieved during this review.

Where a conclusion depends on one of these unavailable checks, it is explicitly flagged below as "recommended to verify" rather than stated as a confirmed defect. Everything else in this report is drawn directly from the text, links, and structure actually observed on the site's public pages.

---

## 2. What the Site Already Does Well

Before getting into problems, it's worth being specific about the real assets already in place, because they are the foundation any improvement plan should build on rather than replace:

- A clear, one-sentence mission statement repeated consistently across the site.
- A complete educational core: What is PG, Symptoms, Causes, Diagnosis, Treatment, and Associated Health Issues, plus two "living with it" pages (How to Identify PG, Talking About PG).
- A working interactive Clinic Finder — a genuinely valuable, rare feature for a disease this obscure.
- An active research and community program: a patient/caregiver survey, a recurring Patient & Family Advisory Committee with real agendas and multiple time-zone options, and a rare-disease affiliate network (Global Skin, the Hidradenitis Suppurativa Foundation, NORD).
- A transparent, named leadership team with individual bios.
- A functioning donation pathway and an industry-partner outreach page with a direct contact address.
- A written data and privacy statement.

This is a strong base of raw material. The issues described below are almost entirely about structure, consistency, and discoverability — not about a lack of substance.

---

## 3. Homepage Assessment

### What works

The homepage opens with an unambiguous identity statement — "All Things PG: A Pyoderma Gangrenosum Community connecting patients and caregivers" — and gets a visitor to the Clinic Finder, the patient survey, and the newsletter signup within the first screen or two. That is a reasonable set of priorities for an organization that is equal parts information source, service provider, and community hub.

### What doesn't work

The homepage asks a visitor to care about a lot of things at once. In the content pulled from the page, the newsletter signup appears twice ("Sign up for email updates... Subscribe Here" and again later as "Sign up for updates"), the PG Survey is promoted twice ("Your answers help doctors and researchers find better treatments" near the top, and again as "Take the PG Survey" further down), and the page also surfaces an anniversary newsletter callout, a "5 Reasons Why Your Support Matters" sponsor-facing section, and a patient-story video link — all before a first-time visitor has been told what to do first. None of these individual elements is bad, but together they read as a list of promotions rather than a guided path, and a newly diagnosed visitor — plausibly scared, in pain, or exhausted — is left to figure out on their own which of six or seven competing messages applies to them.

### Recommendation

Reduce the homepage to one clear first action per audience, something like:

```text
I think I may have PG → What is PG? / How to Identify PG
I have been diagnosed → Treatment / Living with PG
I'm looking for a doctor → Clinic Finder
I want to help research → Take the Survey
```

Everything else (the newsletter, the anniversary post, the sponsor pitch) can remain on the page, but one level down in visual priority.

---

## 4. Information Architecture and Navigation

### Current structure

The global navigation is short and persistent across every page tested: Home, About PG (a dropdown of six medical topic pages), News & Events, About Us (Our People, Mission Statement, Clinic Finder), Contact Us, Donate. A second "Living with PG" group (How to Identify PG, Talking About PG) is repeated in the footer of every page.

This structure is organized around the organization's internal categories — "About PG," "About Us" — rather than around what a visitor is actually trying to do. A newly diagnosed patient does not think in terms of "I should check the About Us section"; they think "I was just diagnosed, what do I do now?" Several comparable rare-disease and chronic-condition nonprofits solve this by leading with a short set of "who are you / where are you in your journey" entry points (for example, "I'm newly diagnosed," "I'm a caregiver," "I'm a clinician") rather than a menu of organizational topics.

### A more task-oriented structure to consider

```text
Learn About PG        (What is PG, Symptoms, Causes, Diagnosis, Treatment, Associated Issues)
Find Care             (Clinic Finder, preparing for an appointment, questions to ask a doctor)
Living With PG        (Identifying PG, Talking About PG, caregiver resources, emotional support)
Get Involved           (Survey, PFAC, Advocacy, Industry Partners)
News & Events
About Us               (Mission, Our People, Rare Disease Affiliates, Contact, Privacy)
Donate
```

This is not about adding menu items — it's about grouping the content that already exists around a visitor's likely goal rather than around the organization's internal structure.

### Wayfinding: no breadcrumbs, no search

Nothing in the pages reviewed exposes a breadcrumb trail (e.g., "Home > Learn About PG > Diagnosis") or an on-site search box. At the site's current size this is survivable, since the menu alone can cover a dozen or so pages. It will not scale: once the News & Events archive, the clinic directory, and the rare-disease affiliate list each grow past a few dozen entries, a visitor's only way to find something will be to already know which menu item it lives under.

---

## 5. Content Clarity and Page Structure

A dedicated technical audit (which this review could not perform, since it did not have access to the page source) should confirm that every page uses a single, correctly-leveled main heading followed by a logical sequence of subheadings, since inconsistent heading levels are a common defect on template-driven sites and directly affect both screen-reader navigation and search-engine understanding of a page's main topic. That check should be treated as a "verify, don't assume" item rather than something this review can confirm either way.

What can be said from the visible content itself: each About PG topic page (What is PG, Symptoms, Causes, Diagnosis, Treatment, Associated Health Issues) is organized clearly within itself — short intro, a plain-language explanation, then a bulleted breakdown — and that internal clarity is a genuine strength. The weakness is between pages, not within them: there is no "next step" link connecting, say, the Diagnosis page to the Clinic Finder, or the Symptoms page to How to Identify PG, even though a reader's natural next question after one almost always leads to the next.

### Recommendation

Add a short "What to read next" block at the bottom of every educational page, linking to the two or three most logical next pages in a patient's likely journey (for example: Diagnosis → Find a Clinic → Treatment).

---

## 6. Link Text Quality

The News & Events index repeats the link label "Read more" after every single entry — eleven times in the version reviewed, once per post, with no variation. For a sighted visitor scanning the page this is a minor style choice; for anyone using assistive technology that lets them jump between links or pull up a list of links on the page, eleven identical "Read more" entries convey no information about which link goes where. The same pattern should be checked throughout the site; it was most clearly visible on the News & Events page.

### Recommendation

Make the visible label specific — "Read about the November PFAC meeting," "Read the July 2026 newsletter" — or, if the shorter visual label needs to stay for design reasons, give the link a more descriptive accessible name so that assistive technology announces the specific destination rather than a generic "read more."

---

## 7. Accessibility Considerations

Accessibility deserves particular weight on this site given its audience: people living with a painful, disfiguring, often misdiagnosed condition, frequently dealing with fatigue, pain, or the cognitive load of a new diagnosis, and caregivers who may be older or managing their own health constraints alongside someone else's. A health-information nonprofit serving this population should treat accessibility as a core requirement, not an afterthought.

From this review, direct confirmation of several standard accessibility checks was not possible (color contrast ratios, keyboard focus behavior, screen-reader output, and touch-target sizing all require a hands-on or automated browser-based test). Those should be treated as open items requiring a dedicated accessibility pass, ideally against the WCAG 2.2 AA standard, which is the current baseline most actively maintained nonprofit and healthcare sites are expected to meet.

What can be noted from the content itself:

- The repeated, non-descriptive "Read more" links (Section 6) are a real, text-visible accessibility concern, not merely a style preference.
- The contact form's required fields are discussed in Section 8 — requiring a phone number alongside name, email, and message adds friction that disproportionately affects people managing a difficult health situation.
- A password for an event recording is published in plain text on a public page (Section 14) — not strictly an accessibility issue, but a basic content-hygiene one that a review process should have caught.

### Recommendation

Commission a dedicated accessibility audit (automated scan plus a manual keyboard and screen-reader pass) against WCAG 2.2 AA, prioritizing color contrast, link text, form labeling, and focus visibility.

---

## 8. Forms and Interaction Design

### Contact form

The Contact Us page presents four fields, each prefixed with an asterisk in the retrieved text: "Your Name," "Your email address," "Your phone number," and "Your interest, message or question." If the asterisk convention is being used consistently, this suggests all four fields — including phone number — are being treated as required. For a general-purpose "get in touch" form, requiring a phone number alongside an already-required email address adds friction without an obvious reason, and is worth reviewing: either make phone optional, or state why it's needed.

More importantly, the open-ended "interest, message or question" field invites exactly the kind of detailed health disclosure (symptoms, treatment history, photos of wounds) that a basic contact form and the site's current privacy statement are not built to handle. The published Data and Privacy Statement is scoped specifically to "newsletter signup" and does not address message-form content at all.

### Recommendation

- Review whether phone number needs to be a required field; if not, mark it optional.
- Add a short, visible note above the message field asking visitors not to include sensitive medical details, photos, or prescription information in the form, and point them to a more appropriate channel if they need to share that kind of information.
- Expand the Data and Privacy Statement to cover contact-form submissions specifically, not only newsletter signups.

### Newsletter signup

The Subscribe page is sparse: "Sign up for updates! Get news from All Things PG in your inbox," followed immediately by "Click here to sign up if you're unable to complete the form above." That phrasing strongly suggests the actual signup form is an embedded third-party widget that didn't render in this review's text extraction, with a fallback link for people whose browser or screen reader can't use the embed. That is a reasonable safety net, but it's also a sign that the primary signup experience depends entirely on a third-party form's accessibility and reliability, with no first-party fallback description of what subscribing involves or what happens next.

### Recommendation

Add plain-language text next to the embedded form describing what a subscriber will receive and how often, plus a visible privacy-statement link immediately next to the form (not just in the footer).

---

## 9. Survey Experience

The Take the PG Survey page does a good job of setting expectations before sending someone to the external form: it explains who can take the survey (patients and caregivers), what topics it covers (onset, diagnosis journey, other health issues, treatments, daily life, feelings and support, and willingness to join future research), and why it matters. This is one of the better-structured pages on the site.

What's missing is practical, logistical detail that reduces hesitation before clicking through to an external survey tool: how long it takes, whether responses are anonymous, who administers it, and what happens to the data afterward. Since the survey itself is hosted on a third-party platform, setting these expectations on the All Things PG side — before the visitor leaves the site — matters more, not less.

### Recommendation

Add a short line or two covering estimated time to complete, anonymity/confidentiality, and the survey's sponsor/administrator, directly above the "Take The Survey Now" button.

---

## 10. Clinic Finder — The Site's Most Important Feature

The Clinic Finder is described as "an interactive, searchable map to locate clinics across the United States that evaluate and treat PG," with results sortable by provider name or clinic name and a state-by-state filter list. For a visitor whose single biggest obstacle is finding a doctor who has ever heard of this disease, this tool solves the actual problem better than any amount of educational text could — it is the strongest, most strategically important feature on the entire site.

Because the interactive map and search layer did not render in this review's text-based retrieval, the finer details of its current search and filter behavior could not be directly confirmed and should be tested hands-on (ideally on both desktop and mobile). Based on what is described on the page, a few scalability questions are worth raising regardless of how the current interface tests:

- Is each clinic/provider stored as a reusable, structured record (name, address, specialty, telehealth availability, last-verified date), or as free-standing page content? A structured record is what allows the tool to support filtering (by distance, specialty, telehealth availability) and to scale past a few dozen entries without becoming unmanageable.
- Is there a visible "last verified" date on each listing? A clinic directory is only as trustworthy as its freshness, and provider information (especially willingness to see PG patients) changes over time.
- Is there a simple way for a visitor or a clinic to report an out-of-date listing?

### Recommendation

Treat the Clinic Finder as a product in its own right, not a static page: give it a structured, reusable data model behind the scenes (so one provider can be linked to multiple clinic locations without duplicating data), add a visible "last verified" date to every listing, and provide a simple "report an update" path. This single feature, done well, is the site's biggest opportunity for differentiation — a generic information page is replaceable; a trustworthy, current, specialist-provider directory for a rare disease is not.

---

## 11. Data Model and Content Scalability

This is the most important structural question for the organization's future, independent of any single page's design.

### What the evidence suggests

Every observable signal — the fact that each news item, event, and board bio is its own standalone page; the complete absence of search, tags, filters, or sorting anywhere on the site; and the identical, manually-repeated footer and navigation block on every single page — points toward a site built as a series of individually authored pages rather than one built on reusable, structured content types. In a structured system, a "type" of content (an Event, a Clinical Trial listing, a Clinic record, a Partner organization) is defined once with a fixed set of fields, and the system automatically generates listing pages, detail pages, and any sorting/filtering from that definition. Nothing observed on this site behaves that way.

### Why it matters

- **Every new item is a new, fully custom page.** A new board member, a new event, a new partner organization, or a future "Clinical Trials" directory each appears to require building an entirely new standalone page from scratch and manually linking it from an index — rather than filling in a short form and letting the system generate the page.
- **The News & Events feed already mixes several different content types** — newsletters, meeting announcements, press features, a clinical-trial update, and patient-story features — in one flat list with no way to separate them. That is a direct symptom of there being no underlying content "type" distinguishing a newsletter from an event from a news item.
- **Consistency depends entirely on whoever is typing the page.** Because nothing enforces a shared template, small errors are free to repeat — see Section 14 for specific, observed examples.
- **Programs are currently built as one-off pages rather than as structured, growing collections.** PFAC, for instance, is a single page with one agenda and one set of meeting times; as the committee holds more meetings over time, each one will likely need its own separate page (as has already happened — see the "First PFAC Meeting in Michigan" and "November PFAC" posts in the News archive) rather than appearing as new entries under one living PFAC program page.

### Recommendation

Before adding any large new list-like feature (a clinical trials directory, an expanded multi-location clinic database, additional partner logos), define it as a structured content type with a fixed set of fields, even if the current platform requires that to be done manually at first. The News & Events section and the Clinic Finder are the two most urgent candidates, since they are already large enough to show the strain.

---

## 12. News & Events Architecture

The News & Events index currently lists eleven distinct items spanning from a December 2018 press feature up through a virtual meeting described as happening "yesterday" relative to this review, and it mixes several genuinely different kinds of content in one undifferentiated, reverse-chronological list: newsletters, PFAC meeting announcements, a podcast feature, a clinical-trial update (a Phase 3 trial for Spesolimab), a patient-story feature, and a general "Welcome" post. A visitor who wants only upcoming meetings, or only clinical-trial news, currently has to scan past everything else to find it.

### Recommendation

At minimum, add simple category labels (Newsletter, Event, Clinical Trial, Press, Patient Story) so visitors can scan or filter the existing list by type, even before any larger platform change. Longer-term, give events a lifecycle — upcoming, happening now, recording available, archived — so that past events age out of the primary view automatically instead of accumulating indefinitely in one flat list.

---

## 13. Editorial Governance and Consistency

Several small, independently verifiable defects point to the same underlying gap: there is no proofreading or quality-control step between writing a page and publishing it.

- **A misspelling reused across multiple pages.** The phrase "fullfilling our mission" (missing a space-correct double-l spelling of "fulfilling") appears, misspelled identically, on more than one page — strong evidence that a single paragraph of boilerplate text was copy-pasted without being checked.
- **A city name misspelled in a live event listing.** The News & Events index describes an event as the "First PFAC Meeting in Kalamzoo Michigan" — Kalamazoo is misspelled, in a listing that is likely to be found by search engines and shared externally.
- **Run-together text with missing spaces on the PFAC page.** The live PFAC page currently reads, verbatim: "Two time options are available to make this meetingaccessible to as many aspossible.Please use theQRCode orlink to select options" — multiple words are fused together with no space, which reads as a copy-paste or formatting error that was never caught before publishing.
- **Duplicated page titles.** Most pages reviewed render their own title twice: once as the visible heading at the top, and again, alone, as the very last line of the page (for example, the Contact Us page ends with a lone "Contact Us" after the footer). This is consistent with a template quirk rather than a deliberate choice, but it has shipped unnoticed across virtually every page on the site.
- **A password published in plain text.** One event recording page includes the line "Use this password to watch video: 8KVu4&Z&" directly in the visible page text — visible to any visitor, and to any search engine that indexes the page, which defeats the purpose of gating the content behind a password at all.

None of these individual issues is severe on its own, but together they show a consistent pattern: nothing in the current publishing process catches small errors before they go live and stay live.

### Recommendation

Introduce a short, repeatable pre-publish checklist for any new or edited page — a spell-check pass, a read-through for run-together text, a check that no credentials or access codes are visible in the page body, and a final look at whether the page title renders correctly once and only once.

---

## 14. Trust and Medical Authority Signals

This review deliberately did not evaluate the accuracy of the medical content itself, since that was not the requested focus — but the structure around medical content strongly affects how much a reader trusts it, independent of whether it's correct. Pages like What is PG, Diagnosis of PG, and Treatment of PG currently present information without any visible attribution: no "medically reviewed by," no last-reviewed date, and no listed sources. Comparable medical-information sites (hospital systems, major disease foundations) typically pair plain-language content with small, visible trust signals — who reviewed it and when — precisely because that combination is what lets a reader trust patient-friendly language without needing to independently verify it.

### Recommendation

Add a small, consistent line at the bottom of each core medical page: "Medically reviewed by [name/credential], last reviewed [month/year]." Given the organization's own Medical Director is already listed on the Our People page, this should be straightforward to add without changing the friendly tone of the writing itself.

---

## 15. Audience Segmentation

The site currently serves several distinct audiences through one undifferentiated structure: patients, caregivers, clinicians, researchers, industry partners/donors, and fellow rare-disease organizations. Evidence of this breadth is visible across the Industry Partners page (aimed at sponsors), the PFAC page (aimed at patients, caregivers, providers, and researchers together), and the core educational pages (aimed at patients and caregivers). All of these are reached through the same general navigation, with nothing near the top of the site helping a visitor self-identify and jump to the content most relevant to them.

### Recommendation

A short, simple set of entry points near the top of the homepage — "I have PG," "I care for someone with PG," "I'm a healthcare provider," "I'm a researcher or industry partner" — would let each audience skip directly to their most relevant content instead of parsing the full menu to find it.

---

## 16. Footer Strategy

The footer is functionally consistent (it repeats the same About PG and Living with PG links, plus the Data and Privacy link, on every page) but underused as an opportunity for secondary navigation. On a legal page like Data and Privacy, the same dense link block that makes sense on a content page adds unnecessary visual weight to a page that would normally want to stay short and focused.

### Recommendation

Reorganize the footer into labeled columns (Learn, Get Help, Get Involved, About, Legal) so it functions as a genuine secondary navigation aid rather than a repeated block of the same links, and consider trimming it on pages — like Data and Privacy — where a long link list isn't the priority.

---

## 17. Language Support

A language switcher listing English, Spanish, French, Italian, and German was observed in at least one page's footer area, but it did not appear consistently across every page tested, and this review could not confirm that selecting a non-English option actually produces translated page content rather than returning to the English homepage. If the translations aren't fully live, advertising five languages risks frustrating exactly the non-English-speaking caregivers it's meant to help.

### Recommendation

Verify, page by page, whether each language option produces genuinely translated content. If full translation isn't realistic soon, either limit the advertised languages to what's actually translated, or prioritize translating a small, high-value subset first (What is PG, Symptoms, Diagnosis, Treatment, Find a Clinic, Contact) rather than implying full-site coverage that may not exist yet.

---

## 18. Privacy and Data Handling

The published Data and Privacy Statement is narrowly scoped: it describes what happens to a name and email address collected through newsletter signup, and nothing else. In practice, the site's broader ecosystem already includes a contact form, a third-party survey tool, and (per the Donate and Subscribe pages) likely at least one other third-party service for payments and email delivery. None of those other data flows are addressed in the current privacy statement.

### Recommendation

Expand the Data and Privacy Statement to describe, even briefly, each place personal information is collected on or through the site (contact form, newsletter, survey, donation), not only the newsletter signup flow it currently covers.

---

## 19. Third-Party Dependencies

Based on the pages reviewed, the site relies on at least one external survey platform (for the PG Survey) and appears to rely on an embedded third-party widget for newsletter signup (inferred from the "unable to complete the form above" fallback language on the Subscribe page), in addition to whatever processor handles donations. This is entirely normal for a small nonprofit, but none of these transitions are clearly flagged to the visitor as leaving the All Things PG site, which can make it harder for a visitor to know whether they can still trust the page they're looking at, or to know where to go for support if something goes wrong on the external form.

### Recommendation

Add a small, consistent visual or text cue ("opens an external survey," "donate securely via [processor]") wherever a visitor is about to leave the main site, so the transition is expected rather than surprising.

---

## 20. Performance Considerations

This review could not run a lab-based performance test (such as Lighthouse or PageSpeed Insights) and is not able to report Core Web Vitals figures (loading speed, responsiveness, or visual stability) with any confidence — any specific number would be invented. What can be said is that the pages retrieved during this review were text-heavy and image-light based on their content, which is generally favorable for load speed; the bigger performance risk is more likely to come from whichever third-party embeds power the newsletter signup, survey redirect, and clinic-finder map, since third-party scripts are consistently the most common source of slow-loading or janky nonprofit websites.

### Recommendation

Run an actual Core Web Vitals test (Google's PageSpeed Insights is free and requires no special access) on the homepage, the Clinic Finder, and one educational page, and treat any third-party embed that noticeably slows the page as a candidate for lazy-loading or deferred loading.

---

## 21. SEO Foundation

### What's already working

The site uses clean, descriptive URLs throughout — `/what-is-pg`, `/pg-symptoms`, `/diagnosis-of-pg`, `/pyoderma-gangrenosum-clinic-finder` — which is good, durable SEO practice and suggests the underlying platform at least gets this one fundamental right.

### What to check

This review could not confirm whether each page has a unique, descriptive `<title>` tag and meta description distinct from its visible on-page heading (that requires page-source access this review did not have), nor could it confirm whether structured data (schema.org markup for the organization, for events, or for articles) is present. Given that page titles appear to repeat as plain visible text at both the top and bottom of each page (Section 13), it's worth specifically checking whether the actual `<title>` tag used by search engines is similarly duplicated or generic.

### Recommendation

Audit each page's `<title>` tag and meta description for uniqueness and clarity, and consider adding basic structured data for the organization, for PFAC/News events, and for the Our People profiles, which can improve how the site is represented in search results without requiring any visual redesign.

---

## 22. Crawlability and Indexing

This review attempted to retrieve the site's `robots.txt` and `sitemap.xml` files and was unable to access either during this session. That is not proof that they don't exist — only that this review could not confirm their presence or contents.

### Recommendation

Directly verify that `robots.txt` and `sitemap.xml` exist, are correctly configured, and are submitted to Google Search Console, since a missing or misconfigured sitemap can quietly limit how much of a growing site actually gets indexed.

---

## 23. Mobile Experience

This review was conducted through text retrieval rather than a rendered browser session, so actual mobile layout, touch-target sizing, and responsive breakpoints could not be directly observed or tested. Given that the Clinic Finder in particular is the kind of tool someone might reasonably use from a phone (in a waiting room, while traveling, while helping a family member), it is one of the highest-priority features to test specifically on a phone, independent of how well the rest of the site performs on mobile.

### Recommendation

Manually test the site on at least one phone and one tablet, with particular attention to the Clinic Finder's map/list interaction, the contact and newsletter forms, and the main navigation menu.

---

## 24. Calls to Action

The site's calls to action — subscribe, take the survey, find a clinic, donate — are repeated frequently (the homepage alone surfaces the newsletter signup and the survey twice each), but mostly without being tailored to the specific page they appear on. A generic "sign up for updates" prompt at the bottom of the Treatment of PG page is a missed opportunity compared to something like "Find a PG-experienced provider to discuss these treatment options," which connects directly to what the reader was just reading about.

### Recommendation

Replace generic, repeated calls to action with ones tailored to each page's specific content — connect the Diagnosis page to the Clinic Finder, the Treatment page to wound-care resources, and the Talking About PG page to community/support resources, rather than defaulting to the newsletter signup everywhere.

---

## 25. Program Pages: Our People, Industry Partners, Rare Disease Affiliates, PFAC

- **Our People** is a genuine strength: six named board members with roles and bios, which is unusually transparent for an organization this size. As the board or staff grows, this would benefit from being a structured list (name, role, short bio, credentials) rather than continued hand-built narrative pages, so future additions don't each require a fully custom page.
- **Industry Partners** currently reads as a persuasive essay (five numbered reasons to support the organization) rather than a structured partner directory. That's appropriate while there are few or no partners listed yet, but it will need to become a real structured list — organization name, logo, partnership level, link — once actual partners are added, rather than a single page that has to be manually edited every time a sponsor changes.
- **Rare Disease Affiliates** currently lists three partner organizations (Global Skin, the Hidradenitis Suppurativa Foundation, and NORD) as plain text links. This is a good, simple start; as the list grows, even a basic card layout with a one-line description of each organization's relevance would make the page more useful than a plain link list.
- **PFAC** is a strong program (a real agenda, an "Ask the Expert" panel, and multiple time-zone options for a global audience) presented as a single static page rather than a standing program. As already happened once (the "First PFAC Meeting in Michigan" and "November PFAC" posts each live as separate News items), each new PFAC session currently seems to require its own News post rather than appearing as a dated entry under one permanent, continuously-updated PFAC program page.

### Recommendation

Give PFAC a permanent program page (what it is, who it's for, how to join, upcoming session, past session archive) and treat individual meetings as entries within that page rather than as separate, disconnected News posts.

---

## 26. Donation Experience

The Donate page is short, clear, and emotionally direct, with a single obvious "Donate Now" call to action. What it lacks is any visible donor-trust content — no mention of how funds are used, no link to a financial summary or annual report, and no secondary ways to contribute (volunteering, sharing information, participating in research) for visitors who are willing to help but not ready to give money.

### Recommendation

Add two or three lines on how donations are used, and consider listing non-monetary ways to help (volunteer, share, participate in the survey or PFAC) alongside the donate button.

---

## 27. Scalability: What Will Likely Break First

Ranked by how soon each is likely to become a real problem if the organization keeps growing at its current pace:

1. **The Clinic Finder's underlying data.** Provider and clinic information changes over time (retirements, new locations, changed availability); without a structured record and a "last verified" process, this list will quietly go stale.
2. **News & Events.** Already mixing five or more content types in one flat list at just eleven entries; this will become meaningfully harder to scan at twenty-five or fifty.
3. **Language support.** Five advertised languages imply an ongoing translation commitment well beyond what a single-language site requires; if that commitment isn't sustained, the feature actively misleads visitors rather than helping them.
4. **Program pages (PFAC, Industry Partners, Rare Disease Affiliates).** Each is currently a single static page; none will scale gracefully past a handful of entries without becoming either unreadably long or needing a real list structure.
5. **Editorial consistency.** Each new hand-built page is another opportunity for the same kind of typo, run-together text, or duplicated-title defect already found on multiple existing pages.

---

## 28. Comparison to Modern Standards

<table class="topic-table">
<tr><th scope="col">Modern expectation</th><th scope="col">Status on allthingspg.org</th></tr>
<tr><td>Clear mission communicated immediately</td><td>Met.</td></tr>
<tr><td>Clean, descriptive URLs</td><td>Met.</td></tr>
<tr><td>On-site search</td><td>Missing.</td></tr>
<tr><td>Content filtering/categorization (news, events, resources)</td><td>Missing.</td></tr>
<tr><td>Structured, reusable content types behind the scenes</td><td>No evidence of this; appears to be page-by-page authoring throughout.</td></tr>
<tr><td>Audience-specific entry points ("I am a...")</td><td>Missing — navigation is organized around the organization, not the visitor's situation.</td></tr>
<tr><td>Descriptive link text</td><td>Not met — repeated generic "Read more" links on the News & Events page.</td></tr>
<tr><td>Medical content trust signals (reviewed-by, last-reviewed date)</td><td>Missing from the core educational pages.</td></tr>
<tr><td>Donor transparency (fund use, financial summary)</td><td>Missing from the Donate page.</td></tr>
<tr><td>Accessibility conformance (WCAG 2.2 AA)</td><td>Not verifiable from this review method; recommend a dedicated audit.</td></tr>
<tr><td>Mobile responsiveness</td><td>Not verifiable from this review method; recommend manual testing, especially of the Clinic Finder.</td></tr>
<tr><td>Performance (Core Web Vitals)</td><td>Not verifiable from this review method; recommend a PageSpeed Insights test.</td></tr>
<tr><td>Verified crawlability (robots.txt, sitemap.xml)</td><td>Could not be confirmed during this review; recommend direct verification.</td></tr>
<tr><td>Editorial consistency / proofing process</td><td>Not met — multiple typos, a run-together text error, and duplicated page titles found across several pages.</td></tr>
<tr><td>No exposed credentials in public content</td><td>Not met — a plaintext access password was found on one event page.</td></tr>
</table>

---

## 29. Priority Recommendations

### Fix immediately (no platform change needed)

1. Remove the plaintext password published on the PFAC conference-recording page.
2. Correct the "fullfilling," "Kalamzoo," and PFAC page run-together text errors, and scan other pages for similar issues.
3. Remove the duplicated page-title text repeating at the bottom of every page, if the platform allows it.
4. Add a "do not share sensitive medical information" note to the Contact Us form, and review whether phone number needs to remain a required field.
5. Replace the repeated "Read more" links on News & Events with specific, descriptive link text.
6. Verify whether the language switcher actually produces translated content; adjust what's advertised if it doesn't.

### Medium-term (within the current platform)

7. Add basic category labels to the News & Events list (Newsletter, Event, Clinical Trial, Press, Patient Story).
8. Add a "medically reviewed by / last reviewed" line to the core educational pages.
9. Give PFAC a permanent, standing program page instead of treating each session as a separate News post.
10. Add tailored, page-specific calls to action in place of the repeated generic newsletter prompt.
11. Add a short donor-trust section and non-monetary ways to help on the Donate page.
12. Expand the Data and Privacy Statement to cover the contact form, survey, and donation data flows, not just the newsletter.

### Longer-term (structural)

13. Move the Clinic Finder to a structured, reusable data model with a visible "last verified" date and an update-request path.
14. Evaluate a database-backed content platform for News & Events, the Clinic Finder, and any future resource directory, so that new entries can be added as structured data rather than hand-built pages.
15. Reorganize the top-level navigation around visitor tasks (Learn, Find Care, Living With PG, Get Involved) rather than organizational categories.
16. Commission a dedicated accessibility audit against WCAG 2.2 AA and a Core Web Vitals performance test, since neither could be completed in this review.
17. Add structured data (schema.org) for the organization, events, and articles to strengthen search-engine understanding of the site.

---

## 30. Final Verdict

**Is this a good website?** For a volunteer-run, rare-disease nonprofit, yes — it is honest, compassionate, and functionally adequate for a visitor who already knows what they're looking for, and it contains a genuinely strong core of medical content plus one standout feature (the Clinic Finder) that few comparable organizations can match. **Is it a modern, scalable website?** Not yet. It is missing nearly every capability that lets a content-heavy nonprofit site grow without the work multiplying by hand — search, filtering, structured data, audience-specific pathways — and it carries a set of small, concrete, fixable defects (an exposed password, duplicated titles, repeated typos, missing donor transparency) that reflect the absence of a proofing or quality-control step in how new pages get published.

The right next step is not a cosmetic redesign. It's deciding, deliberately, what a visitor is actually trying to accomplish on each part of the site — find a doctor, understand a diagnosis, join a support community, help research move forward — and then building the navigation, the Clinic Finder, and the News & Events section around those tasks, with structured, reusable content behind each one. That single shift would make the site meaningfully more capable of growth even before anything about its visual design changes.

---

## Appendix: Pages Reviewed

<table class="topic-table">
<tr><th scope="col">Page</th><th scope="col">URL</th></tr>
<tr><td>Home</td><td>https://www.allthingspg.org/</td></tr>
<tr><td>Mission Statement</td><td>https://www.allthingspg.org/mission-statement</td></tr>
<tr><td>Our People</td><td>https://www.allthingspg.org/our-people</td></tr>
<tr><td>What is PG?</td><td>https://www.allthingspg.org/what-is-pg</td></tr>
<tr><td>PG Causes</td><td>https://www.allthingspg.org/pg-causes</td></tr>
<tr><td>PG Symptoms</td><td>https://www.allthingspg.org/pg-symptoms</td></tr>
<tr><td>Diagnosis of PG</td><td>https://www.allthingspg.org/diagnosis-of-pg</td></tr>
<tr><td>Treatment of PG</td><td>https://www.allthingspg.org/treatment-of-pg</td></tr>
<tr><td>Associated Health Issues</td><td>https://www.allthingspg.org/associated-health-issues</td></tr>
<tr><td>How to Identify PG</td><td>https://www.allthingspg.org/how-to-identify-pg</td></tr>
<tr><td>Talking About PG</td><td>https://www.allthingspg.org/talking-about-pg</td></tr>
<tr><td>Take the PG Survey</td><td>https://www.allthingspg.org/take-the-pg-survey</td></tr>
<tr><td>Subscribe for Updates</td><td>https://www.allthingspg.org/subscribe</td></tr>
<tr><td>Clinic Finder</td><td>https://www.allthingspg.org/pyoderma-gangrenosum-clinic-finder</td></tr>
<tr><td>Industry Partners</td><td>https://www.allthingspg.org/industry-partners</td></tr>
<tr><td>PFAC</td><td>https://www.allthingspg.org/pfac</td></tr>
<tr><td>Rare Disease Affiliates</td><td>https://www.allthingspg.org/rare-disease-affiliates</td></tr>
<tr><td>News & Events (index)</td><td>https://www.allthingspg.org/news-and-events</td></tr>
<tr><td>First PFAC Meeting in Michigan</td><td>https://www.allthingspg.org/first-pfac-meeting-in-michigan</td></tr>
<tr><td>First Year Anniversary Celebration</td><td>https://www.allthingspg.org/anniversary-celebration</td></tr>
<tr><td>July 2026 Newsletter</td><td>https://www.allthingspg.org/1-yr-anniversary-celebration-newsletter</td></tr>
<tr><td>Welcome to All Things PG</td><td>https://www.allthingspg.org/welcome-to-all-things-pg</td></tr>
<tr><td>Contact Us</td><td>https://www.allthingspg.org/contact</td></tr>
<tr><td>Donate</td><td>https://www.allthingspg.org/donate</td></tr>
<tr><td>Data and Privacy Statement</td><td>https://www.allthingspg.org/data-and-privacy</td></tr>
<tr><td>Board bio example (Corlis Watkins-Nass)</td><td>https://www.allthingspg.org/corlis-watkins-nass</td></tr>
</table>

*This review was conducted by retrieving publicly available page text. It did not include direct inspection of page source code, a rendered browser session, a lab-based performance test, or any authenticated/admin view of the site's content system. Items that specifically require one of those methods — exact heading-tag levels, color contrast ratios, Core Web Vitals scores, keyboard/screen-reader behavior, and `robots.txt`/`sitemap.xml` contents — are flagged throughout as unverified and recommended for a dedicated follow-up check, rather than stated as confirmed findings.*
