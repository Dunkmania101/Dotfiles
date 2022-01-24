#!/usr/bin/env bash

# socket_file=$(lsof -c emacs | grep server | tr -s " " | cut -d'/' -f1 | cut -d' ' -f9)
socket_file=$(lsof -c emacs | grep emacs/server | tr -s " " | tr " " "\n" | grep emacs/server)

if [[ $socket_file == "" ]]; then
    echo "Starting Emacs server..."
    emacs --chdir $PWD --execute "(server-start)" $@ & disown
else
    emacsclient --socket-name $socket_file --no-wait "" $@ & disown
fi
