return {
    'tpope/vim-fugitive',
    config = function()
        -- git status
        vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>')

        -- hunk picking
        vim.keymap.set('n', 'gf', '<cmd>diffget //2<cr>')
        vim.keymap.set('n', 'gh', '<cmd>diffget //3<cr>')

        vim.keymap.set('n', '[x', '?<<<<cr>')
        vim.keymap.set('n', ']x', '/<<<<<cr>')
    end
}
