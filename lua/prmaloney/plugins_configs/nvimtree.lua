require('nvim-tree').setup {}
local nnoremap = require('prmaloney.keymap').nnoremap

nnoremap('<leader>a', '<Cmd>NvimTreeFindFileToggle<CR>')
