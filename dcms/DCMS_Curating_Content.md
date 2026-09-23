---
layout: page
title: Curating Content
breadcrumb: DCMS > Curating Content
description: Workflow for collecting, reviewing, and publishing structured content.
updated: 2026-09-18
---

# DCMS - Curating Content

## Curating Content

The content model is designed to make All Things PG easier to grow, update, and maintain over time.

The purpose is not just to store text. It is to create a sustainable workflow for collecting, shaping, reviewing, and publishing content in a way that supports the organization’s mission.

---

## 1. What content curation means in DCMS

In DCMS, curated content is structured content that can be assembled into pages and reused across the site.

That means the organization can:

- store content in the database;
- separate content from presentation;
- support more than one content format;
- reuse content across pages where appropriate;
- update content without reworking the entire site.

This is a much better fit for a growing information platform than hard-coding important content directly into page files.

---

## 2. The current migration approach

For the POC and migration work, content is being captured into:

- `MigrationDocument`
- `MigrationElement`

Those tables provide a practical staging area for first-pass content capture from the legacy site.

The migration model is intentionally simple:

- one document per page or major content unit;
- one or more elements per document;
- HTML can be stored directly when that is the fastest useful representation;
- later passes can refine structure, images, metadata, and page relationships.

This is enough to move quickly without making the system more complicated than it needs to be.

---

## 3. Why the migration layer is useful

The migration layer gives the organization flexibility.

It allows the team to:

- capture content ahead of time;
- review it before publishing;
- rerun the migration later if the source changes;
- refine titles, mappings, and layout decisions as the site evolves;
- keep the final content tables clean.

That makes the migration process safer and easier to manage.

---

## 4. How content is expected to flow

The general flow is:

1. capture legacy content into migration tables;
2. map the content to the intended `MenuItem`;
3. refine the HTML or block structure as needed;
4. move approved content into the final content model;
5. render the content through the page system.

For the POC, the process can stay lightweight and practical. The goal is to get useful content into the site quickly and correctly.

---

## 5. Why the site needs content curation, not just content storage

A page is not valuable because it exists in a database. It is valuable because it is understandable, useful, and easy to maintain.

That is why curation matters.

Good curation helps the organization:

- present content in the right order;
- keep content aligned with the audience;
- avoid duplicates and dead ends;
- separate core informational pages from supporting material;
- make future updates much easier.

This is especially important for a rare-disease organization, where the value of the site comes from clarity and trust.

---

## 6. What can be improved later

The first pass does not need to be perfect.

Later improvements can include:

- richer metadata;
- image handling;
- content status and review notes;
- content versioning;
- page-level migration tracking;
- better element-level structure;
- better mapping between old and new titles;
- more precise treatment of forms, lists, and special pages.

That staged approach is deliberate. It lets the team get useful content in place first and refine it as needed.

---

## 7. Why this is a strong foundation

The content curation model is strong because it supports both speed and control.

It lets the organization:

- work quickly when needed;
- preserve important content;
- improve the structure over time;
- keep the site maintainable;
- prepare for future growth without rethinking the entire system.

For a sponsor, that means the platform is not just a one-time build. It is an asset that can continue to improve.

---

## Summary

Content curation in DCMS is about building a reliable path from legacy content to a maintainable platform.

The migration tables give the organization a safe staging area, the content tables give it a durable destination, and the page system gives it a way to present the content clearly to the right audience.
