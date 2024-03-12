---
title: "OpenSearch Machine"
author: "R. S. Doiel, <rsdoiel@caltech.edu>"
institute: |
  Caltech Library,
  Digital Library Development
description: Brief discussion about OpenSearch running under Multipass managed virtual machines
urlcolor: blue
linkstyle: bold
aspectratio: 169
createDate: 2024-03-08
updateDate: 2024-03-08
#pubDate: TBD
#place: TBD
#date: TBF
section-titles: false
toc: true
keywords: [ "search engine", "opensearch" ]
url: "https://caltechlibrary.github.io/opensearch_machine/blob/main/presentation.md"
---

# OpenSearch Machine

## Learning and exploring OpenSearch using a Multipass managed virtual machine

# Knowledge requirements

- You need to comfortable with working on the command line
- General understanding of how the web works
    - HTTP, HTTP methods (e.g. GET, POST)
    - HTML and JSON documents

# System Requirements (Host machine)

- macOS, Linix or Windows based machine (ARM or Intel CPU)
- [Multipass](https://multipass.run)

# Software Requirements (Host machine)

- Web browser (e.g. Firefox)
- [cURL](https://curl.se)
- A plain text editor

# What we'll be doing (host and virtual machine)

- Running programs "terminal" or "shell"
- using a program called `curl` to work with OpenSearch
- using a web browser
- light text editing

# Before you start

1. Make sure Multipass is installed and working
2. Know how to launch, start, stop, delete, purge your virtual machine

# Getting started

1. Run `./opensearch_machine.bash` to create the `opensearch_machine` virtual machine
2. Run `multipass shell opensearch_machine` to finish setting things up

# On, opensearch_machine

1. Run `01-setup-scripts.bash`
2. Run `07-add-opensearch.bash`
3. Source the updated `.bashrc` file.

# On your host machine

1. Use `multipass info opensearch_machine` to find the IP address of the virtual machine
2. Point your web browser at virtual machine using the port number for OpenSearch REST API or Dashboard.

> Now we're ready to start working with OpenSearch

# Checking our configuration

- GET, "_settings"

~~~
curl http://localhost:9200/_settings
~~~

# Mapping an index

- POST, `_index_mapping`

# Adding a document to the index

- POST, `{INDEX_NAME}`

# Retrieving the index map

- GET, `_index_mapping`

# Retreiving index contents

- GET, `_search`
- Loop through results 

# Updating an index document

- POST, `{INDEX_NAME}`

# Dropping document

# Dropping an index

# Restoring an index

# What we've learned

- Basic interactions of OpenSearch REST API
- Basic management actions
  - create, read, update, delete, list, restore

# What is OpenSearch?

- A fork of Elasticsearch
- A full text search engine based on Apache Lucene (like Solr)
- Elasticsearch was a response to the stagnation of Solr some years back
  - Elasticsearch embraced a JSON REST API over XML of the venerable Solr of the time

# OpenSearch vs. Elasticsearch vs. Solr?

- They're all based on All Based on Lucene
- They share many concepts in common (e.g. indexes, REST API, support of JSON/XML)
- General knowledge is transferable between them
- Specifics very

# OpenSearch vs Elasticsearch vs. Solr.

- Solr is best documented
- Invenio RDM started out with Elasticsearch
- Invenio RDM now uses OpenSearch

# OpenSearch vs Elasticserch

- Documentaiton for Elasticsearch largely applies to OpenSearch
- Tooling right now is common between the two (e.g. elasticdump)
- OpenSearch documentation looks shiny but isn't that helpful
- RDM's documentation of OpenSearch is a better place to start

# OpenSearch

- OpenSearch is Amazon's fork of Elasticsearch
- Amazon wants all the support income and is cutting out Elasticsearch Co.
- When Elasticsearch was created Solr had stagnated and was XML only
- Solr/Elasticsearch/OpenSearch are functionally equivallent but their API are different

# OpenSearch

- Today, February 2024, OpenSearch and Elasticsearch are compatible in terms of API and tooling
- Who knows what tomorrow may bring?
  - At some point Amazon will embrace and extend
  
# Basic management activities

- Creating mapping for new indexes
- Index documents
- Managing aliases of indexes
- Manage indexes (e.g. rollups of time series indexes)
- Providing search service

# Managing OpenSearch

- JSON REST API running on port 9200
- A "dashboard" web service
- 3rd party tooling
  - elasticdump (NodeJS/NPM)
  - curator (Python)
  - cURL, Httpie

# JSON API end points

- `_settings`
- `_index_aliases`
- `_search`
- `_mapping`

# What is an index?

- A searchable data structure for full text structured documents
- A collection "documents" expressed as JSON

# What does my OpenSearch engine manage?

- Retrieve the `_settings` JSON document with get

~~~shell
curl http://localhost:9200/_settings
~~~

# Creating a new index

- POST of JSON document into REST API

# Creating a new index map

- POST of JSON document of mapping into REST API

# Populating our index

- POST to ...

# Testing our index

- GET `_search`

# Retrieving our current index map

- GET `_index_mapping`

# Retreiving the contents of an index

- GET `_search`
- Search for everything
- Loop through all results

# Backups for RDM
- TBD

# What is index aliasing?

- TBD

# Creating index aliases

- TBD

# Backing up indexes

- TBD

# In conclusion

- Thank you!

# About

- Caltech Library Digital Library Development Group
- <https://caltechlibrary.github.io/opensearch_machine>
- <https://github.com/caltechlibrary/opensearch_machine>
- Issues <https://github.com/caltechlibrary/opensearch_machine/issues>


