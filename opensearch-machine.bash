#!/bin/bash
#
APP_NAME="$(basename "$0")"

function usage() {
	cat <<EOT
---
title: "${APP_NAME}(1) user manual"
pubDate: 2024-03-08
author: "R. S. Doiel"
---

# NAME

${APP_NAME}

# SYNOPSIS

${APP_NAME} [MACHINE_NAME] [CLOUD_INIT_FILE]

# DESCRIPTION

Create and launch a Multipass managed virtual machine.

# MACHINE_NAME

By default ${APP_NAME} creates a virtual machine named
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
./${APP_NAME}
~~~

This will take a while once completed you will have a Multipass
managed virtual machine running called "opensearch-machine".

EOT
}

#
# Main processing
#
VM_NAME="opensearch-machine"
CLOUD_INIT="opensearch-init.yaml"
# shellcheck disable=SC2068
for ARG in $@; do
	case "${ARG}" in
	  help|-h|--help)
	  usage
	  exit 0
	  ;;
	  *.yaml)
	  CLOUD_INIT="$ARG"
	  ;;
	  *)
	  VM_NAME="$ARG"
	  ;;
	esac
done


if [ "$1" != "" ]; then
	VM_NAME="$1"
fi
if [ "$2" != "" ]; then
	CLOUD_INIT="$2"
fi
if [ ! -f "$CLOUD_INIT" ]; then
	echo "Missing cloud init file. Try '${APP_NAME} help'"
	exit 1
fi
echo "Creating ${VM_NAME} using ${CLOUD_INIT}"
multipass launch -v --name "${VM_NAME}" \
          --disk 50G \
          --memory 2G \
          --cloud-init "${CLOUD_INIT}"
multipass info "${VM_NAME}"
cat <<EOT

 You are now ready to start working with ${VM_NAME}. Run

     multipass shell ${VM_NAME}

 To access your virtual machine. You then need to run the
 following to configure the "ubuntu" account to do further
 installation of software.

     bash ./sbin/01-setup-scripts.bash

EOT
