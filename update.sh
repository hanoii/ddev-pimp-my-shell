#!/bin/bash

set -euo pipefail

VERSION_FILES=(web-build/*.pimp-my-shell)

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

strip_tag_prefix() {
  local tag=$1
  local prefix=$2

  if [[ -n "$prefix" ]]; then
    [[ "$tag" == "$prefix"* ]] || die "Expected tag '$tag' to start with '$prefix'"
    tag=${tag:${#prefix}}
  fi

  printf '%s\n' "$tag"
}

latest_github_release() {
  local repo=$1
  local strip_prefix=$2
  local latest_url
  local tag

  latest_url=$(curl -fsSL -o /dev/null -w '%{url_effective}' "https://github.com/${repo}/releases/latest")
  tag=${latest_url##*/}

  strip_tag_prefix "$tag" "$strip_prefix"
}

latest_github_commit_head() {
  local repo=$1

  gh api "repos/${repo}/commits" --jq '.[0].sha'
}

latest_fish_debian_version() {
  local timestamp

  timestamp=$(date +%s)
  curl -fsSL "https://download.opensuse.org/download/repositories/shells:/fish:/release:/4/Debian_12/?jsontable&_=${timestamp}" |
    jq -r '.data | .[] | select(.name | endswith(".dsc")) | .name' |
    sort -r |
    head -1 |
    sed 's/fish_\(.*\)\.dsc/\1/g'
}

latest_go_version() {
  curl -fsSL "https://go.dev/VERSION?m=text" |
    head -1 |
    sed 's/^go//'
}

replace_assignment() {
  local variable=$1
  local version=$2

  UPDATE_VARIABLE=$variable UPDATE_VERSION=$version perl -pi -e '
    BEGIN {
      $variable = $ENV{UPDATE_VARIABLE};
      $version = $ENV{UPDATE_VERSION};
      $changed = 0;
    }

    $changed += s@(\b\Q$variable\E=)[^\s;]*(.*)@$1$version$2@g;

    END {
      exit($changed ? 0 : 2);
    }
  ' "${VERSION_FILES[@]}" || die "No assignment found for $variable"
}

record_update() {
  local message=$1
  local variable=$2
  local version=$3

  [[ -n "$version" ]] || die "Empty version for $variable"
  printf '%s: %s\n' "$message" "$version"
  replace_assignment "$variable" "$version"
}

run_update() {
  local source=$1
  local message=$2
  local variable=$3
  local source_arg=$4
  local tag_prefix=$5
  local version

  case "$source" in
    github_release)
      version=$(latest_github_release "$source_arg" "$tag_prefix")
      ;;
    github_commit_head)
      version=$(latest_github_commit_head "$source_arg")
      ;;
    fish_debian)
      version=$(latest_fish_debian_version)
      ;;
    go_current)
      version=$(latest_go_version)
      ;;
    *)
      die "Unknown update source '$source'"
      ;;
  esac

  record_update "$message" "$variable" "$version"
}

# source|message|target variable|source argument|tag prefix to remove
# Empty tag prefix keeps upstream tag intact, e.g. z.lua stores v1.8.25.
UPDATES=(
  "github_release|GitHub CLI version|GH_VERSION|cli/cli|v"
  "github_release|ahoy version|AHOY_VERSION|ahoy-cli/ahoy|v"
  "github_release|fzf version|FZF_VERSION|junegunn/fzf|v"
  "github_commit_head|fzf-git.sh (bash) latest commit SHA1|FZFGIT_SHA1|junegunn/fzf-git.sh|"
  "github_release|bat version|BAT_VERSION|sharkdp/bat|v"
  "github_release|fd version|FD_VERSION|sharkdp/fd|v"
  "github_release|z.lua version|ZLUA_VERSION|skywind3000/z.lua|"
  "github_release|starship version|STARSHIP_VERSION|starship/starship|v"
  "github_release|gum version|GUM_VERSION|charmbracelet/gum|v"
  "fish_debian|fish debian version from opensuse|FISH_VERSION||"
  "github_release|eza version|EZA_VERSION|eza-community/eza|v"
  "go_current|go version|GO_VERSION||"
  "github_release|fisher (fish) version|FISHER_VERSION|jorgebucaran/fisher|"
  "github_release|tide (fish) version|TIDE_VERSION|IlanCosman/tide|v"
  "github_release|bass (fish) version|BASS_VERSION|edc/bass|v"
  "github_release|bun version|BUN_VERSION|oven-sh/bun|bun-v"
  "github_release|sysbox (go) version|SYSBOX_VERSION|skx/sysbox|release-"
  "github_release|recur (go) version|RECUR_VERSION|dbohdan/recur|v"
  "github_release|rust version|RUST_VERSION|rust-lang/rust|"
  "github_release|spacer (rust) version|SPACER_VERSION|samwho/spacer|v"
  "github_release|git-delta (rust) version|DELTA_VERSION|dandavison/delta|"
  "github_release|kitty version|KITTY_VERSION|kovidgoyal/kitty|v"
  "github_release|terminaltexteffects version|TTE_VERSION|ChrisBuilds/terminaltexteffects|release-"
  "github_release|lazygit version|LAZYGIT_VERSION|jesseduffield/lazygit|v"
  "github_release|ov - feature rich terminal pager version|OV_VERSION|noborus/ov|v"
  "github_commit_head|multitail latest commit SHA1|MULTITAIL_SHA1|folkertvanheusden/multitail|"
  "github_release|tmux version|TMUX_VERSION|tmux/tmux|"
  "github_release|DigitalOcean CLI version|DOCTL_VERSION|digitalocean/doctl|v"
  "github_release|Task version|TASK_VERSION|go-task/task|v"
)

for update in "${UPDATES[@]}"; do
  IFS='|' read -r source message variable source_arg tag_prefix <<< "$update"
  run_update "$source" "$message" "$variable" "$source_arg" "$tag_prefix"
done

if git diff --exit-code -- "${VERSION_FILES[@]}"; then
  printf '\nThere are currently no available upgrades.\n'
else
  ddev add-on get . >/dev/null 2>&1
fi
