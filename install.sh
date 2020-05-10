#!/bin/bash
set -o errexit
set -o nounset

function install_sys_bin {
    local PACKAGES='git neovim python3-neovim python3-jedi zsh curl tmux'

    echo -e "\033[0;32mInstalling necessary packages...\033[0m"
    if [[ $EUID -ne 0 ]]; then
        sudo apt update && sudo apt install -y $PACKAGES
    else
        apt update && apt install -y $PACKAGES
    fi
}

function fetch_repo {

    if [[ ! -d "$2" ]]; then
        echo -e "\033[0;32mFetching repo..\033[0m"
        git clone $1 $2
    fi
}

function install_neovim {
    echo -e "\033[0;32mInstalling neovim 'init.vim'...\033[0m"

    local SRC="$1/neovim/init.vim"
    local DST="$HOME/.config/nvim/init.vim"

    # does init.vim exist?
    if [[ -f $DST ]]; then
        echo -e "\033[0;33mThe dotfile 'init.vim' already exist, will create a backup.\033[0m"
        mv "$DST" "$DST.backup"
    fi

    mkdir -p $HOME/.config/nvim
    ln -s $SRC $DST
    vi -c "PlugInstall" -c "qa"
}

function install_zsh {
    echo -e "\033[0;32mInstalling zshel (with ohmyzsh and powerlevel10k)...\033[0m"

    local SRC_ZSH="$1/zsh/zshrc"
    local DST_ZSH="$HOME/.zshrc"
    if [[ -f $DST_ZSH ]]; then
        echo -e "\033[0;33mThe dotfile '.zshrc' already exist, will create a backup.\033[0m"
        mv "$DST_ZSH" "$DST_ZSH.backup"
    fi

    local SRC_P10K="$1/zsh/p10k.zsh"
    local DST_P10K="$HOME/.config/p10k/p10k.zsh"
    if [[ -f $DST_P10K ]]; then
        echo -e "\033[0;33mThe dotfile 'p10k.zsh' already exist, will create a backup.\033[0m"
        mv "$DST_P10K" "$DST_P10K.backup"
    fi

    mkdir -p $HOME/.config/p10k
    ln -s $SRC_ZSH $DST_ZSH
    ln -s $SRC_P10K $DST_P10K

    local ZSH=$HOME/.config/oh-my-zsh
    if [[ ! -d $ZSH ]]; then
        sh -c "ZSH=$ZSH;RUNZSH=no;KEEP_ZSHRC=yes;$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
    fi
}

function install_tmux {
    echo -e "\033[0;32mInstalling 'tmux.conf'...\033[0m"

    local PLUGDST=$HOME/.config/tmux/plugins/tpm
    if [[ ! -d $PLUGDST ]]; then
        mkdir -p $HOME/.config/tmux/plugins
        git clone --depth=1 https://github.com/tmux-plugins/tpm $PLUGDST
    fi

    local SRC="$3/tmux/tmux.conf"
    local DST="$HOME/.config/tmux/tmux.conf"
    if [[ -f $DST ]]; then
        echo -e "\034[0;33mThe dotfile 'tmux.conf' already exist, will create a backup.\033[0m"
        mv "$DST" "$DST.backup"
    fi

    ln -s $SRC $DST
    TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins $PLUGDST/bin/install_plugins
}

install_sys_bin

REPO="https://github.com/eupedrosa/insta.dot.git"
BASE="$HOME/.local/insta.dot"
fetch_repo $REPO $BASE
install_neovim $BASE
install_zsh $BASE
install_tmux $BASE

