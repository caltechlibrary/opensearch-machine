---
title: "Opensearch Machine"
author: "R. S. Doiel, <rsdoiel@caltech.edu>"
institute: |
  Caltech Library,
  Digital Library Development
description: Brief discussion about Opensearch running under Multipass managed virtual machines
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
keywords: [ "searching", "opensearch" ]
url: "https://caltechlibrary.github.io/opensearch-machine/blob/main/presentation.md"
---

# Opensearch Machine

## Learning and exploring Opensearch using a Multipass managed virtual machine

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
- using a program called `curl` to work with Opensearch
- using a web browser
- light text editing

# Before you start

1. Make sure Multipass is installed and working
2. Know how to launch, start, stop, delete, purge your virtual machine

# Getting started

1. Run `./opensearch-machine.bash` to create the `opensearch-machine` virtual machine
2. Run `multipass shell opensearch-machine` to finish setting things up

## On, opensearch-marchine

1. Run `01-setup-scripts.bash`
2. Run `07-add-opensearch.bash`

## On your host machine

1. Use `multipass info opensearch-machine` to find the IP address of the virtual machine
2. 

# Finishing installation

- TBD

# Starting up Opensearch and Opensearch Dashboard

- TBD

# What is an index?

- TBD

# Creating indexes

- TBD

# Indexing 

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
- <https://caltechlibrary.github.io/opensearch-machine>
- <https://github.com/caltechlibrary/opensearch-machine>
- Issues <https://github.com/caltechlibrary/opensearch-machine/issues>


