# Variables
set fish_greeting
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.private/copy/bin:$HOME/go/bin:$HOME/.fnm:$HOME/.fnm/aliases/default/bin:$HOME/.guix-profile/bin:$HOME/.nix-profile/bin:/usr/local/bin:$HOME/.nimble/bin:$HOME/Launchers:$HOME/.emacs.d/bin/:$PATH"
export superdrive="$HOME/superdrive-ln/"
export programming="$superdrive/Programming/"
export mcmoddev="$programming/Games/MCModDev/"
export games="$superdrive/Games/"
export gdlauncher_path="$games/MC/GDlauncher/"
export creepyr_path="$games/MC/creepyr"
export mclauncher_path="$creepyr_path"
export PATH="$PATH:$mclauncher_path/bin"
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
function uu-graal; for j in /usr/lib/jvm/java-*-graalvm/bin/gu; sudo $j rebuild libpolyglot ; end; end
alias ff="fd . / --type f | fzf"
alias fh="fd . --type f | fzf"
alias ffv='$EDITOR (ff)'
alias fhv='$EDITOR (fh)'
alias mpvv="mpv --script=$HOME/.guix-profile/lib/mpris.so --force-window --no-keepaspect-window --loop "
alias pass1="PASSWORD_STORE_ENABLE_EXTENSIONS=true PASSWORD_STORE_DIR=$superdrive/Key/pass/1/ pass "
alias sl="sl -e"
alias ferium-cfg1="ferium --config-file=$games/Ferium/Configs/1/config.json"
alias vfzf="ytfzf -tcY,P,O"
alias cfzf="ytfzf --type=channel -L"
alias zellij-mc-1="zellij a mc-1 || zellij -s mc-1"
alias install-minegrub="sudo git -C /boot/grub/themes/ clone --depth=1 https://github.com/Lxtharia/minegrub-theme.git || sudo git -C /boot/grub/themes/minegrub-theme pull; sudo sed -i'.bak' 's@#GRUB_THEME=\"/path/to/gfxtheme\"@GRUB_THEME=/boot/grub/themes/minegrub-theme/theme.txt@g' /etc/default/grub; sudo update-grub"
alias install-capitaine-cursors-sainnhe="wget https://github.com/sainnhe/capitaine-cursors/releases/latest/download/Linux.zip -O /tmp/Linux.zip && mkdir -p ~/.local/share/icons && unzip -o /tmp/Linux.zip -d ~/.local/share/icons/"
alias install-tilix-gruvbox="mkdir -p ~/.config/tilix/schemes; wget https://raw.githubusercontent.com/sainnhe/gruvbox-material-tilix/master/gruvbox-material-medium-dark.json -P ~/.config/tilix/schemes/"
alias install-skeuos-gtk-gruvbox="mkdir -p ~/ProgramFiles/themes; mkdir -p ~/.local/share/themes; git -C ~/ProgramFiles/themes clone --depth=1 https://github.com/daniruiz/skeuos-gtk.git || git -C ~/ProgramFiles/themes/skeuos-gtk pull; bash -c 'pushd ~/ProgramFiles/themes/skeuos-gtk; cp -rf ./themes/* ~/.local/share/themes/; sudo cp -rf ./themes/* /usr/share/themes/; cp -rf ./icons/* ~/.local/share/icons/; sudo cp -rf ./icons/* /usr/share/icons/; popd'"
alias install-gruvbox-material-gtk="mkdir -p ~/ProgramFiles/themes; mkdir -p ~/.local/share/themes; git -C ~/ProgramFiles/themes clone --depth=1 https://github.com/TheGreatMcPain/gruvbox-material-gtk || git -C ~/ProgramFiles/themes/gruvbox-material-gtk pull; bash -c 'pushd ~/ProgramFiles/themes/gruvbox-material-gtk; cp -rf ./themes/* ~/.local/share/themes/; sudo cp -rf ./themes/* /usr/share/themes/; cp -rf ./icons/* ~/.local/share/icons/; sudo cp -rf ./icons/* /usr/share/icons/; popd'"
alias install-easy-diffusion="wget https://github.com/cmdr2/stable-diffusion-ui/releases/latest/download/Easy-Diffusion-Linux.zip -O /tmp/easy-diffusion-linux.zip && mkdir -p ~/ProgramFiles/easy-diffusion && unzip -o /tmp/easy-diffusion-linux.zip -d ~/ProgramFiles/easy-diffusion/"
alias easy-diffusion="bash ~/ProgramFiles/easy-diffusion/easy-diffusion/start.sh"
#alias install-chevron="mkdir -p ~/ProgramFiles/Chevron; git -C ~/ProgramFiles/Chevron clone --depth=1 https://github.com/kholmogorov27/chevron || git -C ~/ProgramFiles/Chevron/chevron pull; pushd ~/ProgramFiles/Chevron/chevron; npm install -g node-linux && npm link node-linux; npm run register_linux; popd"
alias install-chevron="mkdir -p ~/ProgramFiles/Chevron; git -C ~/ProgramFiles/Chevron clone --depth=1 https://github.com/kholmogorov27/chevron || git -C ~/ProgramFiles/Chevron/chevron pull; pushd ~/ProgramFiles/Chevron/chevron; npm install; npm run build; popd"
alias install-capitaine-cursors-sainnhe-root="wget https://github.com/sainnhe/capitaine-cursors/releases/latest/download/Linux.zip -O /tmp/Linux.zip && sudo mkdir -p /usr/share/icons && sudo unzip -o /tmp/Linux.zip -d /usr/share/icons/"
alias install-mpv-sponsorblock="git -C /tmp clone --depth=1 https://github.com/po5/mpv_sponsorblock.git; mkdir -p ~/.config/mpv/scripts/; cp /tmp/mpv_sponsorblock/sponsorblock.lua ~/.config/mpv/scripts/; cp -r /tmp/mpv_sponsorblock/sponsorblock_shared ~/.config/mpv/scripts/"
alias install-searx='docker stop searx-1; docker rm -v searx-1; PORT=8888 docker run --name=searx-1 --restart=unless-stopped -d -v ~/ProgramFiles/searx:/etc/searx -p $PORT:8080 --dns 9.9.9.9 -e BASE_URL=http://localhost:$PORT/ searx/searx:latest'
alias install-retroshare-voip='mkdir -p ~/ProgramFiles/RetroShare/; mkdir -p ~/.retroshare/extensions6/; git clone --depth=1 https://github.com/RetroShare/RetroShare.git ~/ProgramFiles/RetroShare/src; cd ~/ProgramFiles/RetroShare/src/; git submodule update --depth=1 --init --remote --recursive --force; cd ~/ProgramFiles/RetroShare/src/plugins/VOIP; qmake && make clean && make; cp lib*.so ~/.retroshare/extensions6/'
alias install-quicklisp="mkdir -p ~/ProgramFiles/quicklisp/; curl https://beta.quicklisp.org/quicklisp.lisp -o ~/ProgramFiles/quicklisp/quicklisp.lisp; sbcl --load ~/ProgramFiles/quicklisp/quicklisp.lisp --eval '(progn (quicklisp-quickstart:install)(exit))'"
function install-quicklisp-module -a 'm'; test -e ~/quicklisp/ || install-quicklisp; sbcl --load ~/quicklisp/setup.lisp --eval "(progn (ql:system-apropos \"$m\") (ql:quickload \"$m\") (exit))"; end
alias install-mycroft='docker stop mycroft-1; docker rm -v mycroft-1; docker run --name=mycroft-1 --restart=unless-stopped -d -v ~/ProgramFiles/mycroft:/root/.mycroft --device /dev/snd -e PULSE_SERVER=unix:{$XDG_RUNTIME_DIR}/pulse/native -v {$XDG_RUNTIME_DIR}/pulse/native:{$XDG_RUNTIME_DIR}/pulse/native -v ~/.config/pulse/cookie:/root/.config/pulse/cookie -p 42069:8181 mycroftai/docker-mycroft'
alias install-pax-mc="mkdir -p ~/.local/bin; curl -L https://github.com/froehlichA/pax/releases/latest/download/pax > ~/.local/bin/pax; chmod +x ~/.local/bin/pax"
alias install-packwiz-mc="go install github.com/packwiz/packwiz@latest"
alias install-sdkman='curl -s "https://get.sdkman.io?rcupdate=false" | bash'
alias install-lunarvim="wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh -O /tmp/lviminstall.sh && chmod +x /tmp/lviminstall.sh && bass /tmp/lviminstall.sh"
alias install-librewolf-native-host="test -e ~/.mozilla/native-messaging-hosts || mkdir -p ~/.mozilla/native-messaging-hosts; test -e ~/.librewolf/native-messaging-hosts || ln -s ~/.mozilla/native-messaging-hosts ~/.librewolf/native-messaging-hosts; test -e /usr/lib/librewolf/native-messaging-hosts || sudo ln -s /usr/lib/mozilla/native-messaging-hosts /usr/lib/librewolf/native-messaging-hosts"
alias install-lieer="python3 -m pip install --upgrade https://github.com/gauteh/lieer/archive/refs/heads/master.zip"
alias install-blender-cad-sketcher="mkdir -p ~/ProgramFiles/blender_scripts/addons; git clone --depth=1 https://github.com/hlorus/CAD_Sketcher.git ~/ProgramFiles/blender_scripts/addons/CAD_Sketcher || git -C ~/ProgramFiles/blender_scripts/addons/CAD_Sketcher pull"
alias install-blender-gruvbox="mkdir -p ~/ProgramFiles/blender_scripts/addons; git clone --depth=1 https://github.com/SylEleuth/blender-gruvbox.git ~/ProgramFiles/blender_scripts/addons/blender-gruvbox || git -C ~/ProgramFiles/blender_scripts/addons/blender-gruvbox pull"
alias install-blender-dracula="mkdir -p ~/ProgramFiles/blender_scripts/addons; git clone --depth=1 https://github.com/dracula/blender.git ~/ProgramFiles/blender_scripts/addons/blender-dracula || git -C ~/ProgramFiles/blender_scripts/addons/blender-dracula pull"
alias install-fisher="curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
#alias install-brl="wget -O /tmp/brl-installer.sh https://raw.githubusercontent.com/bedrocklinux/bedrocklinux-userland/master/src/installer/installer.sh; sudo sh /tmp/brl-installer.sh --hijack"
alias install-guix="wget -O /tmp/guix-install.sh https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh; chmod +x /tmp/guix-install.sh; sudo bash \"/tmp/guix-install.sh\""
alias install-nix="curl -L https://nixos.org/nix/install | sh"
#alias install-chemacs="[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; [ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; git clone https://github.com/plexus/chemacs2.git ~/.emacs.d"
alias install-doom="git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d; ~/.emacs.d/bin/doom install"
alias reinstall-doom='mkdir -p ~/ProgramFiles/.bak/doom-emacs; mv ~/.emacs.d ~/ProgramFiles/.bak/doom-emacs/(date); install-doom'
alias install-emacs-config="install-chemacs; install-doom"
alias install-fnm="curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell; fnm install --lts"
alias install-nvm="wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/latest/install.sh | bash; nvm install node"
alias install-choosenim="curl https://nim-lang.org/choosenim/init.sh -sSf | sh"
alias install-nyxt-git-guix="guix install --with-branch=nyxt=master nyxt"
alias install-nyxt-latest-flatpak="wget -O /tmp/nyxt.flatpak https://github.com/atlas-engineer/nyxt/releases/latest/download/nyxt.flatpak && sudo flatpak install --assumeyes /tmp/nyxt.flatpak"
alias install-blender-oldgl='guix install blender --with-source="https://download.blender.org/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2"'
alias dockerclean="docker system prune --all"
#alias with-ld-path="LD_LIBRARY_PATH=$HOME/.guix-profile/lib "
#function uu-pax-ensureloop; while true; pax upgrade -y && break; end; end # Because CurseForge is unreliable
alias uu-fontcache="fc-cache -rv"
alias uu-arch='sudo aura -Syyu --noconfirm --needed; sudo aura -Ayyu --noconfirm --needed; sudo aura -R (aura -O); sudo paccache -rk 1; sudo paccache -ruk0'
alias uu-flatpak="flatpak update --assumeyes; flatpak uninstall --unused"
alias guixclean="guix gc; guix gc --optimize"
alias guixclean-full="guix gc --delete-generations; guixclean"
alias guixfix="sudo guix gc --verify=contents,repair"
alias guixconf="sudo -E guix system --cores=$(nproc) reconfigure ~/.config/guix/system-config.scm"
alias guixmanifest="guix package --manifest=$HOME/.config/guix/base/manifest-main.scm"
alias uu-guix="guix pull; guix package --upgrade"
alias guix-nvdaify="guix package --manifest=$HOME/.config/guix/manifests/nvidiaify-packages.scm"
alias nixclean="nix-collect-garbage"
alias nixclean-full="nix-collect-garbage --delete-old"
alias uu-nix="nix-channel --update; nix-env --upgrade; nixclean"
alias uu-stack="stack upgrade; stack update"
#function lsoutdated-pip; eval "$P list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1"; end
function lsoutdated-pip; echo (eval "$P list --outdated --format=json" | jq -r 'map(.name) | join(" ")' | string split " "); end
function uu-pip; for P in "python -m pip" "sudo python -m pip" "pypy3 -m pip" "sudo pypy3 -m pip"; eval "echo (P=\"$P\" lsoutdated-pip | string split ' ' | grep -v cairocffi) | xargs $P install --upgrade pip "; end; end
#alias uu-nim="choosenim update self; choosenim update devel; nimble refresh || rm -rf $HOME/.nimble && nimble refresh; for nim_package in (nimble list --installed | cut -d' ' -f1); nimble --accept install $nim_package"
alias uu-fish="fisher update; fish_update_completions"
alias uu-node="install-fnm; npm install -g npm; npm -g update"
#alias uu-brl="sudo brl apply; sudo brl update"
#alias uu-apt="sudo apt update; sudo apt -y full-upgrade; sudo apt -y autoremove"
#alias uu-dnf="sudo dnf check-update; sudo dnf -y distro-sync; sudo dnf -y autoremove"
#alias uu-chemacs="git -C ~/.emacs.d fetch; git -C ~/.emacs.d pull"
alias uu-doom="doom --force sync; doom --force upgrade; doom --force sync; doom --force purge"
alias uu-emacs="uu-doom"
alias uu-nvim="nvim -c 'UU' -c 'qa!'"
alias uu-noguix="uu-arch; uu-fish; uu-nix; uu-flatpak; uu-pip; uu-nim; uu-node; uu-emacs; uu-graal; install-blender-gruvbox; install-blender-dracula; install-blender-cad-sketcher; install-searx; install-pax-mc; install-packwiz-mc; uu-fontcache; install-capitaine-cursors-sainnhe; install-capitaine-cursors-sainnhe-root"
alias uu="uu-noguix; uu-guix"
alias uu-clean="uu; guixclean-full"
export add_package_cmd="sudo aura -S --needed "
#export add_package_cmd="guix install "
alias pkgadd="$add_package_cmd"
alias lfi="~/.config/lf/run_lf.sh"
alias lsa="exa -a"
alias getwinid="xwininfo -display :0"
alias lsmon="xrandr --query | grep ' connected' | cut -d' ' -f1"
alias lsports="ss -lntu"
#alias mc-run-client="./gradlew runClient"
#alias mc-build="./gradlew build"
alias show-weather="curl wttr.in/"
alias show-weather-detailed="curl v2.wttr.in/"
alias get-city="curl https://ipapi.co/city/"
alias show-weather-map='curl v3.wttr.in/(get-city).sxl'
alias show-weather-map-kitty='curl v3.wttr.in/(get-city).png | kitty +kitten icat'
alias show-weather-moon="curl wttr.in/Moon"
alias spark-runtime='ps -A | string replace --filter --regex -- ".*(\d+):(\d+).*" "\$1 * 3600 + \$2 * 60" | bc | spark'
alias fake-virus-scan="tree /; echo 'No Viruses Found!'"


