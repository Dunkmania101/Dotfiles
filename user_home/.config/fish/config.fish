# Variables
set fish_greeting
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.fnm:$HOME/.fnm/aliases/default/bin:$HOME/.guix-profile/bin:$HOME/.nix-profile/bin:/usr/local/bin:$HOME/.nimble/bin:$HOME/Launchers:$HOME/.emacs.d/bin/:$PATH"
export superdrive="$HOME/superdrive-ln/"
export programming="$superdrive/Programming/"
export mcmoddev="$programming/Java/MC/MinecraftModDev/"
export games="$superdrive/Games/"
export gdlauncher_path="$games/GDlauncher/"
export creepyr_path="$games/creepyr"
export mclauncher_path="$creepyr_path"
export mcinstances="$mclauncher_path/instances/"
# export TERM=xterm-kitty
#export VISUAL="emacs -nw"
#export EDITOR="emacs -nw"
#export ALTERNATE_EDITOR=""
export VISUAL="nvim"
export EDITOR="nvim"
set -g fish_escape_delay_ms 30

# Zellij
set NO_ZELLIJ 1
if not set -q $NO_ZELLIJ
    if type -q zellij
        if status is-interactive
            # Configure auto-attach/exit to your likings (default is off).
            #set ZELLIJ_AUTO_ATTACH true
            #set ZELLIJ_AUTO_EXIT true
            #eval (zellij setup --generate-auto-start fish | string collect)
        end
    end
end

# Aliases
alias sudo="sudo "
function audio-burst-loop -a 'f'; while true; mpv $f --length=0.3; set grimmdelay (random 3 120); echo sleeping for $grimmdelay; sleep $grimmdelay; end; end
alias ff="fd . / --type f | fzf"
alias fh="fd . --type f | fzf"
alias ffv='$EDITOR (ff)'
alias fhv='$EDITOR (fh)'
alias pass1="PASSWORD_STORE_ENABLE_EXTENSIONS=true PASSWORD_STORE_DIR=$superdrive/Key/pass/1/ pass "
alias sl="sl -e"
alias ferium-cfg1="ferium --config-file=$games/Ferium/Configs/1/config.json"
alias vfzf="ytfzf -tcY,P,O"
alias install-searx='docker stop searx-1; docker rm -v searx-1; PORT=8888 docker run --name=searx-1 --restart=unless-stopped -d -v ~/ProgramFiles/searx:/etc/searx -p $PORT:8080 --expose 9050 -e BASE_URL=http://localhost:$PORT/ searx/searx'
alias install-retroshare-voip='mkdir -p ~/ProgramFiles/RetroShare/src/; mkdir -p ~/.retroshare/extensions6/; git clone --depth=1 https://github.com/RetroShare/RetroShare.git ~/ProgramFiles/RetroShare/src; cd ~/ProgramFiles/RetroShare/src/; git submodule update --depth=1 --init --remote --recursive --force; cd ~/ProgramFiles/RetroShare/src/plugins/VOIP; qmake && make clean && make; cp lib*.so ~/.retroshare/extensions6/'
alias install-quicklisp="mkdir -p ~/ProgramFiles/quicklisp/; curl https://beta.quicklisp.org/quicklisp.lisp -o ~/ProgramFiles/quicklisp/quicklisp.lisp; sbcl --load ~/ProgramFiles/quicklisp/quicklisp.lisp --eval '(progn (quicklisp-quickstart:install)(exit))'"
function install-quicklisp-module -a 'm'; test -e ~/quicklisp/ || install-quicklisp; sbcl --load ~/quicklisp/setup.lisp --eval "(progn (ql:system-apropos \"$m\") (ql:quickload \"$m\") (exit))"; end
alias install-mycroft='docker stop mycroft-1; docker rm -v mycroft-1; docker run --name=mycroft-1 --restart=unless-stopped -d -v ~/ProgramFiles/mycroft:/root/.mycroft --device /dev/snd -e PULSE_SERVER=unix:{$XDG_RUNTIME_DIR}/pulse/native -v {$XDG_RUNTIME_DIR}/pulse/native:{$XDG_RUNTIME_DIR}/pulse/native -v ~/.config/pulse/cookie:/root/.config/pulse/cookie -p 42069:8181 mycroftai/docker-mycroft'
alias install-pax-mc="mkdir -p ~/.local/bin; curl -L https://github.com/froehlichA/pax/releases/latest/download/pax > ~/.local/bin/pax; chmod +x ~/.local/bin/pax"
alias install-sdkman='curl -s "https://get.sdkman.io?rcupdate=false" | bash'
alias install-lunarvim="wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh -O /tmp/lviminstall.sh && chmod +x /tmp/lviminstall.sh && bass /tmp/lviminstall.sh"
alias install-librewolf-native-host="test -e ~/.mozilla/native-messaging-hosts || mkdir -p ~/.mozilla/native-messaging-hosts; test -e ~/.librewolf/native-messaging-hosts || ln -s ~/.mozilla/native-messaging-hosts ~/.librewolf/native-messaging-hosts; test -e /usr/lib/librewolf/native-messaging-hosts || sudo ln -s /usr/lib/mozilla/native-messaging-hosts /usr/lib/librewolf/native-messaging-hosts"
alias install-lieer="python3 -m pip install --upgrade https://github.com/gauteh/lieer/archive/refs/heads/master.zip"
alias install-blender-cad-sketcher="mkdir -p ~/ProgramFiles/blender_scripts/addons; git clone --depth=1 https://github.com/hlorus/CAD_Sketcher.git ~/ProgramFiles/blender_scripts/addons/CAD_Sketcher"
alias install-fisher="curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
alias install-brl="wget -O /tmp/brl-installer.sh https://raw.githubusercontent.com/bedrocklinux/bedrocklinux-userland/master/src/installer/installer.sh; sudo sh /tmp/brl-installer.sh --hijack"
alias install-guix="wget -O /tmp/guix-install.sh https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh; chmod +x /tmp/guix-install.sh; sudo bash \"/tmp/guix-install.sh\""
alias install-nix="curl -L https://nixos.org/nix/install | sh"
alias install-chemacs="[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; [ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; git clone https://github.com/plexus/chemacs2.git ~/.emacs.d"
alias install-doom="git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d; ~/.emacs.d/bin/doom install"
alias reinstall-doom='mkdir -p ~/ProgramFiles/.bak/doom-emacs; mv ~/.emacs.d ~/ProgramFiles/.bak/doom-emacs/(date); install-doom'
alias install-emacs-config="install-chemacs; install-doom"
alias install-fnm="curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell; fnm install --lts"
alias install-nvm="wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/latest/install.sh | bash; nvm install node"
alias install-choosenim="curl https://nim-lang.org/choosenim/init.sh -sSf | sh"
alias install-nyxt-git-guix="guix install --with-branch=nyxt=master nyxt"
alias install-blender-oldgl='guix install blender --with-source="https://download.blender.org/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2"'
alias dockerclean="docker system prune --all"
alias with-ld-path="LD_LIBRARY_PATH=$HOME/.guix-profile/lib "
function uu-pax-ensureloop; while true; pax upgrade -y && break; end; end # Because CurseForge is unreliable
alias uu-fontcache="fc-cache -rv"
alias uu-arch='sudo aura -Syyu --noconfirm; sudo aura -Ayyu --noconfirm; sudo aura -R (aura -O); sudo paccache -rk 1; sudo paccache -ruk0'
alias uu-flatpak="flatpak update --assumeyes; flatpak uninstall --unused"
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
function uu-pip; for P in "python -m pip" "sudo python -m pip" "pypy3 -m pip" "sudo pypy3 -m pip"; eval "$P install --upgrade pip (P=\"$P\" lsoutdated-pip)"; end; end
#alias uu-nim="choosenim update self; choosenim update devel; nimble refresh || rm -rf $HOME/.nimble && nimble refresh; for nim_package in (nimble list --installed | cut -d' ' -f1); nimble --accept install $nim_package"
alias uu-fish="fisher update"
alias uu-node="install-fnm; npm install -g npm; npm -g update"
alias uu-brl="sudo brl apply; sudo brl update"
alias uu-apt="sudo apt update; sudo apt -y full-upgrade; sudo apt -y autoremove"
alias uu-dnf="sudo dnf check-update; sudo dnf -y distro-sync; sudo dnf -y autoremove"
alias uu-chemacs="git -C ~/.emacs.d fetch; git -C ~/.emacs.d pull"
alias uu-doom="doom --force sync; doom --force upgrade; doom --force sync; doom --force purge"
alias uu-emacs="uu-doom"
alias uu-nvim="nvim -c 'UU' -c 'qa!'"
alias uu-noguix="uu-arch; uu-fish; uu-nix; uu-flatpak; uu-pip; uu-nim; uu-node; uu-emacs"
alias uu="uu-noguix; uu-guix"
alias uu-clean="uu; guixclean-full"
export add_package_cmd="sudo aura -S --needed "
#export add_package_cmd="guix install "
alias pkgadd="$add_package_cmd"
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
fish_vi_key_bindings
if type -q atuin; atuin init fish | ATUIN_NOBIND=1 source; end

