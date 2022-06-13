#!/usr/bin/env bash

killall -q qjackctl
while pgrep -u $UID -x qjackctl >/dev/null; do sleep 1; done
qjackctl --start &

