#!/bin/bash

set -eu

_timestamp=$(date +%s)

# ahoy
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/ahoy-cli/ahoy/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "ahoy version: $VERSION"
perl -pi -e "s@AHOY_VERSION=.*@AHOY_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# fzf*
VERSION=$(curl -s "https://github.com/junegunn/fzf/commits" | grep -o 'commit/[a-f0-9]\{40\}' | head -1 | cut -d'/' -f2)
[ -n "$VERSION" ]
echo "fzf latest commit SHA1: $VERSION"
perl -pi -e "s@FZF_SHA1=.*@FZF_SHA1=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell
VERSION=$(curl -s "https://github.com/junegunn/fzf-git.sh/commits" | grep -o 'commit/[a-f0-9]\{40\}' | head -1 | cut -d'/' -f2)
echo "fzf-git.sh (bash) latest commit SHA1: $VERSION"
perl -pi -e "s@FZFGIT_SHA1=.*@FZFGIT_SHA1=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# bat
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/sharkdp/bat/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "bat version: $VERSION"
perl -pi -e "s@BAT_VERSION=.*@BAT_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# z.lua
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/skywind3000/z.lua/releases/latest" | sed 's/.*tag\///g')
[ -n "$VERSION" ]
echo "z.lua version: $VERSION"
perl -pi -e "s@ZLUA_VERSION=.*@ZLUA_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# starship (bash)
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/starship/starship/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "starship version: $VERSION"
perl -pi -e "s@STARSHIP_VERSION=.*@STARSHIP_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# gum
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/charmbracelet/gum/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "gum version: $VERSION"
perl -pi -e "s@GUM_VERSION=.*@GUM_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# fish
VERSION=$(curl -Ls "https://download.opensuse.org/download/repositories/shells:/fish:/release:/4/Debian_12/?jsontable&_=${_timestamp}" | jq -r '.data | .[] | select(.name | endswith(".dsc")) | .name' | sed 's/fish_\(.*\)\.dsc/\1/g')
[ -n "$VERSION" ]
echo "fish debian version from opensuse: $VERSION"
perl -pi -e "s@FISH_VERSION=.*@FISH_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# eza
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/eza-community/eza/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "eza version: $VERSION"
perl -pi -e "s@EZA_VERSION=.*@EZA_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# go
VERSION=$(curl -Ls "https://go.dev/VERSION?m=text" | head -1 | sed "s/go//")
[ -n "$VERSION" ]
echo "go version: $VERSION"
perl -pi -e "s@GO_VERSION=.*@GO_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# fisher
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/jorgebucaran/fisher/releases/latest" | sed 's/.*tag\///g')
[ -n "$VERSION" ]
echo "fisher (fish) version: $VERSION"
perl -pi -e "s@FISHER_VERSION=.*@FISHER_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# tide
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/IlanCosman/tide/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "tide (fish) version: $VERSION"
perl -pi -e "s@TIDE_VERSION=.*@TIDE_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# bass
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/edc/bass/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "bass (fish) version: $VERSION"
perl -pi -e "s@BASS_VERSION=.*@BASS_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# bun
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/oven-sh/bun/releases/latest" | sed 's/.*tag\/bun-v//g')
[ -n "$VERSION" ]
echo "bun version: $VERSION"
perl -pi -e "s@BUN_VERSION=.*@BUN_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# sysbox
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/skx/sysbox/releases/latest" | sed 's/.*tag\/release-//g')
[ -n "$VERSION" ]
echo "sysbox (go) version: $VERSION"
perl -pi -e "s@SYSBOX_VERSION=.*@SYSBOX_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# recur
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/dbohdan/recur/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "recur (go) version: $VERSION"
perl -pi -e "s@RECUR_VERSION=.*@RECUR_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# rust
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/rust-lang/rust/releases/latest" | sed 's/.*tag\///g')
[ -n "$VERSION" ]
echo "rust version: $VERSION"
perl -pi -e "s@RUST_VERSION=.*@RUST_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

#spacer
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/samwho/spacer/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "spacer (rust) version: $VERSION"
perl -pi -e "s@SPACER_VERSION=.*@SPACER_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# delta
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/dandavison/delta/releases/latest" | sed 's/.*tag\///g')
[ -n "$VERSION" ]
echo "git-delta (rust) version: $VERSION"
perl -pi -e "s@DELTA_VERSION=.*@DELTA_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# kitty
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/kovidgoyal/kitty/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "kitty version: $VERSION"
perl -pi -e "s@KITTY_VERSION=.*@KITTY_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# terminaltexteffects
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/ChrisBuilds/terminaltexteffects/releases/latest" | sed 's/.*tag\/release-//g')
[ -n "$VERSION" ]
echo "terminaltexteffects version: $VERSION"
perl -pi -e "s@TTE_VERSION=.*@TTE_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# lazygit
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/jesseduffield/lazygit/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "lazygit version: $VERSION"
perl -pi -e "s@LAZYGIT_VERSION=.*@LAZYGIT_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

# ov
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/noborus/ov/releases/latest" | sed 's/.*tag\/v//g')
[ -n "$VERSION" ]
echo "ov - feature rich terminal pager version: $VERSION"
perl -pi -e "s@OV_VERSION=.*@OV_VERSION=${VERSION}; \\\\@g" web-build/Dockerfile.pimp-my-shell

if git diff --exit-code web-build/Dockerfile.pimp-my-shell; then
  echo -e "\nThere are currently no available upgrades."
else
  ddev add-on get . > /dev/null 2>&1
fi
