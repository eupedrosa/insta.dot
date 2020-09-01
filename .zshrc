
export SHELL=/usr/bin/zsh
export PATH=$HOME/.bin:$HOME/.local/bin:$PATH
# Path to oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh-custom"
# Path to fzf installation.
export FZF_BASE="$HOME/.local/fzf"
# Always use vim
export EDITOR=nvim

DISABLE_AUTO_UPDATE="true"

ZSH_TMUX_CONFIG=~/.config/tmux/tmux.conf
ZSH_TMUX_UNICODE=true

plugins=(common-aliases git fzf fzf-extra docker sudo)

source $ZSH/oh-my-zsh.sh

eval $(starship init zsh)

unsetopt autocd

alias config='git --git-dir=$HOME/.config/dot --work-tree=$HOME $@'
alias sudo='sudo '
alias vi=nvim
alias vim=nvim
alias vimdiff=nvim -d
alias ls='ls -h --color=auto --group-directories-first'
alias pbcopy='xclip -selection clipboard'
