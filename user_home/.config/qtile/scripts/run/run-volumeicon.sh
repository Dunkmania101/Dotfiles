#!/usr/bin/env bash

killall -q volumeicon
while pgrep -u $UID -x volumeicon >/dev/null; do sleep 1; done
volumeicon &

