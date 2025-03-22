return {
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  "kristijanhusak/vim-dadbod-ui",
  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "snippets", "buffer", "dadbod" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dbout',
        callback = function()
          vim.keymap.set('n', 'gd', '<plug>(DBUI_JumpToForeignKey)')
        end
      })
    end
  }
}
