#ddev-generated

# PATH
fish_add_path /usr/games

# fzf
fish_add_path /opt/fzf/bin
function fish_user_key_bindings
  fzf --fish | source
end

# z.lua
mkdir -p /mnt/ddev-global-cache/z.lua/$HOSTNAME
set -x _ZL_DATA /mnt/ddev-global-cache/z.lua/$HOSTNAME/.zlua
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
  set --local title "$DDEV_PROJECT/ddev: "(fish_prompt_pwd_dir_length=1 prompt_pwd)
  if count $argv > /dev/null
    set title "$argv - $title"
  end
  echo $title
end

# A helper env var to be used from bash scripts
set -x IS_FISH_SHELL 1
if status --is-interactive
  set -x IS_FISH_INTERACTIVE_SHELL 1
end
