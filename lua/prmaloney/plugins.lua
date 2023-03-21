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

require('lazy').setup {
  {
    'prmaloney/valet.nvim',
    config = function()
      -- vim.opt.rtp:prepend('~/personal/valet.nvim/')

      require('valet').setup({
        after_all = function()
          if vim.fn.argc() == 0 then
            vim.cmd('Alpha')
          end
        end
      })
    end,
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
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
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
      { '<leader>bf', '<cmd>Telescope document_<cr>' },
      { '<leader>ht', '<cmd>Telescope help_tags<cr>' },
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
      'folke/neodev.nvim'
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset({
        name = 'recommended',
        set_lsp_keymaps = { omit = { 'gr', 'gd', 'K' } } -- I want something else for these ones
      })

      require('lspsaga').setup()

      lsp.on_attach(function()
        local nnoremap = require('prmaloney.keymap').nnoremap

        -- lspsaga mappings
        nnoremap('gr', '<Cmd>Lspsaga lsp_finder<cr>')
        nnoremap('K', '<Cmd>Lspsaga hover_doc<cr>')

        nnoremap('gd', '<Cmd>Telescope lsp_definitions<cr>')

        if vim.bo.filetype == 'markdown' then
          nnoremap('<leader>pp', function() require('peek').open() end)
        end
      end)

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
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
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
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        }
      })
      require('prmaloney.keymap').nnoremap('<leader>a', function()
        vim.cmd('Neotree toggle reveal')
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
  }
}

vim.cmd('colorscheme ' .. colorscheme)
