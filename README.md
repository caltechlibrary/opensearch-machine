# Opensearch Machine

This repository contains instructions for setting up a [Multipass](https://multipass.run) managed virtual machine for learning and experimentation Opensearch. Multipass runs on macOS, Windows and Linux. It provides an Ubuntu Linux machine. Opensearch while written in Java is tailored to run under a Linux environment. Opensearch is a full text search engine based on a forked implementation of Elasticsearch full text search engine. Opensearch is the search engine used in Invenio-RDM.

[![License](https://img.shields.io/badge/License-BSD--like-lightgrey)](https://github.com/caltechlibrary/opensearch-machine/blob/main/LICENSE)
[![Latest release](https://img.shields.io/github/v/release/caltechlibrary/opensearch-machine.svg?color=b44e88)](https://github.com/caltechlibrary/opensearch-machine/releases)
<!-- [![DOI](https://img.shields.io/badge/dynamic/json.svg?label=DOI&style=flat-square&colorA=gray&colorB=navy&query=$.pids.doi.identifier&uri=https://data.caltech.edu/api/records/1n20b-6y141/versions/latest)](https://data.caltech.edu/records/1n20b-6y141/latest) -->


## Table of contents

* [Introduction](#introduction)
* [Quick start](#quick-start)
* [Usage](#usage)
* [Known issues and limitations](#known-issues-and-limitations)
* [Getting help](#getting-help)
* [Contributing](#contributing)
* [License](#license)
* [Acknowledgments](#acknowledgments)


## Introduction

This repository is focused on creating a Multipass virtual machine for learning and exploring Opensearch. It includes brief instructions for installation of Opensearch and Opensearch Dashboard running under a Multipass managed virtual machine. It includes documentation describing how to create a indexes, index aliases and backing up those indexes outside the virtual machine.

## Quick start

Use the [opensearch-init.yaml](opensearch-init.yaml) file to create a Multipass managed virtual machine. Then run the numbered scripts found in `/usr/local/sbin` to complete the installation process.

### Creating (Launching) the virtual machine with Multipass

```sh
multipass launch --name opensearch-machine
          --disk 50G \
          --memory 2G \
          --cloud-init opensearch-init.yaml
```

### Working in your virtual machine

```sh
multipass shell opensearch-machine
```

### Setting finishing the search

While in the shell of your virtual machine (you are the "ubuntu" user) run the following scripts.

```sh
/usr/local/sbin/01-add-python-packages.bash
/usr/local/sbin/06-add-opensearch.bash
```

At this point you should have Opensearch and opensearch Dashboard running in your virtual machine, ready to explore.

## Usage

Once you have your virtual machine up and running with Opensearch and the Opensearch dashboard you should be able to access it from your host machine using SSH port mapping to interact with the Opensearch REST API and the Opensearch dashboard.

## Known issues and limitations

These instructions focus on running Opensearch for the purpose of learning and experimentation. It does not cover setup and configuration of running Opensearch in a production environment. There are many additional considerations in that setting. Consult the [Opensearch](https://opensearch.org) website and your system administrator(s) to explore those issues.

## Getting help

If you can questions, problems or suggestions regarding this repository software and documentation please file a GitHub [issue](https://github.com/caltechlibrary/opensearch-machine/issues).

## License

Software produced by the Caltech Library is Copyright © 2024 California Institute of Technology. This software is freely distributed under a modified BSD 3-clause license. Please see the [LICENSE](LICENSE) file for more information.


## Acknowledgments

I'd like to thank the [Caltech Library Digital Library](https://caltechlibary.github.io) development group for their inspiration and support in this project.

This work was funded by the California Institute of Technology Library.

<div align="center">
  <br>
  <a href="https://www.caltech.edu">
    <img width="100" height="100" alt="Caltech logo" src="https://raw.githubusercontent.com/caltechlibrary/template/main/.graphics/caltech-round.png">
  </a>
</div>
