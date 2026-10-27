---
layout: page
title: "Example 1: Patients"
nav_label: User Experience
breadcrumb: "User Experience > Example 1: Patients"
description: A patient path centered on understanding PG, getting help, and finding practical support.
permalink: /user-experience/patients/
---

<style>
.patient-screen-frame {
  box-sizing: border-box;
  width: 85%;
  margin: 1rem auto 2rem;
  overflow: hidden;
  border: 1px solid #e5d8c8;
  border-radius: 12px;
  background: #fff;
  box-shadow: 0 2px 10px rgba(38, 57, 74, .08);
}
.patient-screen-header {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  min-height: 68px;
  padding: .45rem clamp(.75rem, 3vw, 2rem);
  border-bottom: 1px solid #eee7df;
  background: #fff;
}
.patient-screen-header img { display: block; width: 58px; height: 58px; object-fit: contain; }
.patient-screen-nav { display: flex; flex: 1; align-items: center; justify-<a href="/welcome/glossary/" target="_blank" rel="noopener">content</a>: space-between; gap: .55rem; color: #1e293b; font-size: .72rem; font-weight: 600; letter-spacing: .025em; white-space: nowrap; }
.patient-screen-nav span { margin-left: 0; color: #59636d; font-size: .65rem; }
.patient-screen-nav .nav-item { display: inline-flex; align-items: center; gap: .15rem; color: #1e293b; font-size: .72rem; }
.patient-screen-donate { padding: .48rem 1rem; border: 1px solid #f58220; border-radius: 999px; background: #fff; color: #d96500; font: inherit; font-size: .78rem; font-weight: 700; }
.patient-screen-breadcrumb { display: flex; align-items: center; justify-content: space-between; gap: .75rem 1.5rem; padding: .55rem clamp(.75rem, 3vw, 2rem); background: #f58220; color: #17212b; font-size: .74rem; font-weight: 600; letter-spacing: .035em; }
.patient-screen-experience { display: inline-flex; align-items: center; gap: .75rem; }
.patient-screen-select { min-width: 125px; padding: .3rem .55rem; border: 1px solid #d9d9d9; border-radius: 4px; background: #fff; font-weight: 500; letter-spacing: normal; }
.patient-screen-content { padding: clamp(1rem, 3vw, 2rem); }
.patient-screen-title { margin: 0 0 1rem; color: #e56b00; font-size: clamp(1.65rem, 4vw, 2.5rem); }
.patient-screen-tiles { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: .65rem; margin-bottom: 1.15rem; padding: .65rem; border-radius: 12px; background: #fff; box-shadow: 0 2px 10px rgba(38, 57, 74, .08); }
.patient-screen-tile { min-height: 4.15rem; padding: .65rem .8rem; border: 1px solid #f58220; border-radius: 10px; background: #fff8f0; color: #26394a; }
.patient-screen-tile strong { display: block; margin-bottom: .2rem; color: #d96500; font-size: .9rem; }
.patient-screen-tile span { display: block; font-size: .78rem; line-height: 1.35; }
.patient-screen-hero { box-sizing: border-box; display: grid; grid-template-columns: minmax(0, .9fr) minmax(0, 1.1fr); align-items: stretch; gap: 1rem; min-height: 330px; padding: clamp(1rem, 2.5vw, 1.75rem); overflow: hidden; background-image: linear-gradient(90deg, rgba(250, 248, 242, .95) 0%, rgba(250, 248, 242, .84) 53%, rgba(250, 248, 242, .52) 100%), url('/assets/images/caregiver-wheelchair-hero.png'); background-size: cover; background-position: center 52%; }
.patient-screen-panel { padding: .25rem; border: 0; background: transparent; }
.patient-screen-panel h3 { margin: 0 0 .55rem; color: #d96500; font-size: 1.12rem; }
.patient-screen-panel p { margin: 0; color: #26394a; font-size: .94rem; line-height: 1.5; }
.patient-screen-panel ul { margin: 0; padding-left: 1.15rem; }
.patient-screen-panel li { margin: .32rem 0; color: #26394a; font-size: .86rem; line-height: 1.35; }
.patient-screen-menu-state { position: relative; }
.patient-screen-menu-state .patient-screen-header { position: relative; }
.patient-screen-menu-state .patient-open-menu { position: absolute; z-index: 2; top: 58px; left: 29%; width: 190px; padding: .35rem 0; border-top: 3px solid #f58220; background: #fff; box-shadow: 0 5px 14px rgba(0, 0, 0, .18); }
.patient-screen-menu-state .patient-open-menu span { display: block; padding: .45rem .8rem; color: #26394a; font-size: .72rem; font-weight: 500; }
@media (max-width: 700px) {
  .patient-screen-header { gap: .75rem; }
  .patient-screen-nav { font-size: .72rem; }
  .patient-screen-breadcrumb { align-items: flex-start; flex-direction: column; }
  .patient-screen-tiles { grid-template-columns: 1fr; }
  .patient-screen-hero { grid-template-columns: 1fr; }
}
</style>

<h2>Example 1: Patients</h2>

<section class="patient-screen-frame patient-screen-menu-state" aria-label="Sample Patient Portal screen with the Patient menu open">
  <header class="patient-screen-header">
    <img src="/assets/images/pg-logo.png" alt="All Things PG logo">
    <nav class="patient-screen-nav" aria-label="Main navigation">
      <span class="nav-item">WELCOME <span aria-hidden="true">▼</span></span>
      <span class="nav-item">ABOUT PG <span aria-hidden="true">▼</span></span>
      <span class="nav-item">BEING A PATIENT <span aria-hidden="true">▼</span></span>
      <span class="nav-item">TEAM APPROACH <span aria-hidden="true">▼</span></span>
      <span class="nav-item">RESOURCES <span aria-hidden="true">▼</span></span>
      <span class="nav-item">GALLERY <span aria-hidden="true">▼</span></span>
      <span class="nav-item">FUNDRAISING <span aria-hidden="true">▼</span></span>
      <span class="nav-item">OUR ORGANIZATION <span aria-hidden="true">▼</span></span>
      <span aria-label="Text size">A↕</span>
    </nav>
    <button class="patient-screen-donate" type="button">DONATE</button>
    <div class="patient-open-menu" aria-label="Open Patient menu">
      <span>Emotional Journey</span>
      <span>Living with the Pain</span>
      <span>Success Stories</span>
      <span>Patient Stories</span>
      <span>Being a Warrior</span>
      <span>Getting Help</span>
    </div>
  </header>
  <div class="patient-screen-breadcrumb">
    <div>HOME &rsaquo; PATIENT PORTAL</div>
    <div class="patient-screen-experience">CHOOSE YOUR EXPERIENCE: <span class="patient-screen-select">PATIENT　⌄</span></div>
  </div>
  <main class="patient-screen-content">
    <h2 class="patient-screen-title">Patient Portal</h2>
    <div class="patient-screen-tiles" aria-label="Patient portal featured areas">
      <div class="patient-screen-tile"><strong>Understanding PG</strong><span>Learn about PG, symptoms, and what to expect.</span></div>
      <div class="patient-screen-tile"><strong>Treatment Options</strong><span>Explore treatment approaches and wound care.</span></div>
      <div class="patient-screen-tile"><strong>Support &amp; Community</strong><span>Find shared experiences and emotional support.</span></div>
    </div>
    <section class="patient-screen-hero" aria-label="Patient introduction and common needs">
      <div class="patient-screen-panel">
        <h3>Living with PG</h3>
        <p>People may come to the site at different points in their experience with PG. The portal offers a clear place to learn, explore options, and find support at a pace that feels right for them.</p>
      </div>
      <div class="patient-screen-panel">
        <h3>Find a Helpful Next Step</h3>
        <ul>
          <li>Understand PG and what may happen during the journey.</li>
          <li>Explore treatment and practical wound care information.</li>
          <li>Connect with patient stories, community, and support.</li>
        </ul>
      </div>
    </section>
  </main>
</section>
