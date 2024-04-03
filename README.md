[![tests](https://github.com/hanoii/ddev-pimp-my-shell/actions/workflows/tests.yml/badge.svg)](https://github.com/hanoii/ddev-pimp-my-shell/actions/workflows/tests.yml)
![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

# ddev-pimp-my-shell <!-- omit in toc -->

<!-- toc -->

- [What is ddev-pimp-my-shell?](#what-is-ddev-pimp-my-shell)
- [fish](#fish)
- [ddev `post-import-db` hook](#ddev-post-import-db-hook)

<!-- tocstop -->

## What is ddev-pimp-my-shell?

This a an addon that adds several nice command line utitlites I use across all
projects, making it easier/nicer to work inside the container with some initial
defaults.

- https://github.com/ahoy-cli/ahoy
- https://github.com/skywind3000/z.lua (working on both bash and fish)
- https://github.com/junegunn/fzf
- https://github.com/junegunn/fzf-git.sh
- https://starship.rs/
- https://github.com/charmbracelet/gum
- https://github.com/fish-shell/fish-shell / https://fishshell.com/

It also has:

- Some useful [scripts](pimp-my-shell/scripts)

## fish

This add-on installs:

- https://github.com/jorgebucaran/fisher
- https://github.com/IlanCosman/tide

For tide, it uses the default configuration, if you want to have your own on all
of your ddev projects you can create/edit
`.ddev/homeadditions/.config/fish/conf.d/mytide.fish` with something like the
following:

```fish
if tide --version > /dev/null && not test -f ~/.config/fish/conf.d/.mytide
  tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Light --show_time=No --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Many icons' --transient=Yes
  touch ~/.config/fish/conf.d/.mytide
end
```

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
