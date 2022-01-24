#!/usr/bin/env bash

DELAY="1"
if [[ "$2" != "" ]]; then
    DELAY="$2"
fi

BTN="1"
if [[ "$1" != "" ]]; then
    BTN="$1"
fi

CMD_WIN=""
if ["$3" != ""]; then
    CMD_WIN=" --window $3"
fi

SESSION_NAME="tmux-autoclick-$1"

if [[ $(tmux ls) == *"$SESSION_NAME"* ]]; then
    tmux kill-session -t $SESSION_NAME
else
    tmux new -ds "$SESSION_NAME" "while true; sleep $DELAY; do xdotool click $BTN$CMD_WIN; done"
fi
