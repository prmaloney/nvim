return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup({
            default_file_explorer = true,
            view_options = {
                show_hidden = true
            }
        })
        vim.keymap.set('n', '<leader>pv', '<cmd>Oil<cr>')
    end
}
