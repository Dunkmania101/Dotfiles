#!/usr/bin/env bash

development=" - Dev"
monitor=" - Monitor"
minecraft=" - Minecraft"
decorative=" - Decorative"

options="$monitor\n$minecraft\n$development\n$decorative"
chosen="$(echo -e "$options" | rofi -theme ~/.config/qtile/rofi/gruvbox-dark.rasi -dmenu -p 'Choose workspace to activate')"

case $chosen in
    $development)
        vscodium &
        kitty &
        ;;
    $monitor)
        kitty -e 'bpytop' &
        thunar &
        ;;
    $decorative)
        kitty -e 'asciiquarium' &
        kitty -e 'cmatrix' &
        ;;
esac
