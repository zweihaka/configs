# Created by newuser for 5.9
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz compinit && compinit

alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

PROMPT='%F{2}%n@%m%f:%F{4}%~%f$ '
