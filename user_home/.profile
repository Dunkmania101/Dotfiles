if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then
    . /run/current-system/profile/etc/profile.d/nix.sh
    export XDG_DATA_DIRS="$HOME/.nix-profile/share${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS"
    export XCURSOR_PATH="$HOME/.nix-profile/share/icons${XCURSOR_PATH:+:}$XCURSOR_PATH"
fi

