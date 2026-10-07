# All Things PG Website Analysis — Phase 1

**Site reviewed:** www.allthingspg.org
**Review date:** October 3, 2026
**Pages reviewed:** Home, Mission Statement, Our People, What is PG, PG Symptoms, How to Identify PG, Talking About PG, Clinic Finder, News & Events (index + 7 individual articles/events), Contact Us, Donate, Data and Privacy — 17+ unique URLs in total.

---

## 1. Executive Summary

All Things PG is a small, text-driven nonprofit website serving the Pyoderma Gangrenosum (PG) patient and caregiver community. It is a static site — every page is an independently generated document with no underlying database — hosted on AWS.

The site succeeds at its most basic job: it clearly explains what PG is, who the organization is, and how to get involved (clinic finder, survey, newsletter, donate). It is readable, free of intrusive ads, and loads simple content reliably. At the same time, it shows the typical limitations of a purely static, page-by-page architecture: a flat and undifferentiated News & Events feed, no on-site search or content filtering, repeated/duplicated page-title text, at least one real security/privacy lapse (a plaintext access password posted directly on a public page), and a visual design that structural signals suggest is simple and utilitarian rather than modern.

The organization is clearly accomplishing the *core* of its mission — awareness, education, community-building, and advocacy — through a combination of static informational pages and a few genuinely useful interactive tools (the clinic finder map, the newsletter signup, the patient survey). The site is less well suited to any content that behaves like a **growing, structured list** — recurring events, multiple news items, directories, or categorized resources — because the underlying architecture treats every piece of content as its own standalone page rather than a record in a reusable template.

---

## 2. Discovering the Site's Intent

### 2.1 Stated mission

The site states its mission directly and consistently across the homepage and a dedicated Mission Statement page, and the same language also appears, close to verbatim, inside at least one news post — suggesting a single boilerplate paragraph is being reused as the organization's "elevator pitch":

> "All Things PG is dedicated to improving the lives of those affected by Pyoderma Gangrenosum (PG) by connecting them with trusted resources and organizations for help. We strive to empower patients, caregivers and medical professionals through knowledge, advocacy, and raising PG awareness."
> — *Mission Statement page*

The homepage reinforces this with a plain identity statement: "All Things PG: A Pyoderma Gangrenosum Community connecting patients and caregivers" and "All Things PG is a patient organization for Pyoderma Gangrenosum" (Home page).

### 2.2 The four pillars the site is organized around

The homepage breaks the mission into four concrete pillars, each with its own supporting paragraph:

<table class="topic-table">
<tr><th>Pillar</th><th>What the site says it does</th></tr>
<tr>
<td><b>Amplifying Patient Voices</b></td>
<td>"With a broad network of patients and caregivers who are engaged in discussions and willing to share their stories, All Things PG plays a crucial role in advocacy by ensuring that the voices of those affected by PG are heard by researchers, healthcare providers, and policymakers."</td>
</tr>
<tr>
<td><b>Driving Progress Through Research</b></td>
<td>"All Things PG contributes to research by collecting patient experience data, supporting publications, and creating a 'research ready' community for upcoming clinical trials."</td>
</tr>
<tr>
<td><b>Fostering Community and Support</b></td>
<td>"A key part of All Things PG is to connect patients with support groups and resources to address the practical needs and emotional well-being of patients and caregivers."</td>
</tr>
<tr>
<td><b>Enhancing Collaboration and Advocacy</b></td>
<td>"Grants and sponsorships enable virtual and in-person meetups and workshops that strengthen our PG advocacy network and foster collaboration among patients, caregivers, and healthcare professionals."</td>
</tr>
</table>

