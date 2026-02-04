return {
    -- some lsp helper plugins
    {
        'j-hui/fidget.nvim',
        opts = {
            notification = {
                window = {
                    border = "rounded",
                    winblend = 0
                }
            }
        }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    'hrsh7th/cmp-nvim-lsp',
}
