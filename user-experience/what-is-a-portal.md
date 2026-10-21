---
layout: page
title: What is a Portal?
nav_label: User Experience
breadcrumb: User Experience > What is a Portal?
description: A role-aware starting point within one shared All Things PG site.
permalink: /user-experience/what-is-a-portal/
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


# What is a Portal?

A portal is a starting point organized around why someone came to All Things PG. It gives visitors a clearer route into the site without turning each visitor experience into a separate website.

For example, a patient may want plain-language information about PG, treatment, daily life, and support. A clinician may need concise clinical context, evidence, research, or links to further resources. Both may be interested in the same subject, but the most useful presentation can differ.

### A shared site with tailored paths

The portal pattern combines a common All Things PG identity and site structure with differences in the first page, menu, emphasis, and selected content. Visitors can start with Patient, Caregiver, Provider, Pharmaceutical, or Guest. The selected experience helps guide what they see first.

<div class="poc-screenshot-frame">
  <h3>Patient Portal</h3>
  <img src="/assets/images/poc-patient-portal.png" alt="The POC patient portal shows a patient-oriented landing page and experience selector.">
</div>

<div class="poc-screenshot-frame">
  <h3>Provider Portal</h3>
  <img src="/assets/images/poc-provider-portal.png" alt="The POC provider portal shows a clinical starting point with its own navigation.">
</div>

The portal does not have to duplicate every article for every audience. DCMS can associate menu items and content with visitor experiences so the site can present appropriate destinations and context. Where the same topic needs distinct patient and provider treatments, the system can route each path to the intended content.

### What the POC demonstrates

The POC shows the shared visual shell, visitor-experience selector, separate landing pages, and audience-specific menus. It makes the portal idea tangible and demonstrates that the experience can be shaped by visitor type.

The POC’s example text is intentionally limited. These screenshots document a working design pattern, not a finished set of patient or clinical materials, a complete requirements specification, or the final visual design.

### What a portal is not

Selecting Patient, Caregiver, Provider, Pharmaceutical, or Guest expresses the visitor’s preferred experience. It is not identity verification, a clinical credential check, or a security boundary. If a future feature needs restricted information, authentication and authorization must be designed separately.

### Connection to DCMS

Portals are the visitor-facing result of the DCMS content and menu model. The experience selector supplies visitor context; the menu and content relationships determine which paths and material are presented. See [Dynamic Menus](/dcms/dynamic-menus/) and [Dynamic Content](/dcms/dynamic-content/) for the system design behind that behavior.
