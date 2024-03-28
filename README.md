[![tests](https://github.com/hanoii/ddev-pimp-my-shell/actions/workflows/tests.yml/badge.svg)](https://github.com/hanoii/ddev-pimp-my-shell/actions/workflows/tests.yml)
![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

# ddev-pimp-my-shell <!-- omit in toc -->

<!-- toc -->

- [What is ddev-pimp-my-shell?](#what-is-ddev-pimp-my-shell)
- [ddev `post-import-db` hook](#ddev-post-import-db-hook)

<!-- tocstop -->

<!-- stoptoc -->

## What is ddev-pimp-my-shell?

This a an addon that adds several nice command line utitlites I use across all
projects, making it easier/nicer to work inside the container with some initial
defaults.

- https://github.com/ahoy-cli/ahoy
- https://github.com/skywind3000/z.lua
- https://github.com/junegunn/fzf
- https://github.com/junegunn/fzf-git.sh
- https://starship.rs/
- https://github.com/charmbracelet/gum

It also has:

- Some useful [scripts](pimp-my-shell/scripts)

## ddev `post-import-db` hook

I generally have import scripts that I ship either from other add-ons or
specific to projects and those scripts usually download the database from within
the container. Rather than downloading the database and then running
`ddev import-db --file=` I wanted to provide a way so that either way runs all
of my post-import-db commands both with the ddev import command as well as from
any helper script from within the project.

So the way this works is that you can run
`/var/www/html/.ddev/pimp-my-shell/hooks/post-import-db.sh` from any script that
will be run in the container and it will take care of running all scripts on
`.ddev/pimp-my-shell/post-import-db.d/`.

This also allows for other add-ons to add scripts to this directory so that they
will be run.

Example on how I am using it:

- https://github.com/hanoii/ddev-platformsh-lite/blob/ce4b95d578e82f942b75ec9fa6fa60f63473c90b/platformsh-lite/scripts/db-pull.sh#L91
- https://github.com/hanoii/ddev-platformsh-lite/blob/ce4b95d578e82f942b75ec9fa6fa60f63473c90b/pimp-my-shell/hooks/post-import-db.d/00-drupal.sh

**Contributed and maintained by [@hanoii](https://github.com/hanoii)**
