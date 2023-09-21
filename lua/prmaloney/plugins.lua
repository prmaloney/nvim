local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local colorscheme = 'kanagawa'

require('lazy').setup({
    {
      'prmaloney/valet.nvim',
      dev = true,
      config = function()
        require('valet').setup({
          delete_finished = true,
          after_all = function()
            if vim.fn.argc() == 0 then
              vim.cmd('Alpha')
            end
          end
        })
      end,
    },
    {
      'prmaloney/inline-fold.nvim',
      dev = true,
    },
    {
      'rebelot/kanagawa.nvim',
      config = function()
        require("kanagawa").setup({
          transparent = true,
        })
      end
    },
    {
      'rose-pine/neovim',
      config = function()
        require("rose-pine").setup({
          disable_background = true
        })
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            disabled_filetypes = {}
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
            } },
            lualine_x = {
              {
                'diagnostics',
                sources = { "nvim_diagnostic" },
                symbols = {
                  error = ' ',
                  warn = ' ',
                  info = ' ',
                  hint = ' '
                }
              },
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
            } },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
        }
      end
    },
    'tpope/vim-surround',
    {
      'folke/flash.nvim',
      event = 'VeryLazy',
      ---@type Flash.Config
      opts = {},
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
        {
          "S",
          mode = { "n", "o", "x" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
        {
          "r",
          mode = "o",
          function()
            require("flash").remote()
          end,
          desc = "Remote Flash",
        },
        {
          "R",
          mode = { "o", "x" },
          function()
            require("flash").treesitter_search()
          end,
          desc = "Flash Treesitter Search",
        },
        {
          "<c-s>",
          mode = { "c" },
          function()
            require("flash").toggle()
          end,
          desc = "Toggle Flash Search",
        },
      },
    },
    {
      'jinh0/eyeliner.nvim',
      opts = { highlight_on_key = true },
    },
    {
      'nvim-telescope/telescope.nvim',
      lazy = false,
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
        { '<leader>f',  '<cmd>Telescope find_files<cr>' },
        { '<leader>F',  '<cmd>Telescope live_grep<cr>' },
        { '<leader>br', '<cmd>Telescope git_branches<cr>' },
        { '<leader>bf', '<cmd>Telescope buffers<cr>' },
        { '<leader>ht', '<cmd>Telescope help_tags<cr>' },
        { '<leader>tr', '<cmd>Telescope lsp_references<cr>' },
        { '<leader>td', '<cmd>Telescope lsp_definitions<cr>' },
      },
      config = function()
        require('telescope').setup {
          defaults = {
            mappings = {
              i = {
                ["<esc>"] = require('telescope.actions').close,
              }
            }
          },
          pickers = {
            buffers = {
              mappings = {
                i = {
                  ["<C-x>"] = "delete_buffer",
                }
              }
            }
          }
        }
      end
    },
    {
      'VonHeikemen/lsp-zero.nvim',
      dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        'nvim-tree/nvim-web-devicons',
        'glepnir/lspsaga.nvim',
        'folke/neodev.nvim',
      },
      config = function()
        local lsp = require('lsp-zero')
        lsp.preset({})

        local cmp = require('cmp')
        cmp.setup({
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
          },
        })

        require('lspsaga').setup()

        lsp.on_attach(function(_, bufnr)
          local nnoremap = require('prmaloney.keymap').nnoremap

          -- lspsaga mappings
          nnoremap('gr', '<Cmd>Lspsaga lsp_finder<cr>')
          nnoremap('K', '<Cmd>Lspsaga hover_doc<cr>')
          nnoremap('<leader>ca', '<Cmd>Lspsaga code_action<cr>')

          nnoremap('gd', '<Cmd>Telescope lsp_definitions<cr>')
          nnoremap('go', '<Cmd>Telescope lsp_type_definitions<cr>')
          nnoremap('gi', '<Cmd>Telescope lsp_implementations<cr>')

          nnoremap('dl', '<Cmd>Lspsaga show_line_diagnostics<cr>')
          nnoremap('dn', '<Cmd>Lspsaga diagnostic_jump_next<cr>')
          nnoremap('dp', '<Cmd>Lspsaga diagnostic_jump_prev<cr>')
          nnoremap('gp', '<Cmd>Lspsaga peek_definition<cr>')

          if vim.bo.filetype == 'markdown' then
            nnoremap('<leader>pp', function() require('peek').open() end)
          end
        end)

        lsp.configure('tailwindcss', {
          on_attach = function()
            require('prmaloney.keymap').nnoremap('<leader>cn',
              function() require('inline-fold').fold_node_at_cursor() end)

            local function fold_attributes_for_node(node)
              if node == nil then return end

              local is_class = false
              if node:parent() and node:parent():parent() and node:type() == 'attribute_value' then
                for sibling, _ in node:parent():parent():iter_children() do
                  if vim.treesitter.get_node_text(sibling, 0) == 'class'
                      or vim.treesitter.get_node_text(sibling, 0) == 'className' then
                    is_class = true
                  end
                end
              end

              if is_class then
                require('inline-fold').fold_node(node)
              end

              for child, _ in node:iter_children() do
                fold_attributes_for_node(child)
              end
            end

            local function fold_all_classes()
              local lang_tree = require('nvim-treesitter.parsers').get_parser(0)
              if lang_tree == nil then return end

              for _, tree in ipairs(lang_tree:trees()) do
                local root = tree:root()
                fold_attributes_for_node(root)
              end
            end

            fold_all_classes()
            vim.api.nvim_create_user_command('TFToggle', fold_all_classes, {})
            vim.api.nvim_create_autocmd('InsertLeave', { callback = fold_all_classes })
          end
        })

        require("neodev").setup({
          override = function(_, library)
            library.enabled = true
            library.plugins = true
          end,
        })

        lsp.setup()
      end
    },
    {
      'folke/noice.nvim',
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify"
      },
      config = function()
        require('noice').setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
          },
        })
      end
    },
    {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        local null_ls = require('null-ls')
        local prettier = null_ls.builtins.formatting.prettier
        table.insert(prettier.filetypes, 'svelte')
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.diagnostics.eslint,
          }
        })
        vim.api.nvim_create_autocmd('BufWritePre', { callback = function() vim.lsp.buf.format() end })
      end
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          highlight = { enable = true },
          indent = { enable = true }
        }
      end
    },
    'nvim-treesitter/playground',
    {
      'stevearc/oil.nvim',
      config = function()
        require('oil').setup()
        require('prmaloney.keymap').nnoremap('<leader>a', function()
          require('oil').open()
        end)
      end,
    },
    {
      's1n7ax/nvim-window-picker',
      config = true,
    },
    {
      'numToStr/Comment.nvim',
      config = true,
    },
    {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
      'ThePrimeagen/harpoon',
      config = function()
        local nnoremap = require('prmaloney.keymap').nnoremap

        nnoremap('<leader>hp', function() require('harpoon.ui').toggle_quick_menu() end)
        nnoremap('<c-m>', function() require('harpoon.mark').add_file() end)

        nnoremap('<leader>j', function() require('harpoon.ui').nav_file(1) end)
        nnoremap('<leader>k', function() require('harpoon.ui').nav_file(2) end)
        nnoremap('<leader>l', function() require('harpoon.ui').nav_file(3) end)
        nnoremap('<leader>;', function() require('harpoon.ui').nav_file(4) end)

        nnoremap('<leader>J', function() require('harpoon.term').gotoTerminal(1) end)
        nnoremap('<leader>K', function() require('harpoon.term').gotoTerminal(2) end)
        nnoremap('<leader>cm', function() require('harpoon.cmd-ui').toggle_quick_menu() end)
        nnoremap('<leader>c1', function() require('harpoon.term').sendCommand(1, 1) end)
      end
    },
    {
      'akinsho/toggleterm.nvim',
      config = function()
        require("toggleterm").setup {
          open_mapping = [[<c-\>]],
          shade_terminals = false,
          on_open = function()
            require('prmaloney.keymap').tnoremap('<esc>', '<c-\\><c-n>')
          end
        }

        local nnoremap = require('prmaloney.keymap').nnoremap
        local Terminal = require('toggleterm.terminal').Terminal

        local lazygit = Terminal:new({
          cmd = "lazygit",
          dir = "git_dir",
          direction = "float",
          float_opts = {
            border = "double",
          },
          -- function to run on opening the terminal
          on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(term.bufnr, "i", "<esc>", "<esc>", { noremap = true, silent = true })
          end,
          -- function to run on closing the terminal
          on_close = function()
            vim.cmd("startinsert!")
          end,
        })

        nnoremap("<leader>gg", function() lazygit:toggle() end)
      end
    },
    {
      'windwp/nvim-autopairs',
      config = true,
    },
    {
      'windwp/nvim-ts-autotag',
      config = true,
    },
    {
      'toppair/peek.nvim',
      build = 'deno task --quiet build:fast',
      config = function()
        require('peek').setup({
          app = 'browser',
        });
      end
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup {
          show_current_context = true
        }
      end
    },
  },
  {
    dev = {
      path = '~/plugins'
    },
  }
)

vim.cmd('colorscheme ' .. colorscheme)
