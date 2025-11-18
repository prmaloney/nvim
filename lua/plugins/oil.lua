return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup({
            default_file_explorer = true,
            lsp_file_methods = {
                enabled = true,
            },
            view_options = {
                show_hidden = true
            },
            keymaps = {
                ['yp'] = {
                    desc = 'Copy filepath to system clipboard',
                    callback = function()
                        require('oil.actions').copy_entry_path.callback()
                        vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                    end,
                },
            },
        })
        vim.keymap.set('n', '<leader>pv', '<cmd>Oil<cr>')
    end
}
