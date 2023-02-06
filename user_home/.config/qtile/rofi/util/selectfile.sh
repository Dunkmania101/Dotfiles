#!/usr/bin/env bash
# Based on the script here: https://gist.github.com/thingsiplay/6c4bd13a106a4a609d69c402e675c137

# selectfile
# Use rofi to select file or folder until file is selected, then print it.

# Arguments
#   $1=directory to start, defaults to "." (specified in variable default_dir)

# Source directory with systems folders.
default_dir="."
selected="x"
if [[ "$2" == "--savefile" ]]
then
    save_file=$1
    if [[ -f "$save_file" ]]
    then
        default_file="$(tail $save_file --lines=1)"
        default_dir="$(dirname "$default_file")"
        default_selected="$(basename "$default_file")"
    fi
fi

# Filter modes: normal, regex, glob, fuzzy, prefix
rofi_filter_mode="regex"
# Prompt in rofi, defaults to scriptname.
if [[ "$prompt" == "" ]]; then prompt="${0##*/}"; fi

# rofi command to run for each selection.
rofi="rofi -theme ~/.config/qtile/rofi/theme.rasi -dmenu -p "$prompt" -lines 15 -matching $rofi_filter_mode -i"

if [[ -z $1 || ! "$save_file" == "" ]]
then
    dir="$default_dir"
else
    dir="$1"
fi

# selected will be set to empty string, if user cancels in rofi.  This should
# start out with any value, as the until loop stops if its empty.
# ! Attention: Be careful with modifying these things, otherwise you could end
# up in an infinite loop.
file=""
until [[ -f "$file" || "$selected" == "" ]]
do
    # List all folders in the directory and add ".." as top entry.
    filelist=`ls --color=never -1N "$dir"`
    selected=`echo -e "..\n$filelist" | $rofi -select "$default_selected" -mesg "$dir"`
    default_selected=".."

    if [[ "$selected" == "" ]]
    then
        file=""
    elif [[ "$selected" == ".." ]]
    then
        # ".." will be translated to go up one folder level and run rofi again.
        dir=${dir%/*}
        if [[ "$dir" == "" ]]
        then
            dir="/"
        fi
    else
        file="$dir/$selected"
        dir="$file"
    fi
done

# Extract folder portion, if its a file.  This is needed, because the dir
# variable is overwritten previously.
# if [[ -f "$file" ]]
# then
#     dir=${dir%/*}
# fi
# echo "$dir"

# Finally print the fullpath of selected file.
if [[ ! "$file" == "" ]]
then
    if [[ ! "$save_file" == "" ]]
    then
        mkdir --parents "$(dirname $save_file)"
        echo "$file" > $save_file
    fi
    echo "$file"
fi
