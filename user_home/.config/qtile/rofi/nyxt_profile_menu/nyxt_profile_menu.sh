#!/usr/bin/env bash

options=$(nyxt --list-data-profiles | grep -iv 'gtk' | grep -iv '<info>' | cut -d' ' -f1 | grep -iv '^$')
chosen="$(echo -e "$options" | rofi -theme ~/.config/qtile/rofi/gruvbox-dark.rasi -dmenu -p 'Choose Nyxt profile')"

if [[ $chosen != "" ]]; then
    nyxt --data-profile $chosen
fi
