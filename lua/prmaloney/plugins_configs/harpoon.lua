local nnoremap = require('prmaloney.keymap').nnoremap
local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')
local harpoon_term = require('harpoon.term')
local harpoon = require('harpoon')

harpoon.setup({ enter_on_sendcmd = true, mark_branch = true })

local silent = { silent = true }

nnoremap('<C-m>', function() harpoon_mark.add_file() end, silent)
nnoremap('<leader>hp', function() harpoon_ui.toggle_quick_menu() end, silent)
nnoremap('<leader>u', function() harpoon_term.gotoTerminal(1) end, silent)
nnoremap('<leader>i', function() harpoon_term.gotoTerminal(2) end, silent)
nnoremap('<leader>j', function() harpoon_ui.nav_file(1) end, silent)
nnoremap('<leader>k', function() harpoon_ui.nav_file(2) end, silent)
nnoremap('<leader>l', function() harpoon_ui.nav_file(3) end, silent)
nnoremap('<leader>;', function() harpoon_ui.nav_file(4) end, silent)

vim.api.nvim_create_user_command('HarpoonClear', function() harpoon_mark.clear_all() end, {})
