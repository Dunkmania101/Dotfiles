#!/usr/bin/env bash

killall -q picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config ~/.config/qtile/picom.conf &
# flashfocus &
