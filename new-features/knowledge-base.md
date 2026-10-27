---
layout: page
title: Knowledge Base
nav_label: New Features in Phase 2
breadcrumb: New Features in Phase 2 > Knowledge Base
description: A structured, searchable collection of trusted PG information.
permalink: /new-features/knowledge-base/
work_in_progress: false
---
# Knowledge Base

A <a href="/welcome/glossary/" target="_blank" rel="noopener">Knowledge Base (KB)</a> is the planned as a searchable collection of trusted, vetted information about Pyoderma Gangrenosum and any associted article contained within this website.  At this time I do not have any designs that might reach out into the AI world to augment the information, but I have thought about it.

The KB is  to help visitors of all the 5 main types: patients, caregivers, providers, pharmaceuticals and guests, to QUICKLY find relevant articles based on their needs.

A more detailed discussion of the KB design can be found in the DCMS topic [DCMS Knowledge Base page](/dcms/knowledge-base/).

The KB isn't really a single table in the database.  It's not a separate thing.  Its is a representation of any type of information with the AllThngsPG database that sits behind the website.  The database allows for the existence of the KB a a concept. An AI model descirbed a KB as:

>A knowledge base is an organized collection of information designed so people or software, including AI, can find, retrieve, and >use knowledge efficiently.
>
>Think of it as a library with structure and a good search system, rather than just a pile of documents.
>
>A knowledge base might contain:>
>
>- Articles and explanations
>- FAQs
>vPolicies and procedures
>- Technical documentation
>- Research and reference material
>- How-to guides
>- Definitions and terminology
>- Links to authoritative sources
>- Images, PDFs, Word documents, or videos
>- Metadata such as topics, authors, dates, and categories
{: .simple-blockquote}

That's pretty much right defifining my  Phase 2 concept.

### Source of Information

The database is organized into Menu Item tables, Content Tables, Registration Tables, Migration Tables, Staging Tables, and other smaller partitions.  It is not organized into a KB.  The KB draws from **ANY** potential content of any type, and assembles it into search resuls that reach back anywhere into the database. There' not single source of information.  Each class of data will be candidates for search results, and perhap one date, externaml source would apply and vastly improve our capability.

With a database, the sky is the limit!

### Seach Capabilities

I envision a naturual language search as opposed to a set of drop down list of categories and filter.  Perhap we will have both. You can filter on the type of information you're looking for, to limit the KB search overall, and then apply your question.  MS SQL Server has always had what's called **Full-Text Indexing** and I've used it many times.  Its a special index (you can't search without an index) created by special agent jobs (Get Smart) that scan the database for text that can be indexed, and stores it in a way that can be search.  The top side will ask questions using open text and parse into token that can be applied against the index. The key to a successful search is the parsing. SQL already supplies a powerful search engine, and we could achieve our goals with built in capabilities. However, with the extension of AI, I believe we can do even more, and achieve better results.  Its a matter of tuning.

What treatments are best for PG?
I'm having an issue with my doctor?
My pain is a 14, what can I do?
Are there any wound care clinics nearby?

These are not preplanned queries that you think in your head and go off browsing an entire website looking for answers.  These are things we thing about, in the natural world, and expresed in a natural language sort of way.

### Result Set

Right now the planned search result is a listing of content in the databae that is associated with menu item clicks. This is a great place to start. Anything you can find by browsing the site should be available to the KB search.  This is, however, very limited. It would be nice to store content that is behind the scenes.  The problem is that, if it's behind the scenes, how do you know its there (getting philisophical)?  Instead of going into technical detail, realize it's always possible to make something work, but I prefer to fit things into designs that make sense, and not breach rules and regulations in my head, as it perations to traditional relational database schema.

So, as originally planned, SQL has a mechanism that results a search result from a full-text search, and I planned on using that to go back and identify the found article and diplay the title and the menu item click that would bring you to that content without reinventing ways to navigate data.  That will be our starting point!

From there I have other ideas, like what if it doesn't find anything? The standard thing to do is say no results found.  I think we cand do better by creating a FAQ document on every search that help answer similar question, some that may lead to more searh results.  We shall see.   

### Will it work?

Yes, but its all about time and effort and budget.  The first step in any new feature is to get it working as a proof of concept, and then expand it into production ready value.  The KB is not part of the POC now, nor will it be.  At this stage, we're either going to begin Phase 2 or we won't be.  The KB is a central part of Phase 2, and likely the most powerul feature made possible by the DCMS design.




