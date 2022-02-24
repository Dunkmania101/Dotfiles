# Variables
set fish_greeting
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.fnm:$HOME/.fnm/aliases/default/bin:$HOME/.guix-profile/bin:$HOME/.nix-profile/bin:/usr/local/bin:$HOME/.nimble/bin:$HOME/Launchers:$HOME/ProgramFiles/doom-emacs/bin/"
export superdrive="$HOME/superdrive-ln/"
export programming="$superdrive/Programming/"
export mcmoddev="$programming/Java/MC/MinecraftModDev/"
export games="$superdrive/Games/"
export gdlauncher="$games/GDlauncher/"
export mcinstances="$gdlauncher/instances/"
# export TERM=xterm-kitty
#export VISUAL="emacs -nw"
#export EDITOR="emacs -nw"
#export ALTERNATE_EDITOR=""


# Aliases
alias sudo="sudo "
alias install-fisher="curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
alias install-brl="wget -O /tmp/brl-installer.sh https://raw.githubusercontent.com/bedrocklinux/bedrocklinux-userland/master/src/installer/installer.sh; sudo sh /tmp/brl-installer.sh --hijack"
alias install-guix="wget -O /tmp/guix-install.sh https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh; chmod +x /tmp/guix-install.sh; sudo bass \"sh echo yes | /tmp/guix-install.sh\""
alias install-nix="curl -L https://nixos.org/nix/install | sh"
alias install-chemacs="[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; [ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; git clone https://github.com/plexus/chemacs2.git ~/.emacs.d"
alias install-doom="mkdir -p ~/ProgramFiles; git clone --depth 1 https://github.com/hlissner/doom-emacs ~/ProgramFiles/doom-emacs; ~/ProgramFiles/doom-emacs/bin/doom install"
alias install-emacs-config="install-chemacs; install-doom"
alias install-fnm="curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell; fnm install --lts"
alias install-nvm="wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/latest/install.sh | bash; nvm install node"
alias install-choosenim="curl https://nim-lang.org/choosenim/init.sh -sSf | sh"
alias install-nyxt-git-guix="guix install --with-branch=nyxt=master nyxt"
alias install-blender-oldgl='guix install blender --with-source="https://download.blender.org/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2"'
alias uu-fontcache="fc-cache -rv"
alias uu-arch="paru -Syyu --noconfirm --needed; paru -c; paru -cc; sudo paccache -rk 1; sudo paccache -ruk0"
alias uu-flatpak="flatpak update; flatpak uninstall --unused"
alias guixclean="guix gc; guix gc --optimize"
alias guixclean-full="guix gc --delete-generations; guixclean"
alias guixfix="sudo guix gc --verify=contents,repair"
alias guixconf="sudo -E guix system -L ~/.config/guix/base reconfigure ~/.config/guix/dunk-system-biggus.scm"
alias guixmanifest="guix package --manifest=$HOME/.config/guix/base/manifest-main.scm"
alias uu-guix="guix pull; guix package -u; guixclean"
alias guix-nvdaify='guix package --with-graft=mesa=nvda -i (guix package --list-installed | awk \'{print $1}\')'
alias nixclean="nix-collect-garbage"
alias nixclean-full="nix-collect-garbage --delete-old"
alias uu-nix="nix-channel --update; nix-env --upgrade; nixclean"
alias uu-stack="stack upgrade; stack update"
alias lsoutdated-pip="pip list --outdated --format=freeze | grep -v "^\-e" | cut -d = -f 1"
alias uu-pip='pip install (lsoutdated-pip)'
alias uu-pip-root='sudo pip install (sudo lsoutdated-pip)'
#alias uu-nim="choosenim update self; choosenim update devel; nimble refresh || rm -rf $HOME/.nimble && nimble refresh; for nim_package in (nimble list --installed | cut -d' ' -f1); nimble --accept install $nim_package"
alias uu-fish="fisher update"
alias uu-node="install-fnm; npm install -g npm; npm -g update"
alias uu-brl="sudo brl apply; sudo brl update"
alias uu-apt="sudo apt update; sudo apt -y full-upgrade; sudo apt -y autoremove"
alias uu-dnf="sudo dnf check-update; sudo dnf -y distro-sync; sudo dnf -y autoremove"
alias uu-doom="doom --yes upgrade; doom --yes sync; doom --yes purge"
alias uu-nvim="nvim -c 'UU' -c 'qa!'"
alias uu-noguix="uu-fisher; uu-nix; uu-flatpak; uu-pip; uu-nim; uu-node; uu-doom"
alias uu="uu-noguix; uu-guix"
alias uu-clean="uu; guixclean-full"
#export add_package_cmd="paru --needed -S "
export add_package_cmd="guix install "
alias lsa="exa -a"
alias getwinid="xwininfo -display :0"
alias lsmon="xrandr --query | grep ' connected' | cut -d' ' -f1"
alias mc-run-client="./gradlew runClient"
alias mc-build="./gradlew build"
alias show-weather="curl wttr.in/"
alias show-weather-detailed="curl v2.wttr.in/"
alias get-city="curl https://ipapi.co/city/"
alias show-weather-map='curl v3.wttr.in/(get-city).sxl'
alias show-weather-map-kitty='curl v3.wttr.in/(get-city).png | kitty +kitten icat'
alias show-weather-moon="curl wttr.in/Moon"
alias spark-runtime='ps -A | string replace --filter --regex -- ".*(\d+):(\d+).*" "\$1 * 3600 + \$2 * 60" | bc | spark'


# Env
set GUIX_PROFILE "$HOME/.config/guix/current"
if test -d "$GUIX_PROFILE"; bass . "$GUIX_PROFILE/etc/profile"; end

#. "/run/current-system/profile/etc/profile.d/nix.sh"
set NIX_PROFILE "$HOME/.nix-profile"
if test -f "$HOME/.profile"; bass . "$HOME/.profile"; end
#if test -d "$NIX_PROFILE"; bass . "$NIX_PROFILE/etc/profile.d/nix.sh"; end

# fnm
if test -f $HOME/.fnm/fnm; fnm env | source; end

# Keybinds
fish_default_key_bindings
#fish_vi_key_bindings
#bind \ck 'commandline -f repaint-mode; command clear'
bind \ck 'commandline -i clear; commandline -f execute'
bind \cb 'btop'
bind \cn 'nvim'
bind \co 'commandline -i \'nvim \''
bind \ca "commandline -i \"$add_package_cmd\""
bind \cu 'commandline -i uu-clean; commandline -f execute'


# Themes
theme_gruvbox dark medium
base16-gruvbox-dark-medium
