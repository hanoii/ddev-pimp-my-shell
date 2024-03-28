#!/bin/bash
#ddev-generated
set -e -o pipefail

boxes_args=${DDEV_PIMP_MY_SHELL_DRUSH_ULI_BOXES_FORMAT-"-d peek -p h3v1"}
if [[ "$DDEV_PROJECT_TYPE" == *"drupal"* ]] || [[ "$DDEV_PIMP_MY_SHELL_PROJECT_TYPE" == *"drupal"* ]]; then
  uli=$(drush uli "$@")
  echo -e "\033[1;32m"
  echo $uli | boxes $boxes_args
  echo -en "\033[0m"
else
  gum log --level debug "Not drupal"
  exit 1
fi
