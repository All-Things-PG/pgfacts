---
layout: page
title: "Example 2: Providers"
nav_label: User Experience
breadcrumb: "User Experience > Example 2: Providers"
description: Clinical context and practical routes into PG evidence and resources.
permalink: /user-experience/providers/
---

<style>
.provider-screen-frame {
  box-sizing: border-box;
  width: 85%;
  margin: 1rem auto 2rem;
  overflow: hidden;
  border: 1px solid #e5d8c8;
  border-radius: 12px;
  background: #fff;
  box-shadow: 0 2px 10px rgba(38, 57, 74, .08);
}

.provider-screen-header {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  min-height: 68px;
  padding: .45rem clamp(.75rem, 3vw, 2rem);
  border-bottom: 1px solid #eee7df;
  background: #fff;
}

.provider-screen-header img { display: block; width: 58px; height: 58px; object-fit: contain; }
.provider-screen-nav { display: flex; flex: 1; align-items: center; justify-<a href="/welcome/glossary/" target="_blank" rel="noopener">content</a>: space-between; gap: .55rem; color: #1e293b; font-size: .72rem; font-weight: 600; letter-spacing: .025em; white-space: nowrap; }
.provider-screen-nav span { margin-left: 0; color: #59636d; font-size: .65rem; }
.provider-screen-nav .nav-item { display: inline-flex; align-items: center; gap: .15rem; color: #1e293b; font-size: .72rem; }
.provider-screen-donate {
  padding: .48rem 1rem;
  border: 1px solid #f58220;
  border-radius: 999px;
  background: #fff;
  color: #d96500;
  font: inherit;
  font-size: .78rem;
  font-weight: 700;
}

.provider-screen-breadcrumb {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: .75rem 1.5rem;
  padding: .55rem clamp(.75rem, 3vw, 2rem);
  background: #f58220;
  color: #17212b;
  font-size: .74rem;
  font-weight: 600;
  letter-spacing: .035em;
}

.provider-screen-experience { display: inline-flex; align-items: center; gap: .75rem; }
.provider-screen-select {
  min-width: 125px;
  padding: .3rem .55rem;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  background: #fff;
  font-weight: 500;
  letter-spacing: normal;
}

.provider-screen-content { padding: clamp(1rem, 3vw, 2rem); }
.provider-screen-title { margin: 0 0 1rem; color: #e56b00; font-size: clamp(1.65rem, 4vw, 2.5rem); }
.provider-screen-tiles {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: .65rem;
  margin-bottom: 1.15rem;
  padding: .65rem;
  border-radius: 12px;
  background: #fff;
  box-shadow: 0 2px 10px rgba(38, 57, 74, .08);
}

.provider-screen-tile {
  min-height: 4.15rem;
  padding: .65rem .8rem;
  border: 1px solid #f58220;
  border-radius: 10px;
  background: #fff8f0;
  color: #26394a;
}

.provider-screen-tile strong { display: block; margin-bottom: .2rem; color: #d96500; font-size: .9rem; }
.provider-screen-tile span { display: block; font-size: .78rem; line-height: 1.35; }

.provider-screen-hero {
  box-sizing: border-box;
  display: grid;
  grid-template-columns: minmax(0, .9fr) minmax(0, 1.1fr);
  align-items: stretch;
  gap: 1rem;
  min-height: 330px;
  padding: clamp(1rem, 2.5vw, 1.75rem);
  overflow: hidden;
  background-image:
    linear-gradient(90deg, rgba(250, 248, 242, .95) 0%, rgba(250, 248, 242, .84) 53%, rgba(250, 248, 242, .52) 100%),
    url('/assets/images/provider-exam-room-hero.png');
  background-size: cover;
  background-position: center 52%;
}

.provider-screen-panel {
  padding: .25rem;
  border: 0;
  border-radius: 0;
  background: transparent;
}

.provider-screen-panel h3 { margin: 0 0 .55rem; color: #d96500; font-size: 1.12rem; }
.provider-screen-panel p { margin: 0; color: #26394a; font-size: .94rem; line-height: 1.5; }
.provider-screen-panel ul { margin: 0; padding-left: 1.15rem; }
.provider-screen-panel li { margin: .32rem 0; color: #26394a; font-size: .86rem; line-height: 1.35; }

.provider-screen-menu-state { position: relative; }
.provider-screen-menu-state .provider-screen-header { position: relative; }
.provider-screen-menu-state .provider-open-menu {
  position: absolute;
  z-index: 2;
  top: 58px;
  left: 29%;
  width: 190px;
  padding: .35rem 0;
  border-top: 3px solid #f58220;
  background: #fff;
  box-shadow: 0 5px 14px rgba(0, 0, 0, .18);
}
.provider-screen-menu-state .provider-open-menu span { display: block; padding: .45rem .8rem; color: #26394a; font-size: .72rem; font-weight: 500; }
.provider-screen-menu-state .provider-open-menu span:hover { background: #fff3e6; }

@media (max-width: 700px) {
  .provider-screen-header { gap: .75rem; }
  .provider-screen-nav { font-size: .72rem; }
  .provider-screen-breadcrumb { align-items: flex-start; flex-direction: column; }
  .provider-screen-tiles { grid-template-columns: 1fr; }
  .provider-screen-hero { grid-template-columns: 1fr; }
}
</style>

<h2>Example 2: Providers</h2>

<section class="provider-screen-frame provider-screen-menu-state" aria-label="Sample Provider Portal screen with the Provider menu open">
  <header class="provider-screen-header">
    <img src="/assets/images/pg-logo.png" alt="All Things PG logo">
    <nav class="provider-screen-nav" aria-label="Main navigation">
      <span class="nav-item">WELCOME <span aria-hidden="true">▼</span></span>
      <span class="nav-item">ABOUT PG <span aria-hidden="true">▼</span></span>
      <span class="nav-item">BEING A PROVIDER <span aria-hidden="true">▼</span></span>
      <span class="nav-item">TEAM APPROACH <span aria-hidden="true">▼</span></span>
      <span class="nav-item">RESOURCES <span aria-hidden="true">▼</span></span>
      <span class="nav-item">GALLERY <span aria-hidden="true">▼</span></span>
      <span class="nav-item">FUNDRAISING <span aria-hidden="true">▼</span></span>
      <span class="nav-item">OUR ORGANIZATION <span aria-hidden="true">▼</span></span>
      <span aria-label="Text size">A↕</span>
    </nav>
    <button class="provider-screen-donate" type="button">DONATE</button>
    <div class="provider-open-menu" aria-label="Open Provider menu">
      <span>Early Diagnosis</span>
      <span>Common Treatments</span>
      <span>Treating the Pain</span>
      <span>Building a Team</span>
      <span>Latest Research</span>
      <span>Clinical Trials</span>
      <span>Patient Registry</span>
    </div>
  </header>
  <div class="provider-screen-breadcrumb">
    <div>HOME &rsaquo; PROVIDER PORTAL</div>
    <div class="provider-screen-experience">CHOOSE YOUR EXPERIENCE: <span class="provider-screen-select">PROVIDER　⌄</span></div>
  </div>
  <main class="provider-screen-content">
    <h2 class="provider-screen-title">Provider Portal</h2>
    <div class="provider-screen-tiles" aria-label="Provider portal featured areas">
      <div class="provider-screen-tile"><strong>Clinical Guidelines</strong><span>Diagnosis and treatment guidance</span></div>
      <div class="provider-screen-tile"><strong>Research &amp; Evidence</strong><span>Studies, trials, and findings</span></div>
      <div class="provider-screen-tile"><strong>Professional Resources</strong><span>Tools and professional networks</span></div>
    </div>
    <section class="provider-screen-hero" aria-label="Provider introduction and key clinical features">
      <div class="provider-screen-panel">
        <h3>Providers</h3>
        <p>Doctors may arrive with different levels of familiarity with PG. A doctor treating PG for the first time needs a clear path to practical guidance and clinical resources. Specialists may be looking for evidence, research, or clinical trials.</p>
      </div>
      <div class="provider-screen-panel">
        <h3>Key Clinical Features</h3>
        <ul>
          <li><strong>Diagnosis:</strong> Usually clinical, confirmed by histopathology showing neutrophilic dermatosis.</li>
          <li><strong>Treatment Options:</strong> Corticosteroids, immunosuppressants, and biologic agents depending on severity.</li>
          <li><strong>Pathophysiology:</strong> Neutrophil-mediated inflammation, often associated with systemic conditions.</li>
          <li><strong>Prognosis:</strong> Variable course with potential for chronicity and recurrence.</li>
          <li><strong>Multidisciplinary Approach:</strong> Consider involvement of dermatology, gastroenterology, and rheumatology.</li>
        </ul>
      </div>
    </section>
  </main>
</section>
