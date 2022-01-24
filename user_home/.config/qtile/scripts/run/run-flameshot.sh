#!/usr/bin/env bash

killall -q flameshot
while pgrep -u $UID -x flameshot >/dev/null; do sleep 1; done
flameshot &
