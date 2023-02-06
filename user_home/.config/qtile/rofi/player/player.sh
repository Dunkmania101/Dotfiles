#!/usr/bin/env bash

control_player="Control Player"
pctld_shift="Shift Playerctld Selection"
pctld_unshift="Unshift Playerctld Selection"

options="$control_player\n$pctld_shift\n$pctld_unshift"

action="a"
while [ "$action" != "" ]; do
    action="$(echo -e "$options" | rofi -theme ~/.config/qtile/rofi/theme.rasi -dmenu -p "Playerctl")"

    case $action in
        $control_player)
            ~/.config/qtile/rofi/player/player_controller.sh
            ;;
        $pctld_shift)
            playerctld shift
            ;;
        $pctld_unshift)
            playerctld unshift
            ;;
    esac
done
