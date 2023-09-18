#!/usr/bin/env bash

#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

#xrandr --output HDMI-0 --primary
#xrandr --output VGA-0 --left-of HDMI-0
# nvidia-settings -r &

# xrandr --output DP2 --primary
# xrandr --output VGA1 --left-of DP2

#xrandr --output DP-0 --right-of DVI-D-0 --primary --auto
#xrandr --output DP-0 --right-of DVI-D-0 --left-of HDMI-0 --primary --auto
#xrandr --output VGA-0 --right-of DVI-D-0 --primary --auto
#xrandr --output VGA-1 --right-of DVI-D-1 --primary --auto
#xrandr --output HDMI-1 --right-of DVI-D-1 --primary --auto
#xrandr --output HDMI-1 --right-of DVI-D-0 --primary --auto
#xrandr --output HDMI-1 --right-of eDP-1 --primary --auto
xrandr --output eDP-1 --left-of HDMI-1 --primary --auto
#xrandr --output eDP1 --left-of HDMI1 --primary --auto
#xrandr --output DP-2 --right-of VGA-1 --primary --auto
#xrandr --output VGA1 --right-of DP2 --primary --auto

#xrandr --rate 144 &

