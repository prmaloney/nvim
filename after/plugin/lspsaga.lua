require('lspsaga').setup {
  ui = {
    border = 'single',
    colors = {
      normal_bg = '#000000',
      title_bg = '#777777'
    }
  }
}
local nnoremap = require('prmaloney.keymap').nnoremap

nnoremap('K', '<Cmd>Lspsaga hover_doc<CR>')
nnoremap('<C-e>', '<Cmd>Lspsaga show_cursor_diagnostics<CR>')
nnoremap('gp', '<Cmd>Lspsaga peek_definition<CR>')
nnoremap('gd', '<Cmd>Lspsaga goto_definition<CR>')
nnoremap('gt', vim.lsp.buf.type_definition)
nnoremap('gr', '<Cmd>Lspsaga lsp_finder<CR>')
nnoremap('<leader>rr', '<Cmd>Lspsaga rename<CR>')
nnoremap('<leader>ca', '<Cmd>Lspsaga code_action<CR>')
nnoremap('<leader>e', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
nnoremap('<leader>E', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
