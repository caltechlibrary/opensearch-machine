
# OpenSearch Machine

This repository contains instructions for setting up a [Multipass](https://multipass.run) managed virtual machine for learning and experimentation with OpenSearch v2.5.0. Multipass runs on macOS, Windows and Linux. It provides an Ubuntu Linux machine. OpenSearch while written in Java is tailored to run under a Linux environment. OpenSearch is a full text search engine based on a forked implementation of Elasticsearch full text search engine by Amazon. OpenSearch is the search engine used in Invenio-RDM.

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

This repository is focused on creating a Multipass virtual machine for learning and exploring OpenSearch v2.5.0[^1]. It includes brief instructions for installation of OpenSearch and elasticdump running under a Multipass managed virtual machine. It includes documentation describing how to create an index, add and remove documents as well as backing up and restoring the index in the virtual machine.

[^1]: v2.5.0 was chosen as it is the closest version to that used in Invenio-RDM v11 that I could get to install and work under Ubuntu 22.04 LTS.

## Quick start

Use the [opensearch-init.yaml](opensearch-init.yaml) file to create a Multipass managed virtual machine. Then run the numbered scripts found in `/usr/local/sbin` to complete the installation process.

### Creating (Launching) the virtual machine with Multipass

```sh
bash opensearch-machine.bash
```

### Working in your virtual machine

```sh
multipass shell opensearch-machine
```

### Setting finishing the search

While in the shell of your virtual machine (you are the "ubuntu" user) run the following scripts.

```sh
01-setup-scripts.bash
07-add-opensearch.bash
sudo reboot
```

At this point you should have OpenSearch and OpenSearch Dashboard running in your virtual machine, ready to explore.

## Stopping and removing your virtual machine

```sh
multipass stop opensearch-machine
multipass delete opensearch-machine
multipass purge
```

## Usage

Once you have your virtual machine up and running with OpenSearch and the OpenSearch dashboard you should be able to access it from your host machine using SSH port mapping to interact with the OpenSearch REST API.

You can find out more about using Multipass to manage virtual machines at <https://multipass.run>. You can find out more about OpenSearch and OpenSearch Dashboard at <https://opensearch.org/docs/latest/about/>

A [presentation](presentation.md) is included describing the basics of OpenSearch.

## Known issues and limitations

These instructions focus on running OpenSearch for the purpose of learning and experimentation. It does not cover setup and configuration of running OpenSearch in a production environment. There are many additional considerations in that setting. Consult the [OpenSearch](https://opensearch.org) website and your system administrator(s) to explore those issues.

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
