# Vars
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.nix-profile/bin:/usr/local/bin:~/.nimble/bin:~/Launchers:~/ProgramFiles/doom-emacs/bin/
export TERM=xterm-256color
# export TERM=xterm-kitty
export guix_gnu_pkgs="$HOME/.config/guix/current/share/guile/site/3.0/gnu/packages/"
export superdrive="$HOME/superdrive-ln/"
export programming="$superdrive/Programming/"
export mcmoddev="$programming/Java/MC/MinecraftModDev/"
export games="$superdrive/Games/"
export gdlauncher="$games/GDlauncher/"
export mcinstances="$gdlauncher/instances/"
#export VISUAL="emacs -nw"
#export EDITOR="emacs -nw"
#export ALTERNATE_EDITOR=""


# Aliases
alias sudo="sudo "
alias install-zim-script="curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh"
alias install-zim="wget -O $HOME/.zlogin https://raw.githubusercontent.com/zimfw/install/master/src/templates/zlogin; wget -O $HOME/.zshenv https://raw.githubusercontent.com/zimfw/install/master/src/templates/zshenv; mkdir -p $HOME/.zim; wget -O $HOME/.zim/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh; zsh $HOME/.zim/zimfw.zsh install"
alias install-brl="wget -O /tmp/brl-installer.sh https://raw.githubusercontent.com/bedrocklinux/bedrocklinux-userland/master/src/installer/installer.sh; sudo sh /tmp/brl-installer.sh --hijack"
alias install-guix="wget -O /tmp/guix-install.sh https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh; sudo sh yes | /tmp/guix-install.sh"
alias install-nix="curl -L https://nixos.org/nix/install | sh"
alias install-chemacs="[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; [ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak; git clone https://github.com/plexus/chemacs2.git ~/.emacs.d"
alias install-doom="mkdir -p ~/ProgramFiles; git clone --depth 1 https://github.com/hlissner/doom-emacs ~/ProgramFiles/doom-emacs; ~/ProgramFiles/doom-emacs/bin/doom install"
alias install-fnm="curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell; fnm install --lts"
alias install-nvm="wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/latest/install.sh | bash; nvm install node"
alias install-choosenim="curl https://nim-lang.org/choosenim/init.sh -sSf | sh"
alias uu-fontcache="fc-cache -rv"
alias uu-zim="zimfw upgrade; zimfw update"
alias uu-arch="paru -Syyu --noconfirm --needed; paru -c; paru -cc; sudo paccache -rk 1; sudo paccache -ruk0"
alias uu-flatpak="flatpak update; flatpak uninstall --unused"
alias guixclean="guix gc; guix gc --optimize"
alias guixclean-full="guix gc --delete-generations; guixclean"
alias guixfix="sudo guix gc --verify=contents,repair"
alias guixconf="sudo -E guix system -L ~/.config/guix/base reconfigure ~/.config/guix/dunk-system-biggus.scm"
alias guixmanifest='guix package --manifest=$HOME/.config/guix/base/manifest-main.scm'
alias uu-guix="guix pull; guix package -u; guixclean"
alias uu-nix="nix-channel --update; nix-env --upgrade; nix-collect-garbage --delete-old"
alias uu-ros="ros --eval '(ql:update-all-dists)'"
alias uu-stack="stack upgrade; stack update"
alias lsoutdated-pip="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1"
alias uu-pip='pip install $(lsoutdated-pip)'
alias uu-pip-root='sudo pip install $(sudo lsoutdated-pip)'
alias uu-nim='choosenim update self; choosenim update devel; nimble refresh || rm -rf $HOME/.nimble && nimble refresh; for nim_package in $(nimble list --installed | cut -d" " -f1); nimble --accept install $nim_package'
alias uu-node="install-fnm; npm install -g npm; npm -g update"
alias uu-zinit="zinit update"
alias uu-brl="sudo brl apply; sudo brl update"
alias uu-apt="sudo apt update; sudo apt -y full-upgrade; sudo apt -y autoremove"
alias uu-dnf="sudo dnf check-update; sudo dnf -y distro-sync; sudo dnf -y autoremove"
alias uu-doom="doom --yes upgrade; doom --yes sync; doom --yes purge"
alias uu-nvim="nvim -c 'UU' -c 'qa!'"
alias uu-noguix="uu-arch; uu-nix; uu-flatpak; uu-pip; uu-nim; uu-node; uu-zim; uu-doom"
alias uu="uu-noguix; uu-guix"
alias uu-clean="uu; guixclean-full"
export add_package_cmd="paru -S "
#export add_package_cmd="guix install "
alias lsa='exa -a'
alias getwinid="xwininfo -display :0"
alias lsmon="xrandr --query | grep ' connected' | cut -d' ' -f1"
alias mc-run-client='./gradlew runClient'
alias mc-build='./gradlew build'
alias show-weather='curl wttr.in/'
alias show-weather-detailed='curl v2.wttr.in/'
alias get-city='curl https://ipapi.co/city/'
alias show-weather-map='curl v3.wttr.in/$(get-city).sxl'
alias show-weather-map-kitty='curl v3.wttr.in/$(get-city).png | kitty +kitten icat'
alias show-weather-moon='curl wttr.in/Moon'