# fnm
#if test -f $HOME/.fnm/fnm; fnm env | source; end

# Ferium
if type -q ferium; ferium complete fish | source; end

# Packwiz
if type -q pacwiz; packwiz completion fish | source; end

# Zoxide
zoxide init fish | source

# Functions
function strdiff -a 'a'; command diff --color --from (echo $a | psub) (for s in $argv[2..-1]; echo $s | psub; end); end
function strdiff-i -a 'a'; command diff --ignore-case --color --from (echo $a | psub) (for s in $argv[2..-1]; echo $s | psub; end); end
function aura-check-pkgbuild -a 'a'; command aura -Ap $a | aura -P; end
function srx -a 'SEARCH'; newsboat -u (echo "http://localhost:8888/search?q=$SEARCH&format=rss" | psub) -C (echo 'run-on-startup reload; open' | psub); end

# Keybinds
#fish_default_key_bindings
fish_vi_key_bindings
bind \cr _atuin_search
#bind \ck 'command clear; commandline -f repaint-mode; commandline -f repaint'
#bind \ck 'commandline -i clear; commandline -f execute'
#bind \cb 'btop'
#bind \cn 'nvim'
#bind \cf 'newsboat'
#bind \ce 'lfi'
#bind \cw 'weechat'
#bind \co 'commandline -i \'nvim \''
#bind \ca "commandline -i \"$add_package_cmd\""
#bind \cu 'commandline -i uu-clean; commandline -f execute'
if bind -M insert > /dev/null 2>&1;
    bind -M insert \cr _atuin_search;
end

# Themes
#base16-onedark
base16-gruvbox-dark-medium

# Other Inits
# pnpm
set -gx PNPM_HOME "/home/dunk/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# SDKman
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#test -f "$HOME/.sdkman/bin/sdkman-init.sh" && bass source "$HOME/.sdkman/bin/sdkman-init.sh"

