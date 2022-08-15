autocmd BufNewFile,BufRead * setlocal spell

syntax enable
set completeopt=menuone,noselect
" set undofile
" set undodir=~/.vim/undo
set lazyredraw
set iskeyword+=-
set path+=**
set wildmenu
set formatoptions-=cro
set hidden
set nowrap
set whichwrap+=<,>,[,],h,l
set encoding=utf-8
set pumheight=10
set fileencoding=utf-8
set ruler
set cmdheight=2
set mouse=a
set splitbelow
filetype plugin indent on
set splitright
set termguicolors
if !has('gui_running')
    set t_Co=256
endif
set conceallevel=0
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set autoindent
set laststatus=2
set number
set cursorline
set background=dark
set showtabline=2
set noshowmode
set nocompatible
set nobackup
set nowritebackup
set shortmess+=c
set signcolumn=yes
set updatetime=100
set timeoutlen=700
set clipboard=unnamedplus
set incsearch
set guifont=Hack
let &t_ut=''

set display+=lastline
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

cmap w!! w !sudo tee %

""""""""""
" NERDTree Stuff
" autocmd VimEnter * NERDTree | wincmd p

" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"     \ quit | endif

" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
""""""""""

""""""""""
" Lsp Stuff
" autocmd BufEnter * call ncm2#enable_for_buffer()
""""""""""

""""""""""
"" COC Stuff
"if has("patch-8.1.1564")
"    " Recently vim can merge signcolumn and number column into one
"    set signcolumn=number
"else
"    set signcolumn=yes
"endif
"
"set statusline^=%{coc#status()}
"
"autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
""""""""""

