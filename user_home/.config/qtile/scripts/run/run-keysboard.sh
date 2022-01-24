#!/usr/bin/env bash

PIPE_FILE=/tmp/tmux-bar-keysboard-pipe


tmux new -ds "keysboard-bar" "python3 ~/.config/qtile/scripts/keysboard/keysboard.py config=~/.config/qtile/scripts/keysboard/keysboard-conf.json"

if [[ ! -f $PIPE_FILE ]]; then rm -f $PIPE_FILE && touch $PIPE_FILE; tmux pipe-pane -t 'keysboard-bar' -o "cat >> $PIPE_FILE"; fi

