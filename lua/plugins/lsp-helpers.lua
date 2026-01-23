return {
    -- some lsp helper plugins
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = { window = { border = "rounded" } } },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    'zbirenbaum/copilot.lua',
    'hrsh7th/cmp-nvim-lsp',
}
