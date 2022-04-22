let g:mapleader="\<space>"

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap U <C-r>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <C-q> :q<CR>
nnoremap <C-S-q> :q!<CR>
nnoremap <C-A-q> :qa<CR>
nnoremap <C-A-S-q> :qa!<CR>
inoremap <C-q> <Esc>:q<CR>==gi
inoremap <C-S-q> <Esc>:q!<CR>==gi
inoremap <C-A-q> <Esc>:qa<CR>==gi
inoremap <C-A-S-q> <Esc>:qa!<CR>==gi
vnoremap <C-q> :q<CR>gv=gv
vnoremap <C-S-q> :q!<CR>gv=gv
vnoremap <C-A-q> :qa<CR>gv=gv
vnoremap <C-A-S-q> :qa!<CR>gv=gv

" inoremap <C-c> <Esc>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>==gi
vnoremap <C-s> <Esc>:w<CR>gv=gv


if $amirealvim
  nnoremap <leader>b :CtrlPBuffer<CR>
  nnoremap <c>p :CtrlP<CR>
  nmap <leader>p :Glow<CR>
  nmap <silent> g\ :Telescope ultisnips ultisnips<CR>

  nnoremap <A-S-j> :resize -2<CR>
  nnoremap <A-S-k> :resize +2<CR>
  nnoremap <A-S-h> :vertical resize -2<CR>
  nnoremap <A-S-l> :vertical resize +2<CR>

  inoremap <silent><expr> <C-Space> compe#complete()
  inoremap <silent><expr> <CR>      compe#confirm('<CR>')
  inoremap <silent><expr> <C-e>     compe#close('<C-e>')
  inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
  inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

  nmap gd :lua vim.lsp.buf.definition()<CR>
  nmap gD :lua vim.lsp.buf.declaration()<CR>
  nmap gr :lua vim.lsp.buf.references()<CR>
  nmap gR :lua vim.lsp.buf.rename()<CR>
  nmap gt :lua vim.lsp.buf.type_definition()<CR>
  nmap gf :lua vim.lsp.buf.formatting()<CR>
  nmap gi :lua vim.lsp.buf.implementation()<CR>
  nmap gs :lua vim.lsp.buf.signature_help()<CR>
  nmap gca :lua vim.lsp.bufncode_action()<CR>
  " nmap gd :call LanguageClient_textDocument_definition()<CR>
  " nmap gr :cal LanguageClient_textDocument_references()<CR>
  " nmap grn :call LanguageClient_textDocument_rename<CR>
  " nnoremap <silent> gd :Lspsaga preview_definition<CR>
  " nnoremap <silent> gh :Lspsaga lsp_finder<CR>
  " nnoremap <silent><leader>ca :Lspsaga code_action<CR>
  " vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
  " nnoremap <silent>K :Lspsaga hover_doc<CR>
  " nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
  " nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
  " nnoremap <silent> gs :Lspsaga signature_help<CR>
  " nnoremap <silent>grn :Lspsaga rename<CR>

  nmap got :FloatermToggle<CR>
  nmap gou :MundoToggle<CR>

  nmap <leader>qq :q<CR>
  nmap <leader>qwq :wq<CR>
  nmap <leader>QQ :q!<CR>
  nmap <leader>QWQ :wq!<CR>

  nmap <silent> <A-h> :wincmd h<CR>
  nmap <silent> <A-j> :wincmd j<CR>
  nmap <silent> <A-k> :wincmd k<CR>
  nmap <silent> <A-l> :wincmd l<CR>

  nnoremap <leader>oft :RnvimrToggle<CR>
  nnoremap <leader>ofv :RangerVSplit<CR>
  nnoremap f :CHADopen<CR>

  nnoremap <silent> bg :BufferLinePick<CR>
  nnoremap <silent> bc :lua require('close_buffers').delete({type = 'this'})<CR>
  nnoremap <silent> bC :BufferLinePickClose<CR>
  nnoremap <silent> bl :BufferLineCycleNext<CR>
  nnoremap <silent> bk :BufferLineCycleNext<CR>
  nnoremap <silent> bh :BufferLineCyclePrev<CR>
  nnoremap <silent> bj :BufferLineCyclePrev<CR>
  nnoremap <silent> be :BufferLineSortByExtension<CR>
  nnoremap <silent> bd :BufferLineSortByDirectory<CR>
endif


if $amirealvim && has("nvim")
endif
