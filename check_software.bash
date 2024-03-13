#!/bin/bash

#
# Check software needed and their versions
#
function check_version() {
    OPT="$1"
	VERSION="$2"
	CMD="$3"
	MSG="$4"
	if command -v "${CMD}" >/dev/null; then
		HAS_VERSION=$("${CMD}" "${OPT}" | grep "${VERSION}")
		if [ "$HAS_VERSION" = "" ]; then
			echo "${CMD} version check: expected ${VERSION}, got $("${CMD}" "${OPT}")"
		fi
	else
		echo "${CMD} is missing$MSG"
		exit 1
	fi
}

#
# Check the OS distribution supplied tools
#
echo ""
echo "Checking Bash, GNU Make, Pandoc, PageFind, Python3 and Multipass"
echo ""
## - Bash >= 3.2 (or equivalent POSIX shell)
check_version "--version" "3.2" "bash" ""
## - Multipass >= 1.13
check_version "--version" "1.13" "multipass"  ", see <https://multipass.run> to install"

echo "You have enough to run the Multipass VM and install OpenSearch"

## - GNU Make
check_version "--version" "3.8" "make" ""
## - Pandoc >= 3.1
check_version "--version" "3.1" "pandoc" ", see <https://pandoc.org> to install"
## - Python >= 3.10
check_version "--version" "3.12" "python3" ", see <https://python.org> to install"
## - PageFind >= v1.0.4
check_version "--version" "1.0.4" "pagefind" ", see <https://pagefind.app> to install"
## - jq >= v1.7
check_version "--version" "1.7" "jq" ", see <https://jqlang.github.io/jq/> to install"

echo "Success! You appear to have the software needed to rebuild this website"
