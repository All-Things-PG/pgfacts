---
layout: home
title: New Features in Phase 2
nav_label: New Features in Phase 2
breadcrumb: New Features in Phase 2
description: New capabilities planned for Phase 2.
permalink: /new-features-in-phase-2/
topic_key: new-features-in-phase-2
---

{% assign topic = site.data.topic_pages['new-features-in-phase-2'] %}
<section class="home-hero">
  <h1>New Features in Phase 2</h1>
  <p>{{ topic.summary }}</p>
</section>

<table class="topic-table" aria-label="New Features in Phase 2 documents">
  <thead><tr><th>Page Description</th><th>Document</th></tr></thead>
  <tbody>
    {% for item in topic.pages %}
    <tr><td>{{ item.description }}</td><td><a href="{{ item.url | relative_url }}">{{ item.title }}</a></td></tr>
    {% endfor %}
  </tbody>
</table>
