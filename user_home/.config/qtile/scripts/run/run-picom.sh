#!/usr/bin/env bash

killall -q picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
killall -q xcompmgr
while pgrep -u $UID -x xcompmgr >/dev/null; do sleep 1; done
killall -q flashfocus
while pgrep -u $UID -x flashfocus >/dev/null; do sleep 1; done
picom --config ~/.config/qtile/picom.conf & # --experimental-backends &
flashfocus &
#xcompmgr &

