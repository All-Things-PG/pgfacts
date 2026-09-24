---
layout: home
title: User Experience
nav_label: User Experience
description: Portal experiences for each visitor type.
permalink: /user-experience/
topic_key: user-experience
---

{% assign topic = site.data.topic_pages['user-experience'] %}
<section class="home-hero">
  <h1>Welcome to User Experience</h1>
  <p>{{ topic.summary }}</p>
  <p>Each visitor type can have a different portal experience based on their needs, role, and the information they are trying to reach.</p>
</section>

<table class="topic-table" aria-label="User Experience documents">
  <thead><tr><th>Page Description</th><th>Document</th></tr></thead>
  <tbody>
    {% for item in topic.pages %}
    <tr><td>{{ item.description }}</td><td><a href="{{ item.url | relative_url }}">{{ item.title }}</a></td></tr>
    {% endfor %}
  </tbody>
</table>
