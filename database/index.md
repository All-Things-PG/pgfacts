---
layout: home
title: Database
nav_label: Database
description: Data model for Phase 2 features.
permalink: /database/
topic_key: database
---

{% assign topic = site.data.topic_pages.database %}
<section class="home-hero">
  <h1>Welcome to the DCMS Database</h1>
  <p>{{ topic.summary }}</p>
  <p>The database supports features like a patient registry, newsletters, and storing portal experience information.</p>
</section>

<table class="topic-table" aria-label="Database documents">
  <thead><tr><th>Page Description</th><th>Document</th></tr></thead>
  <tbody>
    {% for item in topic.pages %}
    <tr><td>{{ item.description }}</td><td><a href="{{ item.url | relative_url }}">{{ item.title }}</a></td></tr>
    {% endfor %}
  </tbody>
</table>