# Init


set ZSH_AUTOSUGGEST_USE_ASYNC

#zmodload zsh/complist
#zstyle ':completion:*' menu yes select

#autoload -Uz compinit
#compinit


GUIX_PROFILE="$HOME/.config/guix/current"
if [[ -d "$GUIX_PROFILE" ]]; then . "$GUIX_PROFILE/etc/profile"; fi

#. "/run/current-system/profile/etc/profile.d/nix.sh"
#NIX_PROFILE="$HOME/.nix-profile"
#if [[ -d "$NIX_PROFILE" ]]; then . "$NIX_PROFILE/etc/profile.d/nix.sh"; fi


#SAVEHIST=75
#HISTFILE=~/.zsh_history

# cowsay 'Hello!' | lolcat

# autoload -U colors && colors
# PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%(5~|%-1~/.../%3~|%4~) %{$reset_color%}%% "
# eval "$(starship init zsh)"


# fnm
export PATH=$HOME/.fnm:$PATH
if [[ -f $HOME/.fnm/fnm ]]; then eval "`fnm env`"; fi

# nvm
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
#
## place this after nvm initialization!
#autoload -U add-zsh-hook
#load-nvmrc() {
#  local node_version="$(nvm version)"
#  local nvmrc_path="$(nvm_find_nvmrc)"
#
#  if [ -n "$nvmrc_path" ]; then
#    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#
#    if [ "$nvmrc_node_version" = "N/A" ]; then
#      nvm install
#    elif [ "$nvmrc_node_version" != "$node_version" ]; then
#      nvm use
#    fi
#  elif [ "$node_version" != "$(nvm version default)" ]; then
#    echo "Reverting to nvm default version"
#    nvm use default
#  fi
#}
#add-zsh-hook chpwd load-nvmrc
#load-nvmrc


key-clear() {
    printf '\033c'
    clear
    zle reset-prompt
    zle redisplay
}
zle -N key-clear

bindkey -s "^k" 'clear\n'
bindkey -s "^f" 'ranger\n'
bindkey -s "^n" 'nvim\n'
bindkey -s "^o" 'nvim '
bindkey -s "^u" 'uu-clean\n'
bindkey -s "^b" 'btop\n'
bindkey -s "^a" $add_package_cmd

# tmux

# Completion for kitty
#if [[ $TERMINFO =~ "kitty" ]]; then kitty + complete setup zsh | source /dev/stdin; fi


#if [[ ! -d "$ZIM_HOME" ]]; then install-zim; fi

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  # Download zimfw script if missing.
  command mkdir -p ${ZIM_HOME}
  if (( ${+commands[curl]} )); then
    command curl -fsSL -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    command wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

#bindkey '^P' history-substring-search-up
#bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

