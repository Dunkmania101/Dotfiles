return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim", "lua", "vimdoc",
                "html", "css"
            },
        },
    },
    {
        'vimwiki/vimwiki',
        lazy = false,
        init = function () --replace 'config' with 'init'
            vim.g.vimwiki_list = {{path = '~/superdrive-ln/Docs/VimWiki', syntax = 'markdown', ext = '.md'}}
        end
    },
    -- { import = "nvchad.blink.lazyspec" }
}

