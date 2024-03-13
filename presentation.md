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
pubDate: 2024-03-13
place: DLD Dev Group Meeting
date: 2024-03-13
section-titles: false
toc: true
keywords: [ "search engine", "OpenSearch" ]
url: "https://caltechlibrary.github.io/opensearch_machine/blob/main/presentation.md"
---

# Part I: OpenSearch Machine (VM)

Exploring OpenSearch v2.5.0 using a Multipass managed virtual machine

# Knowledge requirements

- You need to comfortable with working on the command line
- General understanding of how the web works
    - HTTP, HTTP methods (e.g. GET, POST, PUT, DELETE)
    - JSON documents

# System Requirements (Host machine)

- macOS, Linux or Windows based machine (ARM or Intel CPU)
- [Multipass](https://multipass.run) needs to be installed

# Software Requirements (Virtual machine)

- [curl](https://curl.se)
- [jq](https://jqlang.github.io/jq/)
- A plain text editor is nice

# What we'll be doing (host and virtual machine)

- Running programs "terminal" or Multipass "shell"
- using a program called `curl` to interact with OpenSearch
- using `jq` to wrangle unruly JSON strings
- light text editing, to script the longer commands

# Before you start

1. Make sure Multipass is installed and working
2. Know how to launch, start, stop, delete, purge your virtual machine

# Getting started

1. Run `./opensearch_machine.bash` to create the `opensearch_machine` virtual machine
2. Run `multipass shell opensearch_machine` to finish setting things up

# On, the `opensearch-machine` VM

1. Run `01-setup-scripts.bash`
2. Run `07-add-opensearch.bash`
3. Source the updated `.bashrc` file.
4. Reboot your virtual machine

> Now we're ready to start working with OpenSearch

------------------

# Part II: Working with OpenSearch

We'll be using ...

- [curl](https://curl.se) (aka curl)
- [jq](https://jqlang.github.io)
- "`sudo systemctl`" to start/restart/status OpenSearch

# Make sure OpenSearch us up and running healthy

~~~shell
sudo systemctl status opensearch.service
~~~

# Exploring OpenSearch

Check to see how OpenSearch is currently configured.
By default OpenSearch runs on HTTPS (self signed certs)
and requires "admin" account to access.

~~~shell
curl -k --user admin:admin \
  https://localhost:9200/_settings?pretty
~~~

This should return JSON which shows the settings of our OpenSearch
installation.

# Creating our first index

- PUT, "{INDEX_NAME}"
- "{INDEX_NAME}" = 'contact-list'

~~~shell
curl -k --user admin:admin \
  -X PUT https://localhost:9200/contact-list?pretty
~~~

# Response from creating the index

~~~json
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "contact-list"
}
~~~

# Creating a document in our index

- POST, "{INDEX_NAME}/_doc/{DOC_ID}"

~~~shell
curl -k --user admin:admin \
  -H 'Content-Type: application/json' \
  --data '{"name": "Robert", "email": "rsdoiel@caltech.edu", "orcid": "0000-0003-0900-6903"}' \
  -X POST https://localhost:9200/contact-list/_doc/0000-0003-0900-6903?pretty
~~~

# Response from creating our document

~~~json
{
  "_index" : "contact-list",
  "_id" : "0000-0003-0900-6903",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 0,
  "_primary_term" : 1
}
~~~

# Reading back our document

- GET, "{INDEX_NAME}/_doc/{DOC_ID}"

~~~shell
curl -k --user admin:admin \
  https://localhost:9200/contact-list/_doc/0000-0003-0900-6903?pretty
~~~

# Read document response

~~~json
{
  "_index" : "contact-list",
  "_id" : "0000-0003-0900-6903",
  "_version" : 1,
  "_seq_no" : 0,
  "_primary_term" : 1,
  "found" : true,
  "_source" : {
    "name" : "Robert",
    "email" : "rsdoiel@caltech.edu",
    "orcid" : "0000-0003-0900-6903"
  }
}
~~~

# Searching for our document

- GET, `{INDEX_NAME}/_search?q=robert`

~~~shell
curl -k --user admin:admin \
  https://localhost:9200/contact-list/_search?q=robert | \
  jq .
~~~

NOTE: The "`?pretty`" option doesn't work on "`_search`" queries.
But we have "`jq .`" to help us out.

# Search results

~~~json
{
  "took": 5,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 1,
      "relation": "eq"
    },
    "max_score": 0.2876821,
    "hits": [
      {
        "_index": "contact-list",
        "_id": "0000-0003-0900-6903",
        "_score": 0.2876821,
        "_source": {
          "name": "Robert",
          "email": "rsdoiel@caltech.edu",
          "orcid": "0000-0003-0900-6903"
        }
      }
    ]
  }
}
~~~

# Retrieving an index's contents

- GET, `{INDEX_NAME}/_search`

~~~shell
curl -k --user admin:admin -X GET https://localhost:9200/contact-list/_search?pretty
~~~

NOTE: When you get lots of results (more than one "page") you can
iterate over the pages. If you collect the ids you can then retrieve the documents

# The retrieved index's response

~~~json
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 1,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "contact-list",
        "_id" : "0000-0003-0900-6903",
        "_score" : 1.0,
        "_source" : {
          "name" : "Robert",
          "email" : "rsdoiel@caltech.edu",
          "orcid" : "0000-0003-0900-6903"
        }
      }
    ]
  }
}
~~~

