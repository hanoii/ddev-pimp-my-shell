#ddev-generated

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# This is so that child processes have appropriate access to this var
export SHELL

# Default $EDITOR to vim
export EDITOR=${DDEV_PIMP_MY_SHELL_EDITOR-/usr/bin/vim}

# ahoy
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# fzf
source /opt/.fzf.bash

# fzf-git
source /opt/fzf-git.sh/fzf-git.sh

# z.lua
mkdir -p /mnt/ddev-global-cache/z.lua/${HOSTNAME}
_ZL_DATA=/mnt/ddev-global-cache/z.lua/${HOSTNAME}/.zlua
export _ZL_DATA
if [[ "$BASHOPTS" =~ login_shell ]]; then
  eval "$(lua /opt/z.lua/z.lua --init bash enhanced once fzf)"
fi

# starship prompt
function set_win_title(){
  echo -ne "\033]0; ddev[$DDEV_PROJECT]@$PWD - $@\007"
}
starship_precmd_user_func="set_win_title"
eval "$(starship init bash)"
trap "set_win_title \${BASH_COMMAND}" DEBUG
