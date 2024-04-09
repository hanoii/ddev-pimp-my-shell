#ddev-generated

# z.lua
mkdir -p /mnt/ddev-global-cache/z.lua/$HOSTNAME
set -x _ZL_DATA /mnt/ddev-global-cache/z.lua/$HOSTNAME/.zlua
lua /opt/z.lua/z.lua --init fish | source

function fish_title
  echo "$DDEV_PROJECT ddev@"(fish_prompt_pwd_dir_length=1 prompt_pwd) - $argv
end
