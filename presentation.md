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
keywords: [ "search engine", "OpenSearch" ]
url: "https://caltechlibrary.github.io/opensearch_machine/blob/main/presentation.md"
---

# Part I: OpenSearch Machine

## Exploring OpenSearch using a Multipass managed virtual machine

# Knowledge requirements

- You need to comfortable with working on the command line
- General understanding of how the web works
    - HTTP, HTTP methods (e.g. GET, POST, PUT, DELETE)
    - JSON documents

# System Requirements (Host machine)

- macOS, Linux or Windows based machine (ARM or Intel CPU)
- [Multipass](https://multipass.run) needs to be installed

# Software Requirements (Host machine)

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

> Now we're ready to start working with OpenSearch

# Part II: Working with OpenSearch

We'll be using ...

- [curl](https://curl.se) (aka curl)
- [jq](https://jqlang.github.io)
- Sysadmin command `sudo systemctl ...` to start/restart OpenSearch

# Make sure OpenSearch us up and running healthy

~~~shell
sudo systemctl status opensearch.service
~~~

# Exploring OpenSearch

Check to see how OpenSearch is currently configured.
By default OpenSearch runs on https (self signed certs)
and requires "admin" account to access.

~~~shell
curl -k --user admin:admin \
  https://localhost:9200/_settings?pretty
~~~

This should return JSON which shows the settings of our OpenSearch
installation.

# A message form our sponsor

## save yourself some typing with `os_client.bash`

With this Multipass VM you'll find a simple OpenSearch client written
in Bash that uses the curl method discussed in this presentation.

Feel free to use it to follow along. If can be found at
`/usr/local/bin/os_client.bash`. You can run it with

~~~
os_client.bash
~~~

If you do not include any options it will display a help page.


# Creating our first index

- PUT, "{INDEX_NAME}"
- "{INDEX_NAME}" = 'contact-list'

~~~shell
curl -k --user admin:admin \
  https://localhost:9200/contact-list?pretty
~~~

# Creating a document in our index

- POST, "{INDEX_NAME}/_doc/{DOC_ID}"

~~~shell
curl -k --user admin:admin \
  --data '{"name": "Robert", "email": "rsdoiel@caltech.edu", "orcid": "0000-0003-0900-6903"}' \
  https://localhost:9200/contact-list/_doc/0000-0003-0900-6903?pretty
~~~

# Response from creating our document

~~~json
{
  "_index": "content-list",
  "_id": "0000-0003-0900-6903",
  "_version": 1,
  "result": "created",
  "_shards": {
    "total": 2,
    "successful": 1,
    "failed": 0
  },
  "_seq_no": 0,
  "_primary_term": 1
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
  https://localhost:9200/contact-list/_search?q=robert \
  jq .
~~~

NOTE: The `?pretty` option doesn't work on `_search` queries. That's pretty sad IMO.
But we have `jq` to help us out.

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
	"_index":"contact-list",
	"_id":"0000-0003-0900-6903",
	"_version":2,
	"result":"deleted",
	"_shards":{
		"total":2,
		"successful":1,
		"failed":0
	},
	"_seq_no":1,
	"_primary_term":1
}
~~~

# Dumping our index with elasticdump

<https://inveniordm.docs.cern.ch/develop/howtos/backup_search_indices/#elasticdump>

For index mappings:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \    
   --input https://admin:admin@localhost:9200/contact-list \
   --output contact-list.mappings.json \
   --type mapping
~~~

For index data:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \    
   --input https://admin:admin@localhost:9200/contact-list \
   --output contact-list.data.json \
   --type data
~~~

# Dropping an index

- DELETE, `{INDEX_NAME}`

~~~shell
curl -k --user admin:admin \
  -X DELETE https://localhost:9200/contact-list
~~~

# Restoring an index with elasticdump

For index mapping:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \    
   --input contact-list.mappings.json \
   --oputput https://admin:admin@localhost:9200/contact-list \
   --type mapping
~~~

For index data:

~~~shell
env NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \    
   --input contact-list.data.json \
   --oputput https://admin:admin@localhost:9200/contact-list \
   --type data
~~~

# What we've learned so far

- Basic interactions of OpenSearch REST API
- Basic management actions
  - create, read, update, delete, list, restore
- Backup and restore with `elasticdump`

Can we do better???

# Part: III, improving our indexes

- Index mapping
- Aggregations

# Creating our first index map

# Retrieving our index's mapping

- GET, '{INDEX_NAME}/_mapping'

~~~
curl https://localhost:9200/{INDEX_NAME}/_mapping?pretty=true
~~~

# Basic management activities

- Creating mapping for new indexes
- Index documents
- Managing aliases of indexes
- Manage indexes (e.g. roll ups of time series indexes)
- Providing search service

# Managing OpenSearch

- JSON REST API running on port 9200
- A "dashboard" web service
- 3rd party tooling
  - elasticdump (NodeJS/NPM)
  - curator (Python)
  - curl, Httpie

# Some JSON API end points

- `_settings`
- `_aliases`
- `_search`
- `_mapping`
- `_source`
- `_doc`

# What is an index?

- A searchable data structure for full text structured documents
- A collection "documents" expressed as JSON

# What does my OpenSearch engine manage?

- Retrieve the `_settings` JSON document with get

~~~shell
curl https://localhost:9200/_settings
~~~

# Creating a new index

<https://opensearch.org/docs/latest/api-reference/index-apis/create-index/>

- PUT `<index-name>`


# Creating a new index map

- POST of JSON document of mapping into REST API

# Populating our index

- POST to ...

# Testing our index

- GET `_search`

# Retrieving our current index map

- GET `_index_mapping`

# Retrieving the contents of an index

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

# Part III: Postscript

## What is OpenSearch?

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

# OpenSearch vs Elasticsearch

- Documentation for Elasticsearch largely applies to OpenSearch
- Tooling right now is common between the two (e.g. elasticdump)
- OpenSearch documentation looks shiny but isn't that helpful
- RDM's documentation of OpenSearch is a better place to start

# OpenSearch

- OpenSearch is Amazon's fork of Elasticsearch
- Amazon wants all the support income and is cutting out Elasticsearch Co.
- When Elasticsearch was created Solr had stagnated and was XML only
- Solr/Elasticsearch/OpenSearch are functionally equivalent but their API are different

# OpenSearch

- Today, February 2024, OpenSearch and Elasticsearch are compatible in terms of API and tooling
- Who knows what tomorrow may bring?
  - At some point Amazon will embrace and extend
  
# In conclusion

- Thank you!

# About

- Caltech Library Digital Library Development Group
- <https://caltechlibrary.github.io/opensearch-machine>
- <https://github.com/caltechlibrary/opensearch-machine>
- Issues <https://github.com/caltechlibrary/opensearch-machine/issues>


