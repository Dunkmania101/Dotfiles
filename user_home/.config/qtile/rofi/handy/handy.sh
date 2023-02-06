#!/bin/bash

rofi_player=">/="
open_nvim=""
open_stacer=""
gen_passwd=""
clip_menu=""

options="$rofi_player\n$open_nvim\n$open_stacer\n$gen_passwd\n$clip_menu"
chosen="$(echo -e "$options" | rofi -theme ~/.config/qtile/rofi/theme.rasi -dmenu -p 'Handy tools')"

case $chosen in
    $rofi_player)
        $HOME/.config/qtile/rofi/player/player.sh
        ;;
    $open_nvim)
        kitty -e nvim
        ;;
    $open_stacer)
        stacer
        ;;
    $clip_menu)
        copyq menu
        ;;
    $gen_passwd)
        tr -dc "a-zA-Z0-9_#@.-" < /dev/urandom | head -c 14 | xclip -selection clipboard
        ;;
esac
