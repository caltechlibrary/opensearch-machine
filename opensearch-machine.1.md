---
title: "opensearch-machine.bash(1) user manual"
pubDate: 2024-03-08
author: "R. S. Doiel"
---

# NAME

opensearch-machine.bash

# SYNOPSIS

opensearch-machine.bash [MACHINE_NAME] [CLOUD_INIT_FILE]

# DESCRIPTION

Create and launch a Multipass managed virtual machine.

# MACHINE_NAME

By default opensearch-machine.bash creates a virtual machine named
"opensearch-machine", you can provide a different name.

# CLOUD_INIT_FILE

If you name your own machine then you may also use this
script to specify your own cloud init file. The cloud init
file must end in the ".yaml" extension.

# OPTIONS

help, -h, --help
: Display this help page.

# EXAMPLES

Creating the Opensearch Machine using Cloud Init and Multipass
from this repository.

~~~sh
./opensearch-machine.bash
~~~

This will take a while once completed you will have a Multipass
managed virtual machine running called "opensearch-machine".

