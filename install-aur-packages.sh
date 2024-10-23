#!/usr/bin/env bash

PKGS="$(cat Pkgs-aur.txt)"
sudo aura -A $PKGS
unset PKGS

