#!/usr/bin/env bash

query="$(rofi -dmenu -i -no-fixed-num-lines -p "Enter query for ytfzf: " -theme $HOME/.config/qtile/rofi/gruvbox-dark.rasi)"

if [[ ! "$query" == "" ]]
then
    vid="$(ytfzf -DL $query)"
    if [[ ! "$vid" == "" ]]
    then
        mpv --script=$HOME/.guix-profile/lib/mpris.so --force-window --no-keepaspect-window --loop "$vid"
    fi
fi
