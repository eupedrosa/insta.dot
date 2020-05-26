
function dot() {
    function cfg {
        /usr/bin/git --git-dir=$HOME/.config/dot --work-tree=$HOME $@
    }

    FILE=$(cfg ls-files $HOME --full-name | fzf +m -1 --height=20% --layout=reverse -q ${@:-""})
    if [[ $? -eq 0 ]]; then
        nvim $HOME/$FILE
    fi
}

function cdp() {
    oldpwd=$PWD
    cd $HOME
    DIR=$(find -L +play -mindepth 1 -type d -not -path '*\.*/*' | fzf +m -1 --height=30% --layout=reverse -q ${@:-""})
    if [[ $? -eq 0 ]]; then
        cd $HOME/$DIR
    else
        cd $oldpwd
    fi
}

