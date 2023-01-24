#!/usr/bin/env bash

if [[ "$1" == "--savefile" ]]
then
    save_file="$HOME/.private/data/cache/ytfzf_save"
    if [[ -f "$save_file" ]]
    then
        ytfzf_history="$(cat $save_file | grep -xv $'\n')"
    fi
fi

query="$(printf "$ytfzf_history" | rofi -dmenu -i -no-fixed-num-lines -p "Enter query for ytfzf: " -theme $HOME/.config/qtile/rofi/gruvbox-dark.rasi)"

if [[ ! "$query" == "" ]]
then
    if [[ ! "$save_file" == "" ]]
    then
        mkdir --parents "$(dirname $save_file)"
        printf "$ytfzf_history" | grep -x "$query" || printf "\n$query" >> $save_file
    fi
    vid="$(ytfzf --pages=5 -cY,P,O -DLl $query)"
    if [[ ! "$vid" == "" ]]
    then
        mpv --script=$HOME/.guix-profile/lib/mpris.so --force-window --no-keepaspect-window --loop --ytdl=yes --script-opts=ytdl_hook-ytdl_path='yt-dlp',ytdl_hook-try_ytdl_first='yes' --ytdl-raw-options=sponsorblock-mark='all',embed-chapters= "$vid"
    fi
fi
