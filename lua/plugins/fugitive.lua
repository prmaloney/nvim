return {
    'tpope/vim-fugitive',
    config = function()
        -- git status
        vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>')
        vim.keymap.set('n', 'cz', '<cmd>vsplit term://cz | startinsert<cr>')
    end
}
