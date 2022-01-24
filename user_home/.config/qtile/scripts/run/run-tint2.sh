#!/usr/bin/env bash

killall -q tint2
while pgrep -u $UID -x tint2 >/dev/null; do sleep 1; done
tint2 &
