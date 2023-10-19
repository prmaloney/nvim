return {
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            require('tokyonight').setup({
                style = "storm",
                transparent = true
            })
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require('catppuccin').setup({ transparent_background = true })
        end
    },
    {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                disable_background = true
            })
            vim.cmd('colorscheme rose-pine')
        end
    },
}
