#!/bin/bash

function run { pgrep $1 || $@& }

run slstatus
run nitrogen --restore
run compton --config $HOME/.config/dwm/compton.conf
run xss-lock -- betterlockscreen -l

pgrep xautolock -x || xautolock -secure -time 10 -locker "betterlockscreen -s" -detectsleep -corners --00 &

