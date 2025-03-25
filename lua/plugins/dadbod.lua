return {
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  "hrsh7th/nvim-cmp",
  "kristijanhusak/vim-dadbod-ui",
  config = function()
    require("cmp")
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dbout',
      callback = function()
        require("cmp").setup.buffer({
          sources = {
            { name = 'vim-dadbod-completion' },
            { name = 'buffer' },
          }
        })
        vim.keymap.set('n', 'gd', '<plug>(DBUI_JumpToForeignKey)')
      end
    })
  end
}
