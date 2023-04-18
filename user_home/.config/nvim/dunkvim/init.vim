""""""""""
" Config

" Check if we're in another editor
let $amivscode = exists('g:vscode')
let $amirealvim = !($amivscode)

" Dunkvim Specific Paths
" Set Dunkvim Path
let $dunkvimdir = $HOME . '/.config/nvim/dunkvim'

" Set External Path (for plugins, etc.)
let $externaldir = $dunkvimdir . '/external'

function! DunkvimDir()
    return $dunkvimdir
endfunction
function! DunkvimExternalDir()
    return $externaldir
endfunction

" Set Color Scheme To Load
let $colorsname = 'gruvbox-material' " Valid are 'gruvbox-material' / 'sonokai' / 'onedark' / 'everforest'
""""""""""

""""""""""
" Run All The Things! - Where did that "All The Things!" thing come from, anyway?

" Plugins
source $dunkvimdir/scripts/initplugs.vim

" Custom Commands
source $dunkvimdir/scripts/initcmds.vim

" Colors
source $dunkvimdir/scripts/initcolors.vim

" Keybinds
source $dunkvimdir/scripts/initkeys.vim

" Autostart Stuff
source $dunkvimdir/scripts/autostart.vim

""""""""""
