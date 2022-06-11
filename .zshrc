# Oh My Zsh stuff
export ZSH="usr/share/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
)

ZSH_CACHE_DIR=$HOME/.config/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]: then
    mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Terminal Text
PS1="%n@%m %~$ "