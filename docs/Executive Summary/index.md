---
layout: page
title: Executive Summary
permalink: /docs/executive-summary/
---

# Executive Summary

This folder contains sponsor-facing summary documents.

{% assign docs = site.pages | where_exp: "item", "item.path contains 'docs/Executive Summary/' and item.name != 'index.md'" | sort: "title" %}
{% include topic-list.html docs=docs %}
