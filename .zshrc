
export SHELL=/usr/bin/zsh
export PATH=$HOME/.bin:$HOME/.local/bin:$PATH
# Path to oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh-custom"
# Path to fzf installation.
export FZF_BASE="$HOME/.local/fzf"
# Always use vim
export EDITOR=nvim

ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_UPDATE="true"

if [[ -n $SSH_CONNECTION ]]; then
    # Do not start tmux if on a remote terminal
    ZSH_TMUX_AUTOSTART=false
    ZSH_TMUX_AUTOQUIT=false
else
    ZSH_TMUX_AUTOSTART=true
    ZSH_TMUX_AUTOCONNECT=true
    ZSH_TMUX_AUTOQUIT=true
fi

ZSH_TMUX_CONFIG=~/.config/tmux/tmux.conf
ZSH_TMUX_UNICODE=true

plugins=(common-aliases gitfast fzf fzf-extra docker sudo tmux)

source $ZSH/oh-my-zsh.sh
source ~/.config/p10k/p10k.zsh

unsetopt autocd

alias config='git --git-dir=$HOME/.config/dot --work-tree=$HOME $@'
alias sudo='sudo '
alias vi=nvim
alias vim=nvim
alias vimdiff=nvim -d
alias ls='ls -h --color=auto --group-directories-first'
alias pbcopy='xclip -selection clipboard'
