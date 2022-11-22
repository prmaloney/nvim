local nnoremap = require('prmaloney.keymap').nnoremap
local inoremap = require('prmaloney.keymap').inoremap
local vnoremap = require('prmaloney.keymap').vnoremap
-- file explorer and terminal
nnoremap("<leader>a", "<cmd>Ex<CR>")

--split creation and navigation
nnoremap('<leader>sv', '<C-w>v')
nnoremap('<leader>sh', '<C-w>s')
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

--keep vertical jumps centered
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-d>', '<C-d>zz')

-- move lines up/down
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

inoremap("jj", "<Esc>")

vnoremap("<C-/>", ":norm i//<CR>")
