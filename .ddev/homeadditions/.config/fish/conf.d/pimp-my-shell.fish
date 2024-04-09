#ddev-generated

# z.lua
mkdir -p /mnt/ddev-global-cache/z.lua/$HOSTNAME
set -x _ZL_DATA /mnt/ddev-global-cache/z.lua/$HOSTNAME/.zlua
lua /opt/z.lua/z.lua --init fish | source

# fish
mkdir -p /mnt/ddev-global-cache/fishhistory/$HOSTNAME
# workaround to keep the history file accross restarts
[ -f ~/.local/share/fish/fish_history ] && [ ! -L ~/.local/share/fish/fish_history ] && mv ~/.local/share/fish/fish_history /mnt/ddev-global-cache/fishhistory/$HOSTNAME/fish_history
[ ! -f ~/.local/share/fish/fish_history ] && touch /mnt/ddev-global-cache/fishhistory/$HOSTNAME/fish_history
ln -fs /mnt/ddev-global-cache/fishhistory/$HOSTNAME/fish_history ~/.local/share/fish/fish_history

function fish_title
  echo "$DDEV_PROJECT ddev@"(fish_prompt_pwd_dir_length=1 prompt_pwd) - $argv
end
