" Themes
" Plug 'morhetz/gruvbox'
Plug 'rktjmp/lush.nvim'
" Plug 'npxbr/gruvbox.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
" Plug 'joshdick/onedark.vim'
Plug 'navarasu/onedark.nvim'
Plug 'sainnhe/sonokai'

" Fancy
"Plug 'mhinz/vim-startify'
"Plug 'nvimdev/dashboard-nvim'
" Plug 'konapun/vacuumline.nvim'
Plug 'nvimdev/galaxyline.nvim' , {'branch': 'main'}
" Plug 'itchyny/lightline.vim'
" Plug 'hoob3rt/lualine.nvim'
" Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'master'}
Plug 'Yggdroot/indentLine'

" Buffer Management
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kazhala/close-buffers.nvim'

" Motion
Plug 'justinmk/vim-sneak'
Plug 'psliwka/vim-smoothie'
"Plug 'liuchengxu/vista.vim'

" Changes
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'

" Term
Plug 'voldikss/vim-floaterm'

" Files
" Plug 'kevinhwang91/rnvimr'
" Plug 'rafaqz/ranger.vim'
" Plug 'kyazdani42/nvim-web-devicons' " for file icons
" Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'

" Icons
" Plug 'ryanoasis/vim-devicons'
" Plug 'onsails/lspkind-nvim'

" Syntax
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dgileadi/vscode-java-decompiler'
" Plug 'Stevertus/mcscript'
" Plug 'twh2898/vim-scarpet'
" Plug 'valloric/youcompleteme'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-tagprefix'
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'ncm2/ncm2-markdown-subscope'
" Plug 'ncm2/ncm2-rst-subscope'
" Plug 'hrsh7th/nvim-compe'
" Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-jdtls'
" Plug 'alvan/vim-closetag'
" Plug 'tpope/vim-surround'
" Plug 'machakann/vim-sandwich'
" Plug 'windwp/nvim-autopairs'
" Plug 'scrooloose/syntastic'
" Plug 'mattn/emmet-vim'
" Plug 'dense-analysis/ale'
" Plug 'neovim/nvim-lspconfig'
" Plug 'williamboman/nvim-lsp-installer'
" Plug 'kabouzeid/nvim-lspinstall'
" Plug 'p00f/nvim-ts-rainbow'
Plug 'https://github.com/ap/vim-css-color.git'
" LSP-Zero
Plug 'VonHeikemen/lsp-zero.nvim'
" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
"Plug 'mfussenegger/nvim-lint'
" DAP
"Plug 'mfussenegger/nvim-dap'
"Plug 'nvim-neotest/nvim-nio'
"Plug 'rcarriga/nvim-dap-ui'

" Autocompletion
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'hrsh7th/cmp-nvim-lua'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'

" For luasnip users.
" Plug 'saadparwaiz1/cmp_luasnip'

" For ultisnips users.
"Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
"Plug 'fhill2/telescope-ultisnips.nvim'
"Plug 'rafamadriz/friendly-snippets'

" Snippets
" Plug 'L3MON4D3/LuaSnip'
"Plug 'sirver/ultisnips'
" Plug 'rafamadriz/friendly-snippets'
"Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Format
"Plug 'godlygeek/tabular'
"Plug 'sbdchd/neoformat'
Plug 'mhartington/formatter.nvim'

" Build
Plug 'neomake/neomake'

" Fuzzy
Plug 'junegunn/fzf'
Plug 'ctrlpvim/ctrlp.vim'

" Space
"Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'vimwiki/vimwiki'

" Misc
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall','branch':'main'}
Plug 'RRethy/vim-illuminate'

" Non-Embeddable Stuff
if $amirealvim
  " Files
  "Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':CHADdeps'}
endif