# Env
set GUIX_PROFILE "$HOME/.config/guix/current"
if test -d "$GUIX_PROFILE"; bass . "$GUIX_PROFILE/etc/profile"; end

#. "/run/current-system/profile/etc/profile.d/nix.sh"
set NIX_PROFILE "$HOME/.nix-profile"
#if test -d "$NIX_PROFILE"; bass . "$NIX_PROFILE/etc/profile.d/nix.sh"; end

if test -f "$HOME/.profile"; bass . "$HOME/.profile"; end

# Atuin
fish_vi_key_bindings
#if type -q atuin; atuin init fish | ATUIN_NOBIND=1 source; end

# fnm
#if test -f $HOME/.fnm/fnm; fnm env | source; end

# Ferium
if type -q ferium; ferium complete fish | source; end

# Packwiz
if type -q packwiz; packwiz completion fish | source; end

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
#bind \cr _atuin_search
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
#if bind -M insert > /dev/null 2>&1;
#    bind -M insert \cr _atuin_search;
#end

# Themes
#base16-onedark
#base16-gruvbox-dark-hard
base16-gruvbox-dark-medium
#theme_gruvbox dark hard

# Other Inits
# pnpm
set -gx PNPM_HOME "/home/dunk/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# SDKman
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#test -f "$HOME/.sdkman/bin/sdkman-init.sh" && bass source "$HOME/.sdkman/bin/sdkman-init.sh"

