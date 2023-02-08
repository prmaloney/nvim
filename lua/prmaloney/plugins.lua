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
  'folke/tokyonight.nvim',
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

        nnoremap('K', '<Cmd>Lspsaga hover_doc<CR>', { buffer = bufnr })
        nnoremap('<C-e>', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', { buffer = bufnr })
        nnoremap('gp', '<Cmd>Lspsaga peek_definition<CR>', { buffer = bufnr })
        nnoremap('gt', vim.lsp.buf.type_definition, { buffer = bufnr })
        nnoremap('gr', '<Cmd>Lspsaga lsp_finder<CR>', { buffer = bufnr })
        nnoremap('<leader>rr', '<Cmd>Lspsaga rename<CR>', { buffer = bufnr })
        nnoremap('<leader>ca', '<Cmd>Lspsaga code_action<CR>', { buffer = bufnr })
        nnoremap('<leader>e', '<Cmd>Lspsaga diagnostic_jump_next<CR>', { buffer = bufnr })
        nnoremap('<leader>E', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', { buffer = bufnr })
      end)

      -- (Optional) Configure lua language server for neovim
      lsp.nvim_workspace() -- lsp.nvim_workspace()

      lsp.setup()
      require('lspsaga').setup {}

      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
          vim.cmd('LspZeroFormat')
        end
      })
    end
  },
  'nvim-treesitter/nvim-treesitter',
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('nvim-tree').setup()
      require('prmaloney.keymap').nnoremap('<leader>a', '<Cmd>NvimTreeFindFileToggle<CR>')
    end
  }
}
