local nnoremap = require('noodledog.keymap').nnoremap
local inoremap = require('noodledog.keymap').inoremap
local tnoremap = require('noodledog.keymap').tnoremap
local vnoremap = require('noodledog.keymap').vnoremap
-- file explorer and terminal
nnoremap("<leader>a", "<cmd>Ex<CR>")

--split creation and navigation
nnoremap('<leader>sv', '<C-w>v')
nnoremap('<leader>sh', '<C-w>s') 
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

tnoremap("<Esc>", "<C-\\><C-n>")
inoremap("jj", "<Esc>")

vnoremap("<C-/>", ":norm i//<CR>")
