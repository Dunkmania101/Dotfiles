# Variables
set fish_greeting
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.fnm:$HOME/.fnm/aliases/default/bin:$HOME/.guix-profile/bin:$HOME/.nix-profile/bin:/usr/local/bin:$HOME/.nimble/bin:$HOME/Launchers:$HOME/ProgramFiles/doom-emacs/bin/:$PATH"
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
export VISUAL="nvim"
export EDITOR="nvim"


# Aliases
alias sudo="sudo "
alias sl="sl -e"
alias vfzf="ytfzf -tcY,P,O"
alias install-searx='docker stop searx-1; docker rm -v searx-1; PORT=8888 docker run --name=searx-1 --restart=unless-stopped -d -v ~/ProgramFiles/searx:/etc/searx -p $PORT:8080 -e BASE_URL=http://localhost:$PORT/ searx/searx'
alias install-fisher="curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
alias install-brl="wget -O /tmp/brl-installer.sh https://raw.githubusercontent.com/bedrocklinux/bedrocklinux-userland/master/src/installer/installer.sh; sudo sh /tmp/brl-installer.sh --hijack"
alias install-guix="wget -O /tmp/guix-install.sh https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh; chmod +x /tmp/guix-install.sh; sudo bash \"/tmp/guix-install.sh\""
alias install-nix="curl -L https://nixos.org/nix/install | sh"
alias install-chemacs="[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; [ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; git clone https://github.com/plexus/chemacs2.git ~/.emacs.d"
alias install-doom="mkdir -p ~/ProgramFiles; git clone --depth 1 https://github.com/hlissner/doom-emacs ~/ProgramFiles/doom-emacs; ~/ProgramFiles/doom-emacs/bin/doom install"
alias install-emacs-config="install-chemacs; install-doom"
alias install-fnm="curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell; fnm install --lts"
alias install-nvm="wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/latest/install.sh | bash; nvm install node"
alias install-choosenim="curl https://nim-lang.org/choosenim/init.sh -sSf | sh"
alias install-nyxt-git-guix="guix install --with-branch=nyxt=master nyxt"
alias install-blender-oldgl='guix install blender --with-source="https://download.blender.org/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2"'
alias dockerclean="docker system prune --all"
alias with-ld-path="LD_LIBRARY_PATH=$HOME/.guix-profile/lib "
alias uu-fontcache="fc-cache -rv"
alias uu-arch='sudo aura -Syyu --noconfirm; sudo aura -Ayyu --noconfirm; sudo aura -R (aura -O); sudo paccache -rk 1; sudo paccache -ruk0'
alias uu-flatpak="flatpak update; flatpak uninstall --unused"
alias guixclean="guix gc; guix gc --optimize"
alias guixclean-full="guix gc --delete-generations; guixclean"
alias guixfix="sudo guix gc --verify=contents,repair"
alias guixconf="sudo -E guix system reconfigure ~/.config/guix/system-config.scm"
alias guixmanifest="guix package --manifest=$HOME/.config/guix/base/manifest-main.scm"
alias uu-guix="guix pull; guix package --upgrade; guixclean"
alias guix-nvdaify="guix package --manifest=$HOME/.config/guix/manifests/nvidiaify-packages.scm"
alias nixclean="nix-collect-garbage"
alias nixclean-full="nix-collect-garbage --delete-old"
alias uu-nix="nix-channel --update; nix-env --upgrade; nixclean"
alias uu-stack="stack upgrade; stack update"
function lsoutdated-pip; eval "$P list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1"; end
function uu-pip; for P in "python -m pip" "sudo python -m pip" "pypy3 -m pip" "sudo pypy3 -m pip"; eval "$P install -U (P=\"$P\" lsoutdated-pip)"; end; end
#alias uu-nim="choosenim update self; choosenim update devel; nimble refresh || rm -rf $HOME/.nimble && nimble refresh; for nim_package in (nimble list --installed | cut -d' ' -f1); nimble --accept install $nim_package"
alias uu-fish="fisher update"
alias uu-node="install-fnm; npm install -g npm; npm -g update"
alias uu-brl="sudo brl apply; sudo brl update"
alias uu-apt="sudo apt update; sudo apt -y full-upgrade; sudo apt -y autoremove"
alias uu-dnf="sudo dnf check-update; sudo dnf -y distro-sync; sudo dnf -y autoremove"
alias uu-doom="doom --force upgrade; doom --force sync; doom --force purge"
alias uu-nvim="nvim -c 'UU' -c 'qa!'"
alias uu-noguix="uu-arch; uu-fish; uu-nix; uu-flatpak; uu-pip; uu-nim; uu-node; uu-doom"
alias uu="uu-noguix; uu-guix"
alias uu-clean="uu; guixclean-full"
export add_package_cmd="sudo aura -S --needed "
#export add_package_cmd="guix install "
alias lfi="~/.config/lf/run_lf.sh"
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
#if test -d "$NIX_PROFILE"; bass . "$NIX_PROFILE/etc/profile.d/nix.sh"; end

if test -f "$HOME/.profile"; bass . "$HOME/.profile"; end

# Atuin
if type -q atuin; atuin init fish | source; end

# fnm
if test -f $HOME/.fnm/fnm; fnm env | source; end

# Ferium
if type -q ferium; ferium  complete fish | source; end

# Functions
function strdiff -a 'a'; command diff --color --from (echo $a | psub) (for s in $argv[2..-1]; echo $s | psub; end); end
function aura-check-pkgbuild -a 'a'; command aura -Ap $a | aura -P; end

# Keybinds
fish_default_key_bindings
#fish_vi_key_bindings
#bind \ck 'command clear; commandline -f repaint-mode; commandline -f repaint'
bind \ck 'commandline -i clear; commandline -f execute'
bind \cb 'btop'
bind \cn 'nvim'
bind \cf 'newsboat'
bind \ce 'lfi'
bind \cw 'weechat'
bind \co 'commandline -i \'nvim \''
bind \ca "commandline -i \"$add_package_cmd\""
bind \cu 'commandline -i uu-clean; commandline -f execute'

# Themes
base16-onedark

