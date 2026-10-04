---
layout: home
title: Technical
nav_label: Technical
breadcrumb: Technical
description: Site structure and authoring guidance.
permalink: /technical/
topic_key: technical
---

{% assign topic = site.data.topic_pages.technical %}
<section class="home-hero">
  <h1>Technical</h1>
  <p>{{ topic.summary }}</p>
</section>

<p>Start with the <a href="{{ '/technical/pgfacts-site-guide/' | relative_url }}">PG Facts Site Guide</a>, then read the <a href="{{ '/technical/managing-pages/' | relative_url }}">Managing Pages</a> and <a href="{{ '/technical/managing-tiles/' | relative_url }}">Managing Tiles</a> guides.</p>

<table class="topic-table" aria-label="Technical documents">
  <thead><tr><th>Page Description</th><th>Document</th></tr></thead>
  <tbody>
    {% for item in topic.pages %}
    <tr><td>{{ item.description }}</td><td><a href="{{ item.url | relative_url }}">{{ item.title }}</a></td></tr>
    {% endfor %}
  </tbody>
</table>