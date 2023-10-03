if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#export LIBVA_DRIVER_NAME=nvidia
#export GBM_BACKEND=nvidia-drm
#export __GLX_VENDOR_LIBRARY_NAME=nvidia
#export __NV_PRIME_RENDER_OFFLOAD=1

#xrandr --setprovideroffloadsink 1 0
xrandr --setprovideroffloadsink 0 1
#xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

xrdb ~/.Xresources
#xrdb -merge ~/.Xresources

#startwm="gnome"
#startwm="hyprland"
#startwm="stumpwm"
#startwm="exwm"
#startwm="qtile-wayland"
startwm="qtile"

if [[ "$startwm" == "gnome" ]]; then
    gnome-shell;
elif [[ "$startwm" == "hyprland" ]]; then
    export XDG_SESSION_TYPE=wayland;
    export WLR_NO_HARDWARE_CURSORS=1;
    exec Hyprland;
elif [[ "$startwm" == "stumpwm" ]]; then
    export SBCL_HOME=/usr/lib/sbcl/;
    exec stumpwm;
elif [[ "$startwm" == "exwm" ]]; then
    ~/.doom.d/start-exwm.sh
elif [[ "$startwm" == "qtile-wayland" ]]; then
    qtile start --backend wayland;
else
    qtile start;
fi

