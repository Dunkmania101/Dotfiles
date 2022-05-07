#!/usr/bin/env bash

if [ -f ~/.profile ]; then . ~/.profile; fi

~/.config/qtile/scripts/run/run-monitors.sh &
# ~/.config/qtile/scripts/run/run-wallpapers.sh &
~/.config/qtile/scripts/run/run-picom.sh &
~/.config/qtile/scripts/run/run-redshift.sh &
# ~/.config/qtile/scripts/run/run-keysboard.sh &
~/.config/qtile/scripts/run/run-kmonad.sh &
~/.config/qtile/scripts/run/run-cbatticon.sh &
~/.config/qtile/scripts/run/run-volumeicon.sh &
~/.config/qtile/scripts/run/run-flameshot.sh &
~/.config/qtile/scripts/run/run-lxappearance_init.sh &

lxsession &
clipmenud &
#deadd-notification-center &
copyq &
#element-desktop-nightly --hidden &
pgrep element-desktop || element-desktop --hidden &
#agordejo --hide --load-session Main &
emacs --daemon &

xsetroot -cursor_name left_ptr
xset b off
xset r rate 280 40
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
# xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

