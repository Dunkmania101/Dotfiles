#!/usr/bin/env bash

killall -q dunst
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done
killall -q wired
while pgrep -u $UID -x wired >/dev/null; do sleep 1; done
wired &

