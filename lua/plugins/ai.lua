return {
    -- {
    --     'Exafunction/codeium.vim',
    --     config = function()
    --         vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    --         vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    --             { expr = true, silent = true })
    --         vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    --     end
    -- },
    -- {
    --  'github/copilot.vim'
    -- }
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({})
        end,
    },
}
