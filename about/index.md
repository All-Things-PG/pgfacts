---
layout: home
title: About
nav_label: About
description: Background and contact information.
permalink: /about/
topic_key: about
---

{% assign topic = site.data.topic_pages.about %}
<section class="home-hero">
  <h1>About All Things PG</h1>
  <p>{{ topic.summary }}</p>
</section>

<table class="topic-table" aria-label="About documents">
  <thead><tr><th>Page Description</th><th>Document</th></tr></thead>
  <tbody>
    {% for item in topic.pages %}
    <tr><td>{{ item.description }}</td><td><a href="{{ item.url | relative_url }}">{{ item.title }}</a></td></tr>
    {% endfor %}
  </tbody>
</table>
