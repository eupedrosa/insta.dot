#!/bin/bash

function run { pgrep $1 || $@& }

run slstatus
run nitrogen --restore
run compton --config $HOME/.config/dwm/compton.conf
run xss-lock -- betterlockscreen -l

pgrep xautolock -x || xautolock -secure -time 10  -detectsleep -corners --00 -locker "betterlockscreen -s "&

xset -dpms
xset s off
xset s noblank

