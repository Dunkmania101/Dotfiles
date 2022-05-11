#!/usr/bin/env bash

if [ -n "$FIFO_UEBERZUG" ]; then
  printf '{"action": "remove", "identifier": "preview"}\n' >"$FIFO_UEBERZUG"
fi

