#!/usr/bin/env bash

killall -q touchegg
while pgrep -u $UID -x touchegg >/dev/null; do sleep 1; done
touchegg &

