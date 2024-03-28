#!/bin/bash
#ddev-generated
set -e -o pipefail

for f in /var/www/html/.ddev/pimp-my-shell/hooks/post-import-db.d/*; do
  if [ -x $f ]; then
    $f;
  fi
done
