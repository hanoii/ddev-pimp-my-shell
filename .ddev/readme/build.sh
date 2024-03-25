#!/bin/bash
#ddev-generated
set -e -o pipefail

prettier /var/www/html/README.md --write --config=/var/www/html/.ddev/readme/.prettierrc
markdown-toc -i /var/www/html/README.md
