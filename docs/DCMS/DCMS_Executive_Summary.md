# DCMS - Dynamic Content and Menuing System

## Executive Summary

### 1. Vision & Purpose

The Dynamic Content and Menuing System (DCMS) delivers a persona-driven, database-backed platform designed specifically to meet the complex needs of the Pyoderma Gangrenosum (PG) community. 

Historically, patient platforms suffer from "one-size-fits-all" syndrome. A PG Patient requires gentle, empathetic wound-care guides and physical emotional journey tracking, whereas a Healthcare Provider requires technical, evidence-based guidelines, clinical trial registries, and peer-reviewed literature. Conversely, a Caregiver seeks supportive tools to empower a loved one.

By transitioning from static pages to a database-driven architecture, the DCMS accomplishes a critical, compassionate goal: **the absolute personalization of rare disease support, split across customized, distinct visitor portal homepages.**

---

### 2. Strategic Rationale: Transitioning from Phase 1 to Phase 2

All Things PG's Phase 1 website established a vital online presence for the community. However, as the organization grows, Phase 1's architecture presents severe dead-ends that restrict progress. By adopting Phase 2, the organization establishes a scalable, clinical-grade platform:

#### From Proprietary CMS to Complete Asset Ownership
*   **Phase 1 Limitation:** Operating entirely without a backend database. All patient directory tools, newsletter subscribers, and metrics are silod on third-party channels, meaning the non-profit doesn't own its most valuable data assets.
*   **Phase 2 Opportunity:** Owning a dedicated SQL Server database in Azure. Patient registrations, newsletter profiles, and clinical directories reside on-site, forming a secure foundation for growth.

#### Removing Maintenance Bottlenecks
*   **Phase 1 Limitation:** To edit content, update directories, or publish news, code edits and full redeployments are required. This creates an expensive, sluggish reliance on external CMS web developers.
*   **Phase 2 Opportunity:** Structured content types (Articles, News, Clinic Directories) are stored as decoupled database records. Non-technical staff can curate, edit, and publish stories instantly.

#### Empowering Searchability & Navigation
*   **Phase 1 Limitation:** Zero layout searchability or tagging exists. Navigation is flat and static, forcing patients to click manually through rigid groupings, often missing key resources.
*   **Phase 2 Opportunity:** Implementing site-wide search and dynamic taxonomy tagging. A visitor can instantly search keywords like "pain management" and get matching clinical, article, or community directory results.

#### Customized Persona Journeys
*   **Phase 1 Limitation:** All visitors see identical navigation links and pages regardless of whether they are a suffering patient or a clinician looking for medication approvals.
*   **Phase 2 Opportunity:** Menu content dynamically morphs according to the active user's persona (Patient, Caregiver, Provider, Pharma, Visitor) via clear database-driven `VisitorMask` rules and independent portal homepages.

---

### 3. Core System Objectives

To ensure disciplined, structured growth, Phase 2 implements a robust architecture across six small, specialized specs inside the solution:

1.  **`DCMS_Executive_Summary.md`**: Broad objectives, system vision, and business case justification.
2.  **`DCMS_Database_Schema.md`**: The master single-source of truth for table schemas, columns, data types, indexes, and initial mock datasets.
3.  **`DCMS_Dynamic_Menus.md`**: Standard hierarchies, caching strategies, active persona resolution contexts, and header rendering.
4.  **`DCMS_Dynamic_Routing.md`**: Clean routing rules, mapping logical `RouteType` to portal page views (using `RouteTarget`), and implementing the separate page portal model (`HomeBase`).
5.  **`DCMS_Dynamic_Content.md`**: Detailed Card Reader design, parsing layout behaviors via metadata JSON, and dispatching to CSS/MIME-specific Razor partials.
6.  **`DCMS_Curating_Content.md`**: Standardized workflow pipelines (Draft, Review, Published) and validation procedures for content creators.
		