# Retrieving the specific document with an `_id`

~~~shell
curl -k --user admin:admin \
  https://localhost:9200/contact-list/_doc/0000-0003-0900-6903?pretty
~~~

And the response:

~~~json
{
  "_index" : "contact-list",
  "_id" : "0000-0003-0900-6903",
  "_version" : 1,
  "_seq_no" : 3,
  "_primary_term" : 1,
  "found" : true,
  "_source" : {
    "name" : "Robert",
    "email" : "rsdoiel@caltech.edu",
    "orcid" : "0000-0003-0900-6903"
  }
}
~~~

# Updating an index document

- POST, `{INDEX_NAME}/_doc/{DOC_ID}`

In update, I will add a website field.

~~~shell
curl -k --user admin:admin \
  -H 'Content-Type: application/json' \
  --data '{"name":"Robert","email":"rsdoiel@caltech.edu","orcid":"0000-0003-0900-6903","url":"https://rsdoiel.github.io"}' \
  -X POST https://localhost:9200/contact-list/_doc/0000-0003-0900-6903?pretty
~~~

# Update response

~~~json
{
  "_index" : "contact-list",
  "_id" : "0000-0003-0900-6903",
  "_version" : 2,
  "result" : "updated",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 4,
  "_primary_term" : 1
}
~~~

# Dropping document

- DELETE, `{INDEX_NAME}/_doc/{DOC_ID}`

~~~shell
curl -k --user admin:admin \
  -X DELETE https://localhost:9200/contact-list/_doc/0000-0003-0900-6903?pretty
~~~

# Dropping document response

~~~json
{
  "_index" : "contact-list",
  "_id" : "0000-0003-0900-6903",
  "_version" : 3,
  "result" : "deleted",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 2,
  "_primary_term" : 1
}
~~~

# Adding back our deleted document

~~~shell
curl -k --user admin:admin \
  -H 'Content-Type: application/json' \
  --data '{"name": "Robert", "email": "rsdoiel@caltech.edu", "orcid": "0000-0003-0900-6903"}' \
  -X POST https://localhost:9200/contact-list/_doc/0000-0003-0900-6903?pretty
~~~

# Response from adding back our document

~~~json
{
  "_index" : "contact-list",
  "_id" : "0000-0003-0900-6903",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 3,
  "_primary_term" : 1
}
~~~

NOTE: We can actually do an "add" with a POST, the "`_version`" is set back to "1".

# Dumping our index with elasticdump

<https://inveniordm.docs.cern.ch/develop/howtos/backup_search_indices/#elasticdump>

Dumping our index data:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
   --input https://admin:admin@localhost:9200/contact-list \
   --output contact-list.data.json \
   --type data
~~~

If we had created an "index map" we'd want to dump that too.

For index mappings:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
   --input https://admin:admin@localhost:9200/contact-list \
   --output contact-list.mappings.json \
   --type mapping
~~~

# Here's what our data dump looks like

~~~json
jq . contact-list-data.json
{
  "_index": "contact-list",
  "_id": "0000-0003-0900-6903",
  "_score": 1,
  "_source": {
    "name": "Robert",
    "email": "rsdoiel@caltech.edu",
    "orcid": "0000-0003-0900-6903"
  }
}
~~~

# Dropping an index

- DELETE, `{INDEX_NAME}`

~~~shell
curl -k --user admin:admin \
  -X DELETE https://localhost:9200/contact-list
~~~

The response should look like

~~~json
{"acknowledged":true}
~~~

# Restoring an index with elasticdump


For index data:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
   --input contact-list.data.json \
   --output https://admin:admin@localhost:9200/contact-list \
   --type data
~~~

For index mapping:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
   --input contact-list.mappings.json \
   --output https://admin:admin@localhost:9200/contact-list \
   --type mapping
~~~

# What we've learned so far

- Basic interactions of OpenSearch REST API
- Basic management actions
  - create, read, search, update, delete
- Backup and restore with `elasticdump`

------------------

# Part: III: Future topics to explore

OpenSearch provides many additional features

- Improves search results using index mapping
  <https://opensearch.org/docs/latest/field-types/>
- Support analytics with aggregations
  <https://opensearch.org/docs/latest/aggregations/>

Both are used heavily in Invenio RDM

# Future topics to explore (continued)

OpenSearch provides many additional features

- Process data sets with ingest pipelines
  <https://opensearch.org/docs/latest/ingest-pipelines/>
- Improve results with text analysis
  <https://opensearch.org/docs/latest/analyzers/>
- GIS visualization
  <https://opensearch.org/docs/latest/dashboards/visualize/maps/>
- ML support
  <https://opensearch.org/docs/latest/ml-commons-plugin/>

# Tooling for OpenSearch

- JSON REST API running on port 9200
- OpenSearch Dashboard
- 3rd party tooling
  - elasticdump (NodeJS/NPM)
  - curator (Python)
  - curl

# Interesting API end points

- `_settings`
- `_aliases`
- `_search`
- `_mapping`
- `_source`
- `_doc`

------------------

# Concluding

- Thank you!

# About

- Caltech Library Digital Library Development Group
- <https://caltechlibrary.github.io/opensearch-machine>
- <https://github.com/caltechlibrary/opensearch-machine>
- Issues <https://github.com/caltechlibrary/opensearch-machine/issues>


