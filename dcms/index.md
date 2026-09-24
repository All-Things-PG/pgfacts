---
layout: home
title: DCMS
nav_label: DCMS
description: Dynamic Content and Menuing System
permalink: /dcms/
topic_key: dcms
---

{% assign topic = site.data.topic_pages.dcms %}
<section class="home-hero">
  <h1>Welcome to DCMS - Dynamic Content and Menuing System</h1>
  <p>{{ topic.summary }}</p>
  <p>Explore the individual topics below to see how content, menus, and page structure work together.</p>
</section>

<table class="topic-table" aria-label="DCMS documents">
  <thead>
    <tr>
      <th>Page Description</th>
      <th>Document</th>
    </tr>
  </thead>
  <tbody>
    {% for item in topic.pages %}
    <tr>
      <td>{{ item.description }}</td>
      <td><a href="{{ item.url | relative_url }}">{{ item.title }}</a></td>
    </tr>
    {% endfor %}
  </tbody>
</table>
