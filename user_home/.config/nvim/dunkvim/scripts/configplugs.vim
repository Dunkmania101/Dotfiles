let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'component_function': {
  \    'filename': 'BufAbsPath'
  \  }
  \ }

let g:mundo_right = 1

" let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed        = 'never'

let g:ale_linters = {
\   'nim':      ['nimlsp', 'nimcheck'],
\}

let g:ale_fixers = {
\   'nim':      ['nimpretty'],
\   '*':        ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:false
let g:compe.source.treesitter = v:false

" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_diagnosticsList = "Location"
" let g:LanguageClient_rootMarkers = {
"     \ 'java': ['.git']
"     \ }
" let g:LanguageClient_serverCommands = {
"     \ 'java': [$dunkvimdir . '/scripts/java-lsp.sh']
"     \ }

if has('nvim')
    :luafile $dunkvimdir/scripts/lua/configplugs.lua
    " :luafile $dunkvimdir/scripts/lua/evil_lualine.lua
endif

if $amirealvim
    autocmd BufNewFile,BufRead * lua setup_servers()
    autocmd FileType java lua start_nvim_jdtls()
"        call coc#config(
"             \ 'explorer',
"             \  {
"             \     "icon.enableVimDevicons": v:true,
"             \     "icon.enableNerdfont": v:true
"             \  }
"             \)
" 
"       call coc#config(
"             \  'java',
"             \  {
"             \    "jdt.ls.vmargs": "-javaagent:/usr/local/share/lombok/lombok.jar",
"             \    "referencesCodeLens.enabled": v:true
"             \  }
"             \ )
" 
"       call coc#config(
"             \   'codeLens',
"             \   {
"             \      'enable': v:true
"             \   }
"             \ )
endif

let g:dashboard_default_executive = 'telescope'

let g:dashboard_custom_header = [
    \' _____    _ _ _   _ ',
    \'| ____|__| (_) |_| |',
    \'|  _| / _` | | __| |',
    \'| |__| (_| | | |_|_|',
    \'|_____\__,_|_|\__(_)'
    \]

" let g:nvim_tree_icons = {
"     \ 'default': '',
"     \ 'symlink': '',
"     \ 'git': {
"     \   'unstaged': "✗",
"     \   'staged': "✓",
"     \   'unmerged': "",
"     \   'renamed': "➜",
"     \   'untracked': "★",
"     \   'deleted': "",
"     \   'ignored': "◌"
"     \   },
"     \ 'folder': {
"     \   'arrow_open': "",
"     \   'arrow_closed': "",
"     \   'default': "",
"     \   'open': "",
"     \   'empty': "",
"     \   'empty_open': "",
"     \   'symlink': "",
"     \   'symlink_open': "",
"     \   },
"     \   'lsp': {
"     \     'hint': "",
"     \     'info': "",
"     \     'warning': "",
"     \     'error': "",
"     \   }
"     \ }
" 
" highlight NvimTreeFolderIcon guibg=green
" 
" :lua require'nvim-tree'.setup()

let g:indentLine_fileTypeExclude = ['startify', 'dashboard']

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:chadtree_settings = {'theme': {'text_colour_set': 'nerdtree_syntax_dark'}}
