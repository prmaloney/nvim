return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    suggestion = { auto_trigger = true },
                })
            end,
        },
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'enter',
            ['<Tab>'] = {
                'snippet_forward',
                function()
                    local copilot_suggestion = require("copilot.suggestion")
                    if copilot_suggestion.is_visible() then
                        copilot_suggestion.accept()
                        return true
                    end
                end,
                'fallback'
            },
            ['<S-Tab>'] = {
                'snippet_backward',
                function()
                    local copilot_suggestion = require("copilot.suggestion")
                    if copilot_suggestion.is_visible() then
                        copilot_suggestion.next()
                        return true
                    end
                end,
                'fallback'
            }
        },

        appearance = {
            nerd_font_variant = 'normal'
        },

        completion = { documentation = { auto_show = true } },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                sql = { 'snippets', 'dadbod', 'buffer' },
            },
            providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
