""""""""""
" Config

" Check if we're in another editor
let $amivscode = exists('g:vscode')
let $amirealvim = !($amivscode)

" Set Dunkvim Path
let $dunkvimdir = $HOME . '/.config/nvim/dunkvim'

" Set Color Scheme To Load
let $colorsname = 'gruvbox-material' " Valid are 'gruvbox-material' / 'sonokai' / 'onedark'
""""""""""

""""""""""
" Run All The Things! - Where did that "All The Things!" thing come from, anyway?

" Set External Path (for plugins, etc.)
let $externaldir = $dunkvimdir . '/external'

" Plugins
source $dunkvimdir/scripts/initplugs.vim

" Autostart Stuff
source $dunkvimdir/scripts/autostart.vim

" Custom Commands
source $dunkvimdir/scripts/initcmds.vim

" Colors
source $dunkvimdir/scripts/initcolors.vim

" Keybinds
source $dunkvimdir/scripts/initkeys.vim
""""""""""
