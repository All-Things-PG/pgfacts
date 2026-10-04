---
layout: page
title: Knowledge Base
nav_label: New Features in Phase 2
breadcrumb: New Features in Phase 2 > Knowledge Base
description: A structured, searchable collection of trusted PG information.
permalink: /new-features-in-phase-2/knowledge-base/
---

# Knowledge Base

The knowledge base is the primary feature of Phase 2.

It will be a searchable collection of trusted All Things PG information that helps visitors find what they need quickly, whether they are patients, caregivers, providers, or other users looking for curated guidance.

## Overview

DCMS gives us the structure to curate content and connect it to menu items, visitor types, and supporting metadata. The knowledge base builds on that foundation by turning published content into something searchable and discoverable.

The first proof of concept may not include the full search engine or database indexing layer, but the goal is clear: Phase 2 should evolve into a live, searchable knowledge base rather than a static set of pages.

## What the knowledge base can include

The knowledge base should grow beyond simple text pages and eventually include:

- curated articles and guidance
- patient stories and community content
- provider and clinic directory entries
- facilities and locations
- images and supporting graphics
- video and other media where useful
- reference material tied to specific menu items or topics

Each content type can be published through DCMS, then surfaced in a way that makes sense for the visitor and the topic.

## Why DCMS matters

DCMS lets us create menu items, content documents, and content elements in a controlled way. That means we can curate content instead of scattering it across separate static pages.

For the knowledge base, that is important because:

1. content can be organized by topic and audience
2. visibility can respect visitor type
3. search results can point users to the right menu item or document
4. content can be expanded over time without redesigning the whole site

## Dynamic menus and content

Dynamic menus and content are the layer that makes the knowledge base usable in the site itself.

The knowledge base does not live by search alone. It depends on a content model that can:

- attach content to menu items
- promote content into topic tiles
- organize pages by audience or purpose
- keep related material connected as the site grows

That is why the menu system matters so much. It is not just navigation. It is part of the structure that makes the knowledge base feel coherent instead of random.

## Provider directory

The provider directory is part of the knowledge base story, not a separate idea.

Right now it may be a manual list or a managed CMS entry set, but the long-term goal is to treat providers and related facilities as searchable reference data. That allows the site to grow into a practical directory as well as a documentation site.

## Searchable result set

When the search experience is built, the result set should do more than return a title. It should show enough information for a visitor to decide whether to click.

A result row could include:

- result type
- title
- short description or snippet
- associated menu item or topic
- route or link
- visitor type visibility
- relevance or ranking
- last updated date

That structure would work for content pages, providers, facilities, and other future knowledge base records.

## Example search questions

The same search experience should work for different visitors and intents.

### Caregiver

**Question:** What is the best approach to wound care?

The search should prioritize caregiver-oriented guidance, practical care instructions, and related education pages.

### Patient

**Question:** How can I cope with the pain?

The search should prioritize patient-facing content, coping strategies, symptom education, and related support resources.

### Drug company / researcher

**Question:** What research is being done for PG?

The search should prioritize research updates, clinical trials, scientific summaries, and other reference material.

## AI-assisted search suggestions

We can use AI to help interpret the visitor's question before search runs.

That does not replace the database search. It helps turn a natural-language question into useful search parameters such as:

- visitor type
- topic area
- content type
- likely synonyms
- relevance boosts

For example, an AI assistant could infer that:

- "best approach to wound care" may map to wound treatment, caregiver guidance, and clinical care
- "cope with the pain" may map to pain management, patient support, and symptom relief
- "research being done for PG" may map to clinical trials, studies, publications, and provider-facing research content

The AI should only help shape the search request. The actual search results should still come from the database and respect visibility rules.

## Mockup: search and results

```text
------------------------------------------------------------
Search All Things PG
------------------------------------------------------------
[ What are you looking for? ____________________________ ] [Search]

Suggested filters:
[Caregiver] [Patient] [Provider] [Drug Company] [Research]
[Articles] [Providers] [Facilities] [Drugs] [All]

Results
------------------------------------------------------------
1. Wound Care Basics for Caregivers
   Caregiver guidance for daily wound care, supplies, and red flags.
   Topic: User Experience > Caregivers
   Type: Article  |  Audience: Caregiver  |  Updated: 2026-10-04

2. Understanding and Managing Pain
   Information on pain control, coping strategies, and when to ask for help.
   Topic: User Experience > Patients
   Type: Article  |  Audience: Patient  |  Updated: 2026-10-04

3. Current PG Research and Clinical Trials
   Research updates, trial summaries, and scientific references related to PG.
   Topic: New Features > Knowledge Base
   Type: Research  |  Audience: Research  |  Updated: 2026-10-04

4. University of Utah Dermatology
   Provider directory entry for a PG-aware clinic and team.
   Topic: Database > Providers
   Type: Provider  |  Audience: Public  |  Updated: 2026-10-04
------------------------------------------------------------
```

## Search result expectations

The result set should support more than one content type while keeping the interface simple.

At minimum, each result should show:

- title
- short snippet
- type
- route or destination
- visible audience
- freshness or updated date

The page can later add highlighting, ranking, and facets, but the first goal is to return useful and safe results.

## Media and other formats

The knowledge base should not be limited to Markdown pages.

DCMS already gives us a way to describe content with format type, mime type, and content type, so the site can eventually support different kinds of media and curated records. That means the knowledge base can grow to include images, documents, and video when the Phase 2 model is ready for them.

## Phase 2 direction

The long-term direction is a live, searchable knowledge base that:

- is curated through DCMS
- respects visitor type
- includes the provider directory
- supports articles, stories, and reference material
- can be indexed and searched in the database
- gives visitors a guided way to explore All Things PG

That is the feature we want to sell for Phase 2.
