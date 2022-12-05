#if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then
#    . /run/current-system/profile/etc/profile.d/nix.sh
#    export XDG_DATA_DIRS="$HOME/.nix-profile/share${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS"
#    export XCURSOR_PATH="$HOME/.nix-profile/share/icons${XCURSOR_PATH:+:}$XCURSOR_PATH"
#fi
#
#if command -v nvidia-settings >/dev/null && command -v guix >/dev/null; then
#    export VDPAU_DRIVER=nvidia
#    export __GLX_VENDOR_LIBRARY_NAME=nvidia
#fi

export QT_QPA_PLATFORMTHEME="qt5ct"


sshenv=~/.ssh/agent.env

agent_load_env () { test -f "$sshenv" && . "$sshenv" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$sshenv")
    . "$sshenv" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset sshenv

#export __NV_PRIME_RENDER_OFFLOAD=1
#export __GLX_VENDOR_LIBRARY_NAME=nvidia
