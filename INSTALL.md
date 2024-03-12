
# Installation and setup of this repository

This repository is designed to provide an easy setup of OpenSearch using Multipass and cloud init files.

The following are required to run the examples documented here.

- Bash 3.2 or better
- Multipass 1.13 or better

To build the website, prepare documentation and maintain the repository you need the following
available.

- Git 2.3 or better
- GNU Make 3.8 or better
- Pandoc 3.1 or better
- PageFind 1.0.4 or better (used to provide static site search)
- Python 3.x or better (provides an easy way to run a "localhost" web server)
- A web browser (e.g. Firefox)
- A plain text editor (e..g VS Code, vi, emacs, nano, micro)

## Steps to improve repository contents

1. Clone this repository and change into repository directory
2. Verify that the software is available to rebuild the website
3. Re-build the website using `make website`
4. Start up a localhost web service
5. Check with a web browser to see how it looks

Here's the command I run to get things going.

~~~sh
git --version
# Make sure I have a recent git available.
git clone https://github.com/caltechlibrary/opensearch-machine
cd opensearch-machine
make check_software
make website
python3 -m http.server
~~~

At this point I can point my web browser at <http://localhost:8000> and see the
website.

