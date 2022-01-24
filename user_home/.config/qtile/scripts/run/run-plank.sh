#!/usr/bin/env bash

killall -q plank
while pgrep -u $UID -x plank >/dev/null; do sleep 1; done

if [[ "$1" == "" ]]; then
    for _ in $($HOME/.config/qtile/scripts/get_monitors.sh); do plank --display=$M & done
fi

