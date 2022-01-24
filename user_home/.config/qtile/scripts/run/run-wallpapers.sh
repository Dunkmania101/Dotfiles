#!/usr/bin/env bash

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    feh --bg-scale --randomize ~/Wallpapers/ &
done
