#!/usr/bin/env bash

back="Back"
playpause=">/="
ahead=">>+1"
prev="<<-1"
volup="VOL+1%"
voldown="VOL-1%"

options="$back\n$playpause\n$ahead\n$prev\n$volup\n$voldown"

players="$(playerctl --list-all)"
chosen="$(echo -e "$players" | rofi -theme ~/.config/qtile/rofi/gruvbox-dark.rasi -dmenu -p 'Choose player to control')"

if [ "$chosen" != "" ]; then
    action="a"
    while [ "$action" != "" ]; do
        action="$(echo -e "$options" | rofi -theme ~/.config/qtile/rofi/gruvbox-dark.rasi -dmenu -p "Player: $chosen")"

        cmd="playerctl -p $chosen"
        case $action in
            $playpause)
                $cmd play-pause
                ;;
            $ahead)
                $cmd position 1+
                ;;
            $prev)
                $cmd position 1-
                ;;
            $volup)
                $cmd volume 0.01+
                ;;
            $voldown)
                $cmd volume 0.01-
                ;;
            $back)
                $0 & break
                ;;
        esac
    done
fi
