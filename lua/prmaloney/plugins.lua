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

require('lazy').setup {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup(
        {
          disable_background = true
        }
      )
      vim.cmd('colorscheme rose-pine')
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
            path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
          } },
          lualine_x = {
            { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
              hint = ' ' } },
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
            path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
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
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>f', '<cmd>Telescope find_files<cr>' },
      { '<leader>F', '<cmd>Telescope live_grep<cr>' },
      { '<leader>br', '<cmd>Telescope git_branches<cr>' },
      { '<leader>bf', '<cmd>Telescope buffers<cr>' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'cursor',
          layout_config = {
            cursor = { width = 0.75, height = 0.5, preview_width = 0.4 }
          },
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
      local nnoremap = require('prmaloney.keymap').nnoremap
      nnoremap('<leader>f', require('telescope.builtin').find_files)
      nnoremap('<leader>F', require('telescope.builtin').live_grep)
      nnoremap('<leader>br', require('telescope.builtin').git_branches)
      nnoremap('<leader>bf', require('telescope.builtin').buffers)
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
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      -- See :help lsp-zero-preferences
      lsp.set_preferences({
        set_lsp_keymaps = { omit = { '<F4', 'gr', 'K', } }, -- set to false if you want to configure your own keybindings
        manage_nvim_cmp = true, -- set to false if you want to configure nvim-cmp on your own
      })

      lsp.on_attach(function(_, bufnr)
        local nnoremap = require('prmaloney.keymap').nnoremap

        nnoremap('K', vim.lsp.buf.hover, { buffer = bufnr })
        nnoremap('<C-e>', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', { buffer = bufnr })
        nnoremap('gp', '<Cmd>Lspsaga peek_definition<CR>', { buffer = bufnr })
        nnoremap('gt', vim.lsp.buf.type_definition, { buffer = bufnr })
        nnoremap('gr', '<Cmd>Lspsaga lsp_finder<CR>', { buffer = bufnr })
        nnoremap('<leader>rr', '<Cmd>Lspsaga rename<CR>', { buffer = bufnr })
        nnoremap('<leader>ca', '<Cmd>Lspsaga code_action<CR>', { buffer = bufnr })
        nnoremap('<leader>e', '<Cmd>Lspsaga diagnostic_jump_next<CR>', { buffer = bufnr })
        nnoremap('<leader>E', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', { buffer = bufnr })


        vim.api.nvim_create_autocmd({ 'BufWritePre', 'InsertLeave' }, {
          callback = function()
            vim.cmd('LspZeroFormat')
          end,
          buffer = bufnr,
        })
      end)

      -- (Optional) Configure lua language server for neovim
      lsp.nvim_workspace() -- lsp.nvim_workspace()

      lsp.setup()
      require('lspsaga').setup {}

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
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('nvim-tree').setup()
      require('prmaloney.keymap').nnoremap('<leader>a', '<Cmd>NvimTreeFindFileToggle<CR>')
    end
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
        direction = "vertical",
        size = 60,
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
    config = function() require('nvim-autopairs').setup() end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function() require('nvim-ts-autotag').setup() end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('indent_blankline').setup {
        show_current_context = true
      }
    end
  }
}
