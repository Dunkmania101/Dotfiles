#!/usr/bin/env bash

PKGS="$(cat Pkgs.txt)"
sudo pacman --needed -Syu $PKGS
unset PKGS

