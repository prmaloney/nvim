return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('prmaloney.keymaps').lsp_keymaps()
        require('flutter-tools').setup({})
    end
}
