
# OpenSearch v2.x

You can go to [OpenSearch website](https://opensearch.org/versions/opensearch-2-3-0.html) and download the appropriate OpenSearch program. The v2.11.1 release is subject of these instructions. It is more recent than the one shipped in Invenio-RDM 11 but does install via a Debian package successfully as of March 2024. While OpenSearch is written in Java and should run on systems that support Java the "proc" file system is used in some of it's components so it is happiest running under Linux. These instructions presume running under Ubuntu/Debian Linux and will focus on that.  [Multipass](https://multipass.run) runs on macOS, Windows 11 and Linux. Multipass will provided you with an Ubuntu virtual machine that closely matches what we use in production on AWS as well is that operating systems we use on physical machines in our server room.

On the OpenSearch downloads page under the Linux Platform select box you can pick the CPU type and "Deb" releases. This is what will be used in the cloud-init file provided in this repository.

This repository includes a copy of [opensearch-init.yaml](OpenSearch-init.yaml) from our [cloud-init-examples](https://github.com/caltechlibrary/cloud-init-examples) repository. This version of `OpenSearch-init.yaml` is tuned to support OpenSearch and also provides the full "Newt" setup as that is an easy way to generate applications for experimenting with OpenSearch.

These instructions do not supersede the documentation on OpenSearch.org at <https://opensearch.org/docs/latest/install-and-configure/install-opensearch/debian/> and <https://opensearch.org/docs/latest/install-and-configure/install-dashboards/debian/>.

OpenSearch runs a REST API on the default port 9200 of localhost (e.g. <http://localhost:9200/>) in the virtual machine. OpenSearch Dashboard runs on port 5601 of localhost (e.g. <http://localhost:5601>) in the virtual machine.


## Managing OpenSearch on Debian/Ubuntu

OpenSearch is setup up for `systemd`. Below are common `systemctl` commands for working with the OpenSearch service.

If you want manual restart just do `daemon-reload`, then use the usual `systemctl` start and stop verbs with `opensearch.service`.

```sh
sudo systemctl daemon-reload
sudo systemctl enable opensearch.service
```

Checking to see if OpenSearch is running.

```sh
sudo systemctl status opensearch.service
```

Starting OpenSearch

```sh
sudo systemctl start opensearch.service
```

Stopping OpenSearch

```sh
sudo systemctl stop opensearch.service
```

To remove OpenSearch from auto start use the usually systemd
disable.

```sh
sudo systemctl disable opensearch.service
```

