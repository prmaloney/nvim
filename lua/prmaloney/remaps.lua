local nnoremap = require('prmaloney.keymap').nnoremap
local inoremap = require('prmaloney.keymap').inoremap
local vnoremap = require('prmaloney.keymap').vnoremap
local tnoremap = require('prmaloney.keymap').tnoremap
-- file explorer and terminal
nnoremap("<leader>a", "<cmd>Ex<CR>")

--split creation and navigation
nnoremap('<leader>v', '<C-w>v')
nnoremap('<leader>s', '<C-w>s')
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")
nnoremap("<leader>K", "<C-w>H")
nnoremap("<leader>J", "<C-w>J")

--keep vertical jumps centered
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-d>', '<C-d>zz')

--esc to go to normal mode in terminal
tnoremap('<esc>', '<C-\\><C-n>')

-- move lines up/down
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

inoremap("jj", "<Esc>")

vnoremap("<C-/>", ":norm i//<CR>")
