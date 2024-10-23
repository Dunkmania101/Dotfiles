#!/usr/bin/env bash

PKGS="$(cat Pkgs.txt)"
sudo pacman --needed -S $PKGS
unset PKGS

