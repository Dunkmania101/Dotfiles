if $amirealvim
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pyright',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-java',
    \ 'coc-vimlsp',
    \ 'coc-explorer',
    \ ]
  "  autocmd VimEnter * CocInstall
  autocmd VimEnter * TSInstall all
  autocmd VimEnter * TSEnable rainbow highlight indent
endif

if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif

if executable('rg')
    let g:CtrlSpaceGlobCommand = 'rg --color=never --files'
elseif executable('fd')
    let g:CtrlSpaceGlobCommand = 'fd --type=file --color=never'
elseif executable('ag')
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
