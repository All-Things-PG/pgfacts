---
layout: page
title: What is a Portal?
nav_label: User Experience
breadcrumb: User Experience > What is a Portal?
description: Five audience splash screens help visitors find a useful starting point on All Things PG.
permalink: /user-experience/what-is-a-portal/
---

<style>
.<a href="/welcome/glossary/" target="_blank" rel="noopener">portal</a>-intro {
  max-width: 58rem;
  margin: 0 auto 2rem;
  color: #34444d;
  font-size: 1.08rem;
  line-height: 1.65;
}

.portal-intro h2 { color: #d96500; }
.portal-hero {
  --hero-image: none;
  position: relative;
  isolation: isolate;
  display: grid;
  grid-template-columns: minmax(0, .9fr) minmax(0, 1.1fr);
  align-items: center;
  gap: clamp(1.5rem, 4vw, 4rem);
  box-sizing: border-box;
  min-height: 340px;
  margin: 1.5rem 0;
  padding: clamp(1.5rem, 5vw, 4rem);
  overflow: hidden;
  border: 1px solid #e5d8c8;
  border-radius: 14px;
  background: #f8f5ef;
  color: #26394a;
}
.portal-hero::before {
  position: absolute;
  z-index: -2;
  inset: 0;
  content: "";
  background-image: var(--hero-image);
  background-size: cover;
  background-position: center;
}
.portal-hero::after {
  position: absolute;
  z-index: -1;
  inset: 0;
  content: "";
  background: linear-gradient(90deg, rgba(250,248,242,.95) 0%, rgba(250,248,242,.88) 48%, rgba(250,248,242,.58) 100%);
}
.portal-hero--patient { --hero-image: url('/assets/images/caregiver-wheelchair-hero.png'); background-position: center 52%; }
.portal-hero--caregiver { --hero-image: url('/assets/images/caregiver-wheelchair-hero.png'); }
.portal-hero--provider { --hero-image: url('/assets/images/provider-exam-room-hero.png'); background-position: center 52%; }
.portal-hero--pharma { --hero-image: url('/assets/images/poc-provider-portal.png'); }
.portal-hero--guest { --hero-image: url('/assets/images/poc-home-visitor-experiences.png'); }
.portal-hero__intro h2 { margin: 0 0 .7rem; color: #a94d00; font-size: clamp(1.7rem, 3vw, 2.35rem); text-shadow: 0 1px 0 rgba(255,255,255,.45); }
.portal-hero__intro p { max-width: 34rem; margin: 0; font-size: 1.05rem; line-height: 1.6; }
.portal-hero__features { padding: 0; border: 0; border-radius: 0; background: transparent; box-shadow: none; }
.portal-hero__features h3 { margin: 0 0 .7rem; color: #a94d00; font-size: 1.15rem; }
.portal-hero__features ul { margin: 0; padding-left: 1.2rem; }
.portal-hero__features li { margin: .48rem 0; line-height: 1.45; }
.portal-hero--pharma::after { background: linear-gradient(90deg, rgba(250,248,242,.98) 0%, rgba(250,248,242,.94) 55%, rgba(250,248,242,.72) 100%); }
.portal-hero--guest::after { background: linear-gradient(90deg, rgba(250,248,242,.96) 0%, rgba(250,248,242,.88) 55%, rgba(250,248,242,.48) 100%); }
@media (max-width: 700px) {
  .portal-hero { grid-template-columns: 1fr; min-height: 0; gap: 1.25rem; padding: 1.25rem; }
  .portal-hero::after { background: rgba(250,248,242,.88); }
}
</style>

# What is a Portal?

<div class="portal-intro">
  <h2>A more helpful starting point</h2>
  <p>All Things PG serves people who come to the site with different questions and goals. These splash screens introduce five ways into the same shared site. Visitors can choose a path from the Welcome menu or change the active experience with the “Choose Your Experience” drop-down. Each splash screen pairs a short welcome with useful topics, helping visitors find a relevant place to begin.</p>
</div>

<section class="portal-hero portal-hero--patient" aria-labelledby="patient-splash-title">
  <div class="portal-hero__intro">
    <h2 id="patient-splash-title">Patient</h2>
    <p>Living with pyoderma gangrenosum can bring difficult questions at every stage. Start with clear information, explore options, and find support at a pace that feels right for you.</p>
  </div>
  <div class="portal-hero__features">
    <h3>Find a helpful next step</h3>
    <ul>
      <li>Understand PG, symptoms, and what to expect.</li>
      <li>Explore treatment options and practical wound care.</li>
      <li>Connect with patient stories, community, and support.</li>
    </ul>
  </div>
</section>

<section class="portal-hero portal-hero--caregiver" aria-labelledby="caregiver-splash-title">
  <div class="portal-hero__intro">
    <h2 id="caregiver-splash-title">Caregiver</h2>
    <p>Supporting someone with PG can mean helping with appointments, treatment, daily care, and uncertainty. Find practical guidance while making room for your own questions and wellbeing.</p>
  </div>
  <div class="portal-hero__features">
    <h3>Support for the journey</h3>
    <ul>
      <li>Prepare for appointments and care conversations.</li>
      <li>Find information about treatment and day-to-day support.</li>
      <li>Explore caregiver stories, community, and resources for yourself.</li>
    </ul>
  </div>
</section>

<section class="portal-hero portal-hero--provider" aria-labelledby="provider-splash-title">
  <div class="portal-hero__intro">
    <h2 id="provider-splash-title">Provider</h2>
    <p>Whether PG is familiar or new to your practice, find a focused starting point for clinical context, current evidence, and resources that support coordinated care.</p>
  </div>
  <div class="portal-hero__features">
    <h3>Clinical resources</h3>
    <ul>
      <li>Review diagnosis and treatment guidance.</li>
      <li>Find research, evidence, and clinical trial information.</li>
      <li>Explore professional resources and multidisciplinary care.</li>
    </ul>
  </div>
</section>

<section class="portal-hero portal-hero--pharma" aria-labelledby="pharma-splash-title">
  <div class="portal-hero__intro">
    <h2 id="pharma-splash-title">Pharmaceutical</h2>
    <p>Learn about the public work, research landscape, and patient perspectives shaping the PG community. This path helps industry visitors find relevant information and understand where to learn more.</p>
  </div>
  <div class="portal-hero__features">
    <h3>Research and collaboration</h3>
    <ul>
      <li>Learn about research priorities and unmet needs.</li>
      <li>Understand patient perspectives and educational efforts.</li>
      <li>Find public information about collaboration and next steps.</li>
    </ul>
  </div>
</section>

<section class="portal-hero portal-hero--guest" aria-labelledby="guest-splash-title">
  <div class="portal-hero__intro">
    <h2 id="guest-splash-title">Guest</h2>
    <p>New to All Things PG, or just looking around? Begin with a broad introduction to PG and the community, then choose a topic or audience path that fits what brought you here.</p>
  </div>
  <div class="portal-hero__features">
    <h3>Explore All Things PG</h3>
    <ul>
      <li>Get to know PG and the All Things PG community.</li>
      <li>Discover the main topics and public resources on the site.</li>
      <li>Choose another experience whenever it better fits your needs.</li>
    </ul>
  </div>
</section>



