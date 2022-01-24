#!/usr/bin/env bash

session=$1

if [ "$session" = "" ]; then
    session="session-1"
fi

tmux new -As $session
