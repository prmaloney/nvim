local nnoremap = require('noodledog.keymap').nnoremap
local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')
local harpoon_term = require('harpoon.term')
local harpoon = require('harpoon')

harpoon.setup({ enter_on_sendcmd = true })

local silent = { silent = true }

nnoremap('<C-m>', function() harpoon_mark.add_file() end, silent)
nnoremap('<C-h>', function() harpoon_ui.toggle_quick_menu() end, silent)
nnoremap('<C-1>', function() harpoon_term.gotoTerminal(1) end, silent)
nnoremap('<C-2>', function() harpoon_term.gotoTerminal(2) end, silent)
nnoremap('<C-j>', function() harpoon_ui.nav_file(1) end, silent)
nnoremap('<C-k>', function() harpoon_ui.nav_file(2) end, silent)
nnoremap('<C-l>', function() harpoon_ui.nav_file(3) end, silent)
nnoremap('<C-;>', function() harpoon_ui.nav_file(4) end, silent)