(Quoted from the homepage's "What We Do to Support the PG Community" section.)

### 2.3 What the site is actually built to *do*, mechanically

Stripped of mission language, the site functions as five things glued together under one navigation bar:

1. **An educational reference library** about PG (What is PG, Symptoms, Causes, Diagnosis, Treatment, Associated Health Issues, How to Identify PG, Talking About PG).
2. **A directory tool** — the Clinic Finder, an interactive map for locating PG-treating providers by state.
3. **A blog-style news feed** — one page per article/event, listed newest-first on a single index page.
4. **A lightweight engagement funnel** — email signup ("Subscribe Here"), a patient survey link, and a Contact Us form.
5. **A fundraising page** — Donate, with a direct call-to-action link.

### 2.4 Does the site accomplish the mission objectives?

<table class="topic-table">
<tr><th>Mission pillar</th><th>Evidence the site delivers on it</th><th>Gaps observed</th></tr>
<tr>
<td>Education / Awareness</td>
<td>Deep, well-organized clinical content: "Pyoderma Gangrenosum (PG) is a rare cause of skin ulcers that belongs to a group of conditions called neutrophilic dermatoses. These conditions happen when a type of white blood cell, called a neutrophil, builds up in the skin and causes inflammation." (<i>What is PG?</i> page) Supporting pages cover symptoms, identification, and even how to talk about PG with doctors, family, and employers.</td>
<td>No search function to jump directly to a topic; content depth varies page to page; nothing indicates when medical content was last reviewed/updated.</td>
</tr>
<tr>
<td>Research-readiness / clinical trial engagement</td>
<td>A standing PG Survey ("Take the PG Survey") and at least one clinical-trial news post (Phase 3 Spesolimab trial).</td>
<td>There is no standing, structured directory of open trials — trial information currently surfaces only as individual, one-off news posts rather than a browsable, filterable list.</td>
</tr>
<tr>
<td>Community / support</td>
<td>PFAC (Patient and Family Advisory Committee) meetings are being run and documented — e.g. the <i>First PFAC Meeting in Michigan</i> post, described as "a milestone made possible by the hard work and dedication of the Board of Directors and the generous support from the PG community that we serve" — plus a "Join a Support group" pointer on the Talking About PG page.</td>
<td>No visible way to actually find or join a support group from the site itself (it tells visitors to do it but doesn't link out to one); events live only as one-off posts with no calendar or RSVP mechanism.</td>
</tr>
<tr>
<td>Advocacy / provider connections</td>
<td>The Clinic Finder is a genuinely useful, modern-feeling tool — "Because Pyoderma Gangrenosum (PG) is rare and often misdiagnosed, getting to a clinic that knows PG can make a real difference. Use our interactive, searchable map to locate clinics across the United States that evaluate and treat PG." (<i>Clinic Finder</i> page)</td>
<td>It's the one piece of real interactivity on the whole site — a sign the organization already recognizes the value of tools beyond plain text pages.</td>
</tr>
<tr>
<td>Fundraising</td>
<td>Clear, short donate page with a direct call to action.</td>
<td>No transparency content (annual report, financials, or impact numbers) to help a prospective donor decide — a common trust-building gap for small nonprofits.</td>
</tr>
</table>

**Bottom line:** the organization is substantively meeting its mission on the awareness/education/advocacy side, where static text pages are a perfectly adequate medium. It is less equipped for the research/clinical-trial and dynamic-events side of the mission, where visitors benefit from lists, filters, and search — capabilities that are harder to deliver when every page stands alone.

---

## 3. Site Map & Navigation (as discovered)

<table class="topic-table">
<tr><th>Section</th><th>Pages found</th></tr>
<tr>
<td>Primary nav</td>
<td>Home, About PG (dropdown), News & Events, About Us → Our People / Mission Statement, Contact Us, Donate</td>
</tr>
<tr>
<td>About PG dropdown</td>
<td>What is PG?, PG Symptoms, PG Causes, Diagnosis of PG, Treatment of PG, Associated Health Issues</td>
</tr>
<tr>
<td>"Living with PG" dropdown (footer-repeated)</td>
<td>How to Identify PG, Talking About PG</td>
</tr>
<tr>
<td>Tools</td>
<td>Pyoderma Gangrenosum Clinic Finder (interactive map), Take the PG Survey (external form)</td>
</tr>
<tr>
<td>News & Events (sample of articles found)</td>
<td>November PFAC (virtual meeting), Phase 3 Clinical Trial for Spesolimab, First PFAC Meeting in Michigan, July 2026 Newsletter, First Year Anniversary Celebration, Alimond Studio Podcast feature, Welcome to All Things PG, One Woman's Journey with PG, Take the PG Survey (announcement), First-ever PFAC virtual conference, "Doc Talk" news feature (2018)</td>
</tr>
<tr>
<td>People / Governance</td>
<td>Our People (Board bios: Medical Director, President, Chairman, Treasurer, Secretary, Board Member)</td>
</tr>
<tr>
<td>Legal / Trust</td>
<td>Data and Privacy Statement</td>
</tr>
<tr>
<td>Utility</td>
<td>Language selector appearing in at least one page footer area (English / Spanish / French / Italian / German) — not consistently visible across all pages tested</td>
</tr>
</table>

Observation: the About PG dropdown and "Living with PG" links are **duplicated in the footer of every single page**, including the Contact Us form, the Donate page, and even the Data and Privacy legal page. This is consistent with a single global footer template rather than a page-by-page navigation decision, but it does mean every page ends with an identical, fairly dense block of repeated links.

---

## 4. Usability & Design Review

### 4.1 What works well

- **Plain-language medical content.** Explanations like "The term comes from old medical language. 'Pyo' means pus, 'derma' means skin, and 'gangrenosum' refers to tissue breakdown" (<i>What is PG?</i> page) show real care in translating clinical terms for lay readers — exactly the audience a rare-disease nonprofit needs to reach.
- **Clear, short calls to action.** "Subscribe Here," "Donate Now," "Take the PG Survey," and "Find a PG Clinic Near You" all appear as direct, unambiguous links rather than vague labels.
- **The Clinic Finder** is a genuine standout: an interactive, searchable map with results sortable by Provider Name or Clinic Name, letting a visitor self-serve the one thing a rare-disease patient most urgently needs — a doctor who's heard of their condition.
- **Consistent branding tone** — "PG Warriors," community-first language, patient-story features (e.g., a podcast feature and "One Woman's Journey") — builds emotional connection, which matters for a support community.
- **No clutter.** There are no pop-up ads, no auto-playing video, and no aggressive dark patterns. For a health-information site, that restraint is a genuine design strength.

### 4.2 Usability and design concerns

- **Unverified color contrast and overall visual design.** This review was conducted through automated retrieval of page text and could not directly inspect live colors, imagery, or CSS. Health-information sites in particular are prone to contrast failures (e.g., light text on a bright accent-colored background), since that defect is easy to introduce and easy to miss without a formal check. **Recommendation:** run every template/page background-and-text color pairing through a contrast checker (e.g., the WebAIM Contrast Checker) as a standard accessibility pass, independent of whether any problem currently exists.
- **A visible plaintext password on a public page.** The "First-ever PFAC" event page includes the text: "Historic Virtual Conference!! Use this password to watch video: 8KVu4&Z&". Publishing an access password in plain text on a publicly indexed page defeats the purpose of password-protecting the content at all (search engines and anyone with the URL can read it). This is a minor-but-real security/privacy hygiene issue worth fixing wherever it recurs.
- **Repeated, duplicated page titles.** Nearly every page pulled renders its own title twice — once as the visible headline and once again as plain text at the very bottom of the page (e.g., "Contact Us" appears as a heading at the top and then again, alone, as the last line of the page). This reads as unpolished, duplicated content to both visitors and search engines.
- **Flat, undifferentiated News & Events feed.** All events, newsletters, press features, and clinical-trial announcements sit in one undifferentiated reverse-chronological list with no categories, tags, or filters. A visitor looking only for "clinical trials" or only for "upcoming meetings" has to scan everything.
- **No on-site search.** For a reference-heavy health information site, the absence of a search box is a meaningful gap — visitors must already know which navigation item holds the answer they want.
- **At least one content inconsistency reached production.** A repeated spelling slip ("fullfilling our mission") appears across more than one page, suggesting the same paragraph was reused without proofreading each time it was placed on a new page.
- **Mobile/responsive behavior could not be verified in this review.** Because the review relied on automated page fetches rather than a live browser, touch-target sizing, responsive breakpoints, and mobile menu behavior were not directly confirmed and should be spot-checked manually on a phone.
- **Visual design could not be independently assessed.** This report could not directly view colors, imagery, or layout polish. Structural signals — templated title repetition, identical footers on every page, and a lack of varied page layouts — suggest a simple, utilitarian visual style; a full design review would require direct, in-browser inspection.

---

## 5. Platform / CMS Assessment

### 5.1 How the site is built

The site is a static site: every page is an independently generated, standalone document with no underlying database, hosted on AWS. There is no access to the underlying page source for this review; the assessment below is based on observed behavior and structure (URL patterns, repeated boilerplate, and the absence of dynamic features such as search, filtering, or tagging).

### 5.2 What this architecture is good at

- **Simplicity and stability.** Static pages are fast to serve, cheap to host, and very hard to "break" compared with a dynamic CMS running plugins, a database, and server-side logic.
- **Low security surface area.** No database means no SQL-injection risk, no database to breach, and nothing to patch at that layer — a genuine security advantage over a typical database-backed CMS with plugins.
- **Predictable performance.** Static HTML generally loads quickly and consistently, with no server-side processing delay per page view.

### 5.3 What this architecture is less well suited for

- **Structured lists don't scale as structured lists.** Because there is no database, there is no way to define a reusable content type (for example, an "Event" or "Clinical Trial" record with fields like name, date, location, and link) and have the system automatically generate a listing page, a detail page, and filter/search behavior from that data. Every new list item instead has to be created as its own standalone page and then manually linked from an index page.
- **No tagging, filtering, or search is possible without structured data.** Categorization, sorting, and search all depend on queryable, structured fields. A static-page architecture has no concept of structured fields — only free-form pages — so these features cannot be added without a different underlying platform or an external tool layered on top.
- **Content consistency depends entirely on manual discipline.** Because each page is authored independently rather than drawn from a shared template with enforced fields, small inconsistencies — duplicated titles, repeated boilerplate, typos — are more likely to creep in over time, as observed above.
- **No visible workflow or version history.** Nothing in the reviewed pages indicates drafts, scheduled publishing, or rollback capability; this is typical of simple static-page systems and is worth confirming directly with whoever administers the site.

### 5.4 Does it meet modern standards?

<table class="topic-table">
<tr><th>Modern web standard</th><th>Status on this site</th></tr>
<tr>
<td>HTTPS / secure hosting</td>
<td>Site is served over HTTPS; AWS hosting is a solid, modern, reliable hosting choice.</td>
</tr>
<tr>
<td>Mobile responsiveness</td>
<td>Not independently verifiable in this review — recommend a manual phone check.</td>
</tr>
<tr>
<td>Accessibility (WCAG color contrast, alt text, semantic structure)</td>
<td>Not independently verifiable from text-only retrieval; recommend a full contrast and alt-text audit, since these are among the most commonly failed accessibility criteria on small nonprofit sites generally.</td>
</tr>
<tr>
<td>Structured/dynamic content (database-backed filtering, search, tagging)</td>
<td>Absent — the single biggest functional gap versus a typical modern nonprofit CMS.</td>
</tr>
<tr>
<td>Performance (static pages)</td>
<td>Static HTML typically performs very well; this is a genuine strength of the architecture.</td>
</tr>
<tr>
<td>SEO fundamentals (unique titles, clean URLs)</td>
<td>URLs are clean and descriptive (e.g., `/pyoderma-gangrenosum-clinic-finder`); duplicated title text at the top and bottom of each page is a minor SEO/readability blemish, not a functional SEO blocker.</td>
</tr>
<tr>
<td>Internationalization</td>
<td>A language switcher (English/Spanish/French/Italian/German) was observed on at least one page — a positive feature if it translates full page content site-wide, though completeness was not verified.</td>
</tr>
</table>

**Overall:** the platform meets modern standards for a static, brochure-style website (secure, fast, simple) but falls short of what's expected from a modern *content management system* — namely, structured/dynamic content, search, filtering, and templated content types. This is a reasonable foundation for primarily static, reference-style content, but it is the clear limiting factor for any content that behaves like a growing, repeating list.

---

## 6. Pros and Cons Summary

<table class="topic-table">
<tr><th>Pros</th><th>Cons</th></tr>
<tr>
<td>Static pages = fast, stable, low security risk</td>
<td>No database — every list-like section (events, news) is a collection of individually built pages</td>
</tr>
<tr>
<td>Clear, consistent mission messaging</td>
<td>No search, tags, or filters anywhere on the site</td>
</tr>
<tr>
<td>Genuinely useful Clinic Finder interactive tool</td>
<td>News & Events is one long, undifferentiated list</td>
</tr>
<tr>
<td>Clean, ad-free, distraction-free reading experience</td>
<td>Page titles duplicated at top and bottom of every page</td>
</tr>
<tr>
<td>Hosted on reliable, modern AWS infrastructure over HTTPS</td>
<td>At least one plaintext password published on a public page</td>
</tr>
<tr>
<td>Plain-language medical education content, well organized by topic</td>
<td>Color contrast and visual accessibility could not be verified and should be audited</td>
</tr>
<tr>
<td>Apparent multilingual support (EN/ES/FR/IT/DE)</td>
<td>No donor-facing transparency content (financials/impact) on the Donate page</td>
</tr>
<tr>
<td>Simple structure that is easy for a visitor to understand</td>
<td>No visible content workflow, drafts, or version history</td>
</tr>
</table>

---

## 7. Recommendations

### 7.1 Quick wins (no platform change required)

1. **Fix or remove the exposed plaintext password** on the PFAC conference replay page — replace with a request-access flow, or gate it behind the existing email-signup form.
2. **Run a sitewide color-contrast and accessibility audit** using a free tool (e.g., WebAIM Contrast Checker), covering every template and banner/button color combination, not just a sample.
3. **Clean up duplicated page-title echoes** at the bottom of each page if the underlying system allows editing or disabling that template slot.
4. **Proofread and de-duplicate the reused mission/anniversary paragraph** that currently contains a repeated typo across more than one page.
5. **Add a short donor-trust section to the Donate page** — even 2–3 lines on how funds are used, or a link to annual highlights, builds credibility without needing new tooling.
6. **Verify the language switcher** actually translates full page content, not just the navigation menu, before relying on it for non-English-speaking visitors.

### 7.2 Medium-term (content strategy within the current platform)

7. **Consolidate recurring content types into standing "hub" pages** (e.g., a single living "Clinical Trials" page and a single "Upcoming Events" page) that get updated in place, rather than creating an entirely new page for every item. This won't add filtering or search, but it reduces the number of separate pages that need to be created and linked.
8. **Adopt a consistent content template/checklist** (title, date, summary, body, call-to-action link) for anything new that gets published, to reduce inconsistency and typos over time.

### 7.3 Longer-term (platform-level)

9. **Evaluate a modern, database-backed CMS** (e.g., WordPress, Squarespace, Wix, or a nonprofit-specific platform) for the News/Events/Clinical Trials content in particular. These platforms let an organization define a content type once (e.g., "Clinical Trial": name, phase, sponsor, location, link, status) and get automatic listing, filtering, search, and detail pages from that single definition.
10. **Consider a hybrid approach before any full migration:** keep the current static platform for core mission/education pages (which function well as static content), while introducing a small, separate, structured tool — a simple no-code database, a spreadsheet-backed widget, or a lightweight custom page — specifically for growing lists such as clinical trials, events, or a provider directory, linked to or embedded from the main site. This captures much of the benefit of a modern CMS with far less disruption than a full re-platform.
11. **Whichever platform is used long-term, favor templated content types for anything that recurs** (events, trials, news), so that publishing a new item becomes a data-entry task rather than a page-design task.

---

## 8. Appendix: Pages Reviewed

<table class="topic-table">
<tr><th>Page</th><th>URL</th></tr>
<tr><td>Home</td><td>https://www.allthingspg.org/</td></tr>
<tr><td>Mission Statement</td><td>https://www.allthingspg.org/mission-statement</td></tr>
<tr><td>Our People</td><td>https://www.allthingspg.org/our-people</td></tr>
<tr><td>What is PG?</td><td>https://www.allthingspg.org/what-is-pg</td></tr>
<tr><td>PG Symptoms</td><td>https://www.allthingspg.org/pg-symptoms</td></tr>
<tr><td>How to Identify PG</td><td>https://www.allthingspg.org/how-to-identify-pg</td></tr>
<tr><td>Talking About PG</td><td>https://www.allthingspg.org/talking-about-pg</td></tr>
<tr><td>Clinic Finder</td><td>https://www.allthingspg.org/pyoderma-gangrenosum-clinic-finder</td></tr>
<tr><td>News & Events (index)</td><td>https://www.allthingspg.org/news-and-events</td></tr>
<tr><td>First PFAC Meeting in Michigan</td><td>https://www.allthingspg.org/first-pfac-meeting-in-michigan</td></tr>
<tr><td>First Year Anniversary Celebration</td><td>https://www.allthingspg.org/anniversary-celebration</td></tr>
<tr><td>July 2026 Newsletter</td><td>https://www.allthingspg.org/1-yr-anniversary-celebration-newsletter</td></tr>
<tr><td>Welcome to All Things PG</td><td>https://www.allthingspg.org/welcome-to-all-things-pg</td></tr>
<tr><td>Contact Us</td><td>https://www.allthingspg.org/contact</td></tr>
<tr><td>Donate</td><td>https://www.allthingspg.org/donate</td></tr>
<tr><td>Data and Privacy Statement</td><td>https://www.allthingspg.org/data-and-privacy</td></tr>
<tr><td>Board member bio example (Corlis Watkins-Nass)</td><td>https://www.allthingspg.org/corlis-watkins-nass</td></tr>
</table>

*This review was conducted via automated retrieval of publicly available page content. It did not include direct inspection of underlying page source, live browser rendering, or authenticated/admin views of the website's content system. Visual, color-contrast, and mobile-responsiveness observations are flagged throughout as unverified where applicable.*
