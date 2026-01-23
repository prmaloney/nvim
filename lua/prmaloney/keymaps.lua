-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- window stuff
vim.keymap.set('n', '<leader>sv', '<C-w>v')
vim.keymap.set('n', '<leader>sh', '<C-w>s')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>gs', '<cmd>G<cr>')

vim.keymap.set('n', '∆', '<C-w>j')
vim.keymap.set('n', '˚', '<C-w>k')
vim.keymap.set('n', '˙', '<C-w>h')
vim.keymap.set('n', '¬', '<C-w>l')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quickfix remaps
vim.keymap.set('n', '<c-n>', '<cmd>:cnext<CR>zz', { desc = 'Quickfix next' })
vim.keymap.set('n', '<c-p>', '<cmd>:cprev<CR>zz', { desc = "Quickfix prev" })
vim.keymap.set('n', '<c-q>', '<cmd>:cclose<CR>zz', { desc = "Quickfix close" })

-- move lines
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

-- don't kill buf with paste or delete
vim.keymap.set('x', '<leader>p', '\"_dP')
vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')

local M = {}

M.lsp_keymaps = function()
    local fzf = require('fzf-lua')
    local actions = require('fzf-lua.actions')
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1, float = { border = 'rounded' } } end,
        { desc = 'Next Diagnostic' })
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1, float = { border = 'rounded' } } end,
        { desc = 'Prev Diagnostic' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Set Location List' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

    vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gD', function()
        fzf.lsp_definitions({
            actions = { ['default'] = actions.file_vsplit },
            jump_to_single_result = true,
        })
    end, { desc = '[G]oto [D]efinition split' })
    vim.keymap.set('n', 'gt', fzf.lsp_typedefs, { desc = '[G]oto [T]ype definition' })
    vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', fzf.lsp_implementations, { desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>ds', fzf.lsp_document_symbols,
        { desc = '[D]ocument [S]ymbols' })
    vim.keymap.set('n', '<leader>ws', fzf.lsp_workspace_symbols,
        { desc = '[W]orkspace [S]ymbols' })

    -- See `:help K` for why this keymap
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover { border = 'rounded' } end, { desc = 'Hover Documentation' })
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })
end

return M
