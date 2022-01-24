#!/usr/bin/env bash

tmux new -ds "kmonad-bar" "kmonad ~/.config/qtile/kmonad-2nd.kbd"

rm -f /tmp/tmux-bar-kmonad-pipe && touch /tmp/tmux-bar-kmonad-pipe &&
tmux pipe-pane -t 'kmonad-bar' -o 'cat >> /tmp/tmux-bar-kmonad-pipe'
