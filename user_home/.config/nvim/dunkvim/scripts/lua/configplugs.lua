-- require'nvim-lsp-installer'.on_server_ready(function(server)
--     local opts = {}
-- 
--     -- (optional) Customize the options passed to the server
--     -- if server.name == "tsserver" then
--     --     opts.root_dir = function() ... end
--     -- end
-- 
--     -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
--         server:setup(opts)
--         vim.cmd [[ do User LspAttachBuffers ]]
--     end)

-- function setup_servers()
--   local servers = require'nvim-lsp-installer.servers'.get_installed_servers()
--   for i=1, #servers do
--       servers[i]:setup({})
--   end
-- end
-- 
-- setup_servers()
-- 
-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
-- require'nvim-lsp-installer'.post_install_hook = function ()
--   setup_servers() -- reload installed servers
--   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
-- end


-- require("indent_blankline").setup( {
--     -- char = "|",
--     filetype_exclude = {"help", "terminal", "dashboard"},
--     buftype_exclude = {"terminal"},
--     opt = true
-- })


require("mason").setup({
    install_root_dir = vim.fn.DunkvimExternalDir() .. "/mason"
})
require("mason-lspconfig").setup({
    ensure_installed = { "jdtls", "pyright" }
})



local lspzero = require('lsp-zero')

lspzero.preset('recommended')
lspzero.setup()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')

local cmp_config = lspzero.defaults.cmp_config({
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    window = {
        completion = cmp.config.window.bordered()
    },
})

cmp.setup(cmp_config)

require('bufferline').setup {
  options = {
    numbers = "both",
    close_command = "bdelete %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = "bdelete %d",          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator = {
        style = 'icon',
        icon = '▎',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    offsets = {{filetype = "NvimTree"}, {filetype="CHADTree"}},
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thick", -- {'/', '|'}, -- "thin", -- "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'directory'
  }
}

--require('lspsaga').init_lsp_saga()

-- require('lualine').setup {
--     options = {
--         theme = 'auto'
--     }
-- }

local gl = require('galaxyline')
-- local colors = require('galaxyline.theme').default
local colors = {
  bg = '#'..vim.api.nvim_get_color_by_name('bg'),
  fg = '#'..vim.api.nvim_get_color_by_name('fg'),
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef';
  red = '#ec5f67';
}

local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','CHADTREE','vista','dbui','packer'}

gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.red,colors.bg}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                          [''] = colors.blue,V=colors.blue,
                          c = colors.magenta,no = colors.red,s = colors.orange,
                          S=colors.orange,[''] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return ' '..vim.fn.mode()..' '
    end,
    highlight = {colors.red,colors.bg,'bold'},
  },
}
gls.left[3] = {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg}
  }
}
gls.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}

gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.orange,colors.bg,'bold'}
  }
}

gls.left[6] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}

gls.left[7] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'},
  }
}

gls.left[8] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[9] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}

gls.left[10] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan,colors.bg},
  }
}

gls.left[11] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}

gls.mid[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}

gls.right[1] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
}

gls.right[2] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
}

gls.right[3] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[4] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[5] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
}
gls.right[6] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange,colors.bg},
  }
}
gls.right[7] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red,colors.bg},
  }
}

gls.right[8] = {
  RainbowBlue = {
    provider = function() return ' ▊' end,
    highlight = {colors.blue,colors.bg}
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}

-- require('nvim-autopairs').setup{}
-- require("nvim-autopairs.completion.compe").setup({
--   map_cr = true, --  map <CR> on insert mode
--   map_complete = true, -- it will auto insert `(` after select function or method item
--   auto_select = false  -- auto select first item
-- })

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
    view = {
        mappings = {
            list = {
                {key = { "<CR>", "o", "l", "<2-LeftMouse>" }, action = "edit" },
            },
        },
    },
})

-- require'nvim-tree'.setup {
--     disable_netrw = true,
--     hijack_netrw = true,
--     hijack_cursor = true,
--     auto_close = true,
--     update_cwd = true,
--     ignore_ft_on_setup = {'startify', 'dashboard'},
--     diagnostics = {
--         enable = true,
--         icons = {
--             hint = "",
--             info = "",
--             warning = "",
--             error = "",
--         }
--     },
--     group_empty = false,
--     indent_markers = true,
--     highlight_opened_files = true,
--     tree_git_hl = true,
--     add_trailing = true,
--     view = {
--         width = 30,
--         height = 30,
--         side = 'left',
--         auto_resize = true,
--         mappings = {
--           custom_only = false,
--           list = {}
--         }
--     },
-- }

require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}


require("telescope").setup {
--  extensions = {
--    ["ui-select"] = {
--      require("telescope.themes").get_dropdown {
--        -- even more opts
--      }
--
--      -- pseudo code / specification for writing custom displays, like the one
--      -- for "codeactions"
--      -- specific_opts = {
--      --   [kind] = {
--      --     make_indexed = function(items) -> indexed_items, width,
--      --     make_displayer = function(widths) -> displayer
--      --     make_display = function(displayer) -> function(e)
--      --     make_ordinal = function(e) -> string
--      --   },
--      --   -- for example to disable the custom builtin "codeactions" display
--      --      do the following
--      --   codeactions = false,
--      -- }
--    }
--  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
--require("telescope").load_extension("ui-select")


function start_nvim_jdtls()
    --local servers = require'nvim-lsp-installer.servers'
    --if servers.is_server_installed('jdtls') then
        require('jdtls').start_or_attach({
          -- The command that starts the language server
          cmd = {
              vim.fn.DunkvimExternalDir() .. "/mason/bin/jdtls",
              vim.fn.getcwd()
          },

          -- This is the default if not provided, you can remove it. Or adjust as needed.
          -- One dedicated LSP server & client will be started per unique root_dir
          root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
        })
    --end
end

