#!/usr/bin/env bash

killall -q cbatticon
while pgrep -u $UID -x cbatticon >/dev/null; do sleep 1; done
cbatticon &
