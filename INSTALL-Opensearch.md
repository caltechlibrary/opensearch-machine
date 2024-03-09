# Opensearch v1.3.15

You can go to [Opensearch website](https://opensearch.org/versions/opensearch-1-3-15.html) and download the appropriate Opensearch program. The v1.3.15 release are the current v1 release as of February 2024. While Opensearch is written in Java and should run on systems that support Java the "proc" file system is used in some of it's components so it is happiest running under Linux. These instructions presume running under Ubuntu/Debian Linux and will focus on that.  [Multipass](https://multipass.run) runs on macOS, Windows 11 and Linux. Multipass will provided you with an Ubuntu virtual machine that closely matches what we use in production on AWS as well is that operating systems we use on physical machines in our server room.

On the Opensearch downloads page under the Linux Platform select box you can pick the CPU type and "Deb" releases. This is what will be used in the cloud-init file provided in this repository.

This repository includes a copy of [opensearch-init.yaml](opensearch-init.yaml) from our [cloud-init-examples](https://github.com/caltechlibrary/cloud-init-examples) repository. This version of `opensearch-init.yaml` is tuned to support Opensearch and also provides the full "Newt" setup as that is an easy way to generate applications for experimenting with Opensearch.

These instructions do not supersede the documentation on Opensearch.org at <https://opensearch.org/docs/latest/install-and-configure/install-opensearch/debian/> and <https://opensearch.org/docs/latest/install-and-configure/install-dashboards/debian/>.

Opensearch runs a REST API on the default port 9200 of localhost (e.g. <http://localhost:9200/>) in the virtual machine. Opensearch Dashboard runs on port 5601 of localhost (e.g. <http://localhost:5601>) in the virtual machine.


## Managing Opensearch on Debian/Ubuntu

Opensearch is setup up for `systemd`. Below are common `systemctl` commands for working with the Opensearch service.

If you want manual restart just do `daemon-reload`, then use the usual `systemctl` start and stop verbs with `opensearch.service`.

```sh
sudo systemctl daemon-reload
sudo systemctl enable opensearch.service
```

Checking to see if Opensearch is running.

```sh
sudo systemctl status opensearch.service
```

Starting Opensearch

```sh
sudo systemctl start opensearch.service
```

Stopping Opensearch

```sh
sudo systemctl stop opensearch.service
```

To remove Opensearch from auto start use the usually systemd
disable.

```sh
sudo systemctl disable opensearch.service
```

