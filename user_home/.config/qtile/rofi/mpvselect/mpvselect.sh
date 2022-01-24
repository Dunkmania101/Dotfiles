#!/usr/bin/env bash

selectfile="$HOME/.config/qtile/rofi/util/selectfile.sh"
if [[ $1 == "--nosave" ]]
then
    media_file="$(prompt='Select_media' $selectfile)"
else
    media_file="$(prompt='Select_media' $selectfile $HOME/.private/data/cache/mpvselect_save --savefile)"
fi

if [[ ! "$media_file" == "" ]]
then
    echo $media_file
    mpv --script=$HOME/.guix-profile/lib/mpris.so --force-window --no-keepaspect-window --loop "$media_file"
fi
