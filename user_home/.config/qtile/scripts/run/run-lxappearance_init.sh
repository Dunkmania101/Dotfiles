#!/usr/env bash

lxappearance > /dev/null 2>&1 & sleep 0.02 && kill $!
