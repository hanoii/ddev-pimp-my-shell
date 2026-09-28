#!/bin/bash
#ddev-generated
set -e -o pipefail

# delta
# Written once per start, after DDEV copies the host ~/.gitconfig into the
# container, so these win over it. Doing this from shell startup instead makes
# every shell write ~/.gitconfig, and parallel shells race on its lock file.
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
