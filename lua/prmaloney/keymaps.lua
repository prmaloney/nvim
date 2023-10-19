-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- I do this
vim.keymap.set('i', 'jj', '<Esc>')

-- window stuff
vim.keymap.set('n', '<leader>v', '<C-w>v')
vim.keymap.set('n', '<leader>s', '<C-w>s')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quickfix remaps
vim.keymap.set('n', '<leader>cn', '<cmd>:cnext<CR>zz', { desc = 'Quickfix next' })
vim.keymap.set('n', '<leader>cp', '<cmd>:cprev<CR>zz', { desc = "Quickfix prev" })
vim.keymap.set('n', '<leader>cq', '<cmd>:cclose<CR>zz', { desc = "Quickfix close" })

-- move lines
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

-- don't kill buf with paste or delete
vim.keymap.set('x', '<leader>p', '\"_dP')
vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')
