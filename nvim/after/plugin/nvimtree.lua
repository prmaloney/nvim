require('nvim-tree').setup {}
local nnoremap = require('prmaloney.keymap').nnoremap

nnoremap('<leader>a', function() require('nvim-tree').toggle() end)
