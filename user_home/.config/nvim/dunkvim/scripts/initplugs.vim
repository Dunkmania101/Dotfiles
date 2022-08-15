if empty(glob($externaldir . '/autoload/plug.vim'))
    silent !curl -fLo $externaldir/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

source $externaldir/autoload/plug.vim
call plug#begin($externaldir . '/plugged')
source $dunkvimdir/plugslist.vim
call plug#end()

autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif

source $dunkvimdir/scripts/setupplugs.vim
source $dunkvimdir/scripts/configplugs.vim

:command UU PlugUpgrade | PlugUpdate | source $dunkvimdir/scripts/setupplugs.vim | TSUpdate | CocUpdate

