---
title: All Things PG - Phase 2
layout: home
---

<style>
  :root {
    --pg-orange: #f58220;
    --pg-orange-soft: #fff3e7;
    --pg-dark: #222;
    --pg-border: #e6b17b;
  }
  body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    color: var(--pg-dark);
    background: #fff;
  }
  .site-banner {
    background: #fff;
    border-bottom: 4px solid var(--pg-orange);
  }
  .site-shell {
    max-width: 1240px;
    margin: 0 auto;
    padding: 0 1.25rem;
  }
  .site-brand {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem 0;
    flex-wrap: wrap;
  }
  .site-brand img {
    height: 56px;
    width: auto;
    flex: 0 0 auto;
  }
  .site-title {
    font-size: 1.35rem;
    font-weight: 800;
    white-space: nowrap;
  }
  .site-nav {
    display: flex;
    align-items: center;
    gap: 1rem;
    flex-wrap: wrap;
    margin-left: auto;
  }
  .nav-group {
    position: relative;
    display: inline-block;
  }
  .nav-group[open] .nav-panel {
    display: block;
  }
  .nav-group > summary,
  .site-nav > a,
  .site-nav > span {
    list-style: none;
    cursor: pointer;
    font-weight: 700;
    color: var(--pg-dark);
    text-decoration: none;
    padding: 0.35rem 0.25rem;
    background: transparent;
  }
  .nav-group > summary::-webkit-details-marker {
    display: none;
  }
  .nav-group > summary::after {
    content: "▾";
    margin-left: 0.35rem;
    font-size: 0.82em;
  }
  .nav-group[open] > summary::after {
    content: "▴";
  }
  .nav-panel {
    position: absolute;
    left: 0;
    top: calc(100% + 0.45rem);
    min-width: 18rem;
    background: #fff;
    border: 1px solid var(--pg-border);
    border-radius: 12px;
    box-shadow: 0 10px 26px rgba(0,0,0,.12);
    padding: 0.75rem;
    z-index: 10;
  }
  .nav-group:not([open]) .nav-panel { display: none; }
  .nav-panel a {
    display: block;
    padding: 0.5rem 0.6rem;
    border-radius: 8px;
    text-decoration: none;
    color: var(--pg-dark);
    font-weight: 600;
  }
  .nav-panel a:hover {
    background: var(--pg-orange-soft);
    color: var(--pg-orange);
  }
  .nav-section {
    margin: 0.4rem 0 0.65rem;
    padding-top: 0.5rem;
    border-top: 1px solid #f0dcc6;
  }
  .nav-section:first-child {
    border-top: 0;
    padding-top: 0;
    margin-top: 0;
  }
  .nav-section h3 {
    margin: 0 0 0.35rem;
    font-size: 0.86rem;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    color: #7a4b21;
  }
  .hero {
    padding: 3.5rem 0 4.5rem;
    background: linear-gradient(180deg, #fff 0%, #fff7ef 100%);
  }
  .hero-grid {
    display: grid;
    grid-template-columns: 1.3fr 1fr;
    gap: 2rem;
    align-items: center;
  }
  .hero h1 {
    margin: 0 0 1rem;
    font-size: clamp(2.5rem, 6vw, 4.5rem);
    line-height: 1.02;
  }
  .hero p {
    max-width: 46rem;
    font-size: 1.12rem;
    line-height: 1.65;
  }
  .hero-card,
  .story-card {
    border: 1px solid var(--pg-border);
    border-radius: 16px;
    background: #fff;
    box-shadow: 0 2px 10px rgba(0,0,0,.05);
  }
  .hero-card {
    padding: 1.25rem;
  }
  .hero-card h2,
  .story-card h3 {
    margin-top: 0;
    color: var(--pg-orange);
  }
  .hero-card a,
  .story-card a,
  .tile a {
    color: var(--pg-dark);
    text-decoration: none;
  }
  .hero-card a:hover,
  .story-card a:hover,
  .tile a:hover {
    color: var(--pg-orange);
  }
  .story-strip {
    padding: 0 0 3rem;
  }
  .tile-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1rem;
  }
  .tile {
    display: block;
    padding: 1rem 1.1rem 1.15rem;
    border: 1px solid var(--pg-border);
    border-radius: 14px;
    background: #fff;
    box-shadow: 0 1px 4px rgba(0,0,0,.05);
    min-height: 7.5rem;
  }
  .tile strong {
    display: block;
    color: var(--pg-orange);
    margin-bottom: 0.25rem;
    font-size: 1.02rem;
  }
  .tile span {
    display: block;
    line-height: 1.35;
  }
  .tile--accent {
    background: linear-gradient(180deg, #fff7ef 0%, #ffffff 100%);
  }
  .gate-overlay {
    position: fixed;
    inset: 0;
    background: rgba(255,255,255,.96);
    z-index: 1000;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 1.25rem;
  }
  .gate-card {
    width: min(32rem, 100%);
    border: 1px solid var(--pg-border);
    border-radius: 16px;
    background: #fff;
    box-shadow: 0 12px 28px rgba(0,0,0,.12);
    padding: 1.5rem;
  }
  .gate-card h2 {
    margin-top: 0;
    color: var(--pg-orange);
  }
  .gate-card input {
    width: 100%;
    padding: 0.8rem 0.9rem;
    font-size: 1rem;
    border: 1px solid #cfcfcf;
    border-radius: 10px;
    box-sizing: border-box;
  }
  .gate-card button {
    margin-top: 0.9rem;
    padding: 0.75rem 1rem;
    border: 1px solid var(--pg-orange);
    border-radius: 999px;
    background: #fff;
    color: var(--pg-dark);
    font-weight: 700;
    cursor: pointer;
  }
  .gate-note {
    margin-top: 0.75rem;
    font-size: 0.92rem;
    color: #666;
  }
  @media (max-width: 960px) {
    .hero-grid {
      grid-template-columns: 1fr;
    }
    .site-nav {
      margin-left: 0;
    }
  }
</style>

<section class="hero">
  <div class="site-shell hero-grid">
    <section>
      <h1>Phase 2 is coming together.</h1>
      <p>
        This site will hold the working documentation for the next phase of All Things PG:
        the DCMS model, user experience patterns, and the database foundations behind them.
      </p>
      <p>
        Think of this page as a short newsletter and launch point for the upcoming changes.
      </p>
    </section>
  </div>
</section>

<section class="story-strip">
  <div class="site-shell">
    <div class="tile-grid">
      <div class="tile tile--accent">
        <a href="/dcms/">
          <strong>DCMS</strong>
          <span>Document the content model, dynamic menus, and dynamic content flow.</span>
        </a>
      </div>
      <div class="tile tile--accent">
        <a href="/user-experience/">
          <strong>User Experience</strong>
          <span>Show how visitors choose a persona and move through the site.</span>
        </a>
      </div>
      <div class="tile tile--accent">
        <a href="/database/">
          <strong>Database</strong>
          <span>Capture the tables, schema diagrams, and supporting structure.</span>
        </a>
      </div>
    </div>
  </div>
</section>

<div class="gate-overlay" id="site-gate">
  <div class="gate-card">
    <h2>Administrator access</h2>
    <p>Enter the site-wide access code to view pgfacts.org.</p>
    <input id="gate-code" type="password" placeholder="Access code" autocomplete="off" />
    <button type="button" id="gate-submit">Enter site</button>
    <div class="gate-note">Simple gate for now; not a full login system.</div>
  </div>
</div>

<script>
  (function () {
    var gateKey = "pgfacts-admin-unlocked";
    var gateCode = atob("QVRQRw==");
    var requestEmail = "dave@allthingspg.org";
    var gate = document.getElementById("site-gate");
    var input = document.getElementById("gate-code");
    var submit = document.getElementById("gate-submit");
    var groups = document.querySelectorAll(".nav-group");
    var page = document.body;

    function unlock() {
      sessionStorage.setItem(gateKey, "true");
      gate.style.display = "none";
    }

    function closeOthers(current) {
      for (var i = 0; i < groups.length; i += 1) {
        if (groups[i] !== current) {
          groups[i].removeAttribute("open");
        }
      }
    }

    if (sessionStorage.getItem(gateKey) === "true") {
      gate.style.display = "none";
      return;
    }

    submit.addEventListener("click", function () {
      if (input.value === gateCode) {
        unlock();
      } else {
        input.value = "";
        input.focus();
        alert("Incorrect access code.");
      }
    });

    input.addEventListener("keydown", function (event) {
      if (event.key === "Enter") {
        submit.click();
      }
    });

    for (var i = 0; i < groups.length; i += 1) {
      groups[i].addEventListener("toggle", function (event) {
        if (event.target.open) {
          closeOthers(event.target);
        }
      });
    }

    page.addEventListener("click", function (event) {
      var clickedInMenu = event.target.closest && event.target.closest(".nav-group");
      if (!clickedInMenu) {
        for (var j = 0; j < groups.length; j += 1) {
          groups[j].removeAttribute("open");
        }
      }
    });
  })();
</script>
