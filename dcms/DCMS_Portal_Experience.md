---
layout: page
title: What is a Portal?
breadcrumb: User Experience > What is a Portal?
description: Distinct starting points and tailored experiences for each audience.
updated: 2026-09-18
---

# DCMS - Portal Experience

## Portal Experience Overview

The portal experience is how All Things PG gives each audience a distinct and meaningful starting point.

Patients, caregivers, providers, and pharmaceutical visitors should not feel like they are all entering the same generic page. They should feel that the site recognizes why they are here.

The portal layer is how the system delivers that feeling.

---

## 1. What a portal is for

A portal should:

- immediately tell the visitor they are in the right place;
- reflect the tone and priorities of that audience;
- highlight the most important actions first;
- keep the site easy to navigate;
- feel intentionally designed rather than assembled generically;
- remain maintainable as the content grows.

In practice, the portal is the first meaningful step inside the audience-specific experience.

---

## 2. Why portals matter

The portal is valuable because it lets the site speak differently to different people without breaking the overall brand.

That matters for All Things PG because each audience comes with different needs:

- patients want clarity and reassurance;
- caregivers want practical help and empathy;
- providers want concise clinical context;
- pharmaceutical visitors want structured, research-oriented material.

The portal is the place where those differences start to show.

---

## 3. Current implementation shape

The current POC uses a layered design:

- `PageBase` loads shared page context;
- `PortalBase` loads portal-specific data and rules;
- `_Layout.cshtml` provides the site shell;
- `_PortalCommon.cshtml` renders the shared portal title and tile strip;
- `Patient`, `Caregiver`, `Provider`, `Pharmaceutical`, and `Default` pages add audience-specific content.

That structure keeps the application understandable:

- **base class** for behavior;
- **partial** for shared portal chrome;
- **page** for audience-specific content.

---

## 4. What is shared

Each portal shares:

- the site header and footer;
- the common portal title area;
- the portal tile bar;
- the visitor context;
- the same underlying layout system.

That shared structure is important. It makes the portal feel like part of one site, not four unrelated sites.

---

## 5. What can vary

Each portal can still vary in meaningful ways:

- accent colors;
- spacing and density;
- tile arrangement;
- page copy;
- emphasis sections;
- supporting content;
- future audience-specific modules.

The goal is controlled variation, not chaos.

---

## 6. Portal styling strategy

The portal architecture should support different visual treatments for each audience without rewriting the whole page.

A good pattern is:

- shared shell for structure;
- portal-specific classes for styling;
- shared tile rendering with different data;
- page-specific content below the common portal chrome.

That gives the site a consistent foundation while still letting each audience feel distinct.

---

## 7. Portal content strategy

Portal pages should be data-driven where it matters most.

The portal tile bar comes from `PortalMenu`, which gives the system a clean, repeatable way to manage audience navigation.

Additional portal sections can be:

- data-driven when they benefit from reuse;
- page-specific when the layout needs special treatment;
- mixed when the best result is a combination of both.

That keeps the design practical.

---

## 8. Why this is a strong design choice

The portal model is valuable because it balances consistency and individuality.

It allows the site to:

- stay recognizable across audiences;
- support different tones and priorities;
- avoid duplicating the entire site for every persona;
- keep the implementation manageable;
- leave room for future growth.

That is a good tradeoff for a small organization building a serious public resource.

---

## 9. Future evolution

The portal framework can later support:

- portal dashboards;
- audience-specific quick links;
- richer content modules;
- filters and search;
- theme variations;
- analytics;
- more refined landing-page structures.

The important thing is that the foundation is already pointing in that direction.

---

## Summary

The portal experience is not just decoration. It is a way to make the site feel relevant and intentional to each visitor.

The current design gives All Things PG a shared structure with room for audience-specific presentation, which is exactly the right balance for the POC and a strong foundation for the future.
