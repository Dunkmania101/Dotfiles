if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then
    . /run/current-system/profile/etc/profile.d/nix.sh
    export XDG_DATA_DIRS="$HOME/.nix-profile/share${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS"
    export XCURSOR_PATH="$HOME/.nix-profile/share/icons${XCURSOR_PATH:+:}$XCURSOR_PATH"
fi

if command -v nvidia-settings >/dev/null && command -v guix >/dev/null; then
    export VDPAU_DRIVER=nvidia
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
fi

