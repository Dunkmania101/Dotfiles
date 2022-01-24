#!/usr/bin/env bash

back="Back"
playpause=">/="
ahead=">>+5"
prev="<<-5"
volup="VOL+5%"
voldown="VOL-5%"

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
                $cmd position 5+
                ;;
            $prev)
                $cmd position 5-
                ;;
            $volup)
                $cmd volume 5%+
                ;;
            $voldown)
                $cmd volume 5%-
                ;;
            $back)
                $0 & break
                ;;
        esac
    done
fi
