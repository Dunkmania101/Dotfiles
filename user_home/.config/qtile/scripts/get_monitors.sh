#!/usr/bin/env bash

echo $(xrandr --query | grep " connected" | cut -d" " -f1)
