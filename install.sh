#!/bin/bash
set -o errexit
set -o nounset

function install_sys_bin {
    local PACKAGES='git neovim python3-neovim python3-jedi tmux'

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
    echo -e "\033[0;32mInstalling neovim 'init.vim'\033[0m"

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

install_sys_bin

REPO="https://github.com/eupedrosa/insta.dot.git
BASE="$HOME/.local/insta.dot"
fetch_repo "eupedrosa/insta.dot" $BASE
install_neovim $BASE

