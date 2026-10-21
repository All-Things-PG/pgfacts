---
layout: page
title: Selecting a User Experience
nav_label: User Experience
breadcrumb: User Experience > Selecting a User Experience
description: Let visitors choose the path that best fits their purpose.
permalink: /user-experience/selecting-a-user-experience/
---

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

.poc-screenshot-frame h3 {
  flex: none;
  margin: 0;
  text-align: center;
  font-size: 1rem;
  line-height: 1.3;
}

.poc-screenshot-frame img {
  display: block;
  max-width: 100%;
  width: auto;
  height: auto;
  object-fit: contain;
}

@media (max-width: 600px) {
  .poc-screenshot-frame {
    width: 100%;
  }
}
</style>


# Selecting a User Experience

Visitors arrive with different goals. Letting someone choose an experience is a simple way to help the site emphasize a useful starting page and navigation path.

The POC presents Patient, Caregiver, Provider, Pharmaceutical, and Guest as choices. A visitor may identify with more than one audience; the choice should be understood as “what kind of information would help me right now?” rather than a permanent label.

<div class="poc-screenshot-frame">
  <h3>Experience Selector</h3>
  <img src="/assets/images/poc-experience-selector.png" alt="The POC offers visitor-experience choices and displays the current selection.">
</div>

This example shows the experience selector set to Caregiver while the Welcome menu also offers Patient, Caregiver, Provider, Pharma, and Guest paths. It illustrates that the visitor can see which experience is active and reach other paths from the site navigation.

### Keep the choice understandable

The labels should use words visitors recognize. The page should make it clear that visitors can change the choice if another path better fits what they need. The default Guest experience can provide a general entry point for people who have not chosen an audience.

The selector is a navigation preference. It should not be described as a login, a statement of someone’s diagnosis, proof of professional status, or consent to share personal information.

### Menus can reflect the choice

In the POC, the menu under “Being a Patient” differs from the menu under “Being a Provider.” A caregiver path has its own emphasis as well. This gives visitors a more focused menu while the site retains its shared identity and broader topic structure.

<div class="poc-screenshot-frame">
  <h3>Patient Menu</h3>
  <img src="/assets/images/poc-patient-menu.png" alt="Patient navigation in the POC includes patient-focused topics.">
</div>

<div class="poc-screenshot-frame">
  <h3>Provider Menu</h3>
  <img src="/assets/images/poc-provider-menu.png" alt="Provider navigation in the POC includes clinical and research-oriented topics.">
</div>

<div class="poc-screenshot-frame">
  <h3>Caregiver Menu</h3>
  <img src="/assets/images/poc-caregiver-menu.png" alt="Caregiver navigation in the POC emphasizes the caregiver journey and support.">
</div>

These menu labels and sample destinations illustrate the concept. They should be reviewed as content and requirements develop; a screenshot alone does not establish that every item is complete or approved.

### Design questions for the finished experience

- Should the visitor’s selection persist when they move between pages or return later?
- How should shared topics appear in more than one experience?
- When the same subject needs different audience-specific content, how should the site make that distinction clear?
- What should happen when a visitor follows a link intended for another audience?
- How should the experience selector work on small screens and for keyboard and screen-reader users?

These are product and usability decisions for the finished site. The POC establishes a useful pattern to evaluate; it does not answer all of them.
