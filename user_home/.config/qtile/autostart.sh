#!/usr/bin/env bash

if [ -f ~/.profile ]; then . ~/.profile; fi

~/.config/qtile/scripts/run/run-monitors.sh &
# ~/.config/qtile/scripts/run/run-wallpapers.sh &
~/.config/qtile/scripts/run/run-picom.sh &
~/.config/qtile/scripts/run/run-redshift.sh &
# ~/.config/qtile/scripts/run/run-keysboard.sh &
~/.config/qtile/scripts/run/run-kmonad.sh &
~/.config/qtile/scripts/run/run-touchegg.sh &
~/.config/qtile/scripts/run/run-cbatticon.sh &
~/.config/qtile/scripts/run/run-volumeicon.sh &
~/.config/qtile/scripts/run/run-flameshot.sh &
~/.config/qtile/scripts/run/run-lxappearance_init.sh &
~/.config/qtile/scripts/run/run-qjackctl.sh &
~/.config/qtile/scripts/run/run-searx.sh &

pgrep lxsession || lxsession &
#pgrep agordejo || agordejo --continue &
clipmenud &
playerctld daemon &
#deadd-notification-center &
pgrep copyq || copyq &
#element-desktop-nightly --hidden &
pgrep element-desktop || element-desktop --hidden &
#pgrep easyeffects || easyeffects & sleep 1 && easyeffects --hide-window &
#agordejo --hide --load-session Main &
pgrep emacs || emacs --daemon &
pgrep mpd || mpd &

xsetroot -cursor_name left_ptr
#xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
#xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
xset b off
xset r rate 280 40
xset 1800
xss-lock -l -- i3lock --ignore-empty-password --color=2c2826 --bar-indicator --bar-color=3c3836 &

