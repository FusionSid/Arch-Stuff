PS1="%n@%m %~$ "

# Oh My Zsh stuff
export ZSH="/usr/share/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  python
)

source $ZSH/oh-my-zsh.sh

# Pip
PATH="/home/sid/.local/bin:$PATH"

# aliases
alias update="sudo pacman -Syu"