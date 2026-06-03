#ddev-generated

# Most things will be inheritted from pimp-my-shell.sh run by .bashrc.d because
# fish is run by bash as that what it does with custom commands like `ddev fish`
# Only add fish additions here

# fzf
fzf --fish | source

# fzf-git
source /opt/fzf-git.sh/fzf-git.fish

# z.lua
lua /opt/z.lua/z.lua --init fish | source

# fish
mkdir -p /mnt/ddev-global-cache/fishhistory/$HOSTNAME
# workaround to keep the history file accross restarts
# https://fishshell.com/docs/current/cmds/history.html#customizing-the-name-of-the-history-file
# I am not using $XDG_DATA_HOME as that would change a lot of things, I rather
# just keep things default and do this cp workaround.
function handler --on-event fish_postexec
    cp ~/.local/share/fish/fish_history /mnt/ddev-global-cache/fishhistory/$HOSTNAME/fish_history
end
if test -f /mnt/ddev-global-cache/fishhistory/$HOSTNAME/fish_history
  cp /mnt/ddev-global-cache/fishhistory/$HOSTNAME/fish_history ~/.local/share/fish/fish_history
end

function fish_title
  set --local title (
    printf "%s%s/ddev: %s" \
      "$PIMP_MY_SHELL_TITLE_PREFIX" \
      "$DDEV_PROJECT" \
      (fish_prompt_pwd_dir_length=1 prompt_pwd)
  )
  if count $argv > /dev/null
    set title "$argv - $title"
  end
  echo $title
end

# A helper env var to be used from bash scripts
set -x IS_FISH_SHELL 1
if status --is-interactive
  set -x IS_FISH_INTERACTIVE_SHELL 1
  set -e DDEV_PIMP_MY_SHELL_NON_INTERACTIVE
  set -x DDEV_PIMP_MY_SHELL_INTERACTIVE true
end

# eza aliases
# https://gist.github.com/AppleBoiy/04a249b6f64fd0fe1744aff759a0563b
function ls --wraps eza --description "alias ls='eza --color=always --group-directories-first --icons'"
    eza --color=always --group-directories-first --icons $argv
end

function ll --wraps eza --description "eza -la --icons --octal-permissions --group-directories-first"
    eza -la --icons --octal-permissions --group-directories-first $argv
end

# Make child processes treat fish as the current/default shell for this session
set -gx SHELL (command -v fish)
