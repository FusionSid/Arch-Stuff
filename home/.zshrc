PS1="%n@%m %~$ " #incase prompt fails

# prompt
eval "$(starship init zsh)"

# Pip
PATH="/home/sid/.local/bin:$PATH"

# aliases
source ~/.aliases

# On startup
pfetch

# Terminal History 
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Terminal name
precmd () {print -Pn "\e]0;%~\a"}

# fix rofi
export LC_ALL="C"