---
layout: home
title: Phase 1
nav_label: Phase 1
description: Analysis and platform planning
permalink: /phase-1/
topic_key: phase-1
---

{% assign topic = site.data.topic_pages['phase-1'] %}
{% include topic-tiles.html %}

<section class="home-hero">
  <h1>Phase 1</h1>
  <p>{{ topic.summary }}</p>
</section>

<table class="topic-table" aria-label="Phase 1 documents">
  <thead>
    <tr><th>Page Description</th><th>Document</th></tr>
  </thead>
  <tbody>
    {% for item in topic.pages %}
    <tr><td>{{ item.description }}</td><td><a href="{{ item.url | relative_url }}">{{ item.title }}</a></td></tr>
    {% endfor %}
  </tbody>
</table>
