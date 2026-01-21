return {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local ui = require('harpoon.ui')
        local mark = require('harpoon.mark')

        vim.keymap.set('n', '<leader>ha', ui.toggle_quick_menu)
        vim.keymap.set('n', '<C-m>', mark.add_file)
    end
}
