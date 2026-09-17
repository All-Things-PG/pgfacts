---
title: PG Facts
---

<style>
  :root {
    --pg-orange: #f58220;
    --pg-dark: #222;
    --pg-border: #f0b17a;
  }
  body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    color: var(--pg-dark);
    background: #fff;
  }
  .site-banner {
    border-bottom: 4px solid var(--pg-orange);
    background: #fff;
  }
  .site-shell {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1.25rem;
  }
  .site-brand {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 1rem 0;
    flex-wrap: wrap;
  }
  .site-brand img {
    height: 56px;
    width: auto;
  }
  .site-nav {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.02em;
  }
  .site-nav a {
    color: var(--pg-dark);
    text-decoration: none;
    padding: 0.25rem 0;
  }
  .site-nav a:hover {
    color: var(--pg-orange);
  }
  .hero {
    padding: 4rem 0 5rem;
    background: linear-gradient(180deg, #fff 0%, #fff7ef 100%);
  }
  .hero h1 {
    margin: 0 0 1rem;
    font-size: clamp(2.5rem, 6vw, 4.5rem);
  }
  .hero p {
    max-width: 42rem;
    font-size: 1.15rem;
    line-height: 1.6;
  }
  .hero-card {
    margin-top: 2rem;
    display: inline-block;
    border: 1px solid var(--pg-border);
    border-radius: 14px;
    padding: 1rem 1.25rem;
    background: #fff;
    color: var(--pg-orange);
    font-weight: 700;
    text-decoration: none;
  }
</style>

<header class="site-banner">
  <div class="site-shell site-brand">
    <a href="/" aria-label="PG Facts home">
      <img src="/assets/images/pg-logo.png" alt="All Things PG" />
    </a>
    <nav class="site-nav" aria-label="Primary navigation">
      <a href="/">Home</a>
      <a href="/about">About PG</a>
      <a href="/being-a-guest">Being a Guest</a>
      <a href="/resources">Resources</a>
      <a href="/contact">Contact</a>
    </nav>
  </div>
</header>

<main class="hero">
  <div class="site-shell">
    <h1>Welcome to PG Facts</h1>
    <p>
      A simple branded landing page for All Things PG, with a banner and navigation
      but no document listings.
    </p>
    <a class="hero-card" href="/about">Explore the site</a>
  </div>
</main>
