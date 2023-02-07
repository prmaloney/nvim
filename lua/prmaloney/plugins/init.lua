return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  'nvim-lualine/lualine.nvim',
  'lewis6991/gitsigns.nvim',
  'onsails/lspkind-nvim',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  { 'glepnir/lspsaga.nvim', dependencies = { { "nvim-tree/nvim-web-devicons" } } },
  'mfussenegger/nvim-dap',
  'Pocco81/DAPInstall.nvim',
  'kylechui/nvim-surround',
  'dinhhuy258/git.nvim',
  'akinsho/toggleterm.nvim',
  'lukas-reineke/indent-blankline.nvim',
  'nvim-treesitter/nvim-treesitter',
  'windwp/nvim-ts-autotag',
  'windwp/nvim-autopairs',
  'ThePrimeagen/git-worktree.nvim',
  'ggandor/leap.nvim',
  'numToStr/Comment.nvim',
  {
    'jinh0/eyeliner.nvim',
    config = function()
      require 'eyeliner'.setup {
        highlight_on_key = true
      }
    end
  },
  'ellisonleao/glow.nvim',
}
