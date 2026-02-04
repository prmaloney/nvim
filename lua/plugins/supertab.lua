return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "zbirenbaum/copilot.lua",
            dependencies = {
                "copilotlsp-nvim/copilot-lsp",
                config = function()
                    vim.g.copilot_nes_debounce = 500
                end,
            },
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    suggestion = { auto_trigger = true },
                    nes = {
                        enabled = true,
                        keymap = {
                            accept_and_goto = "<leader>p",
                            accept = false,
                            dismiss = "<Esc>",
                        },
                    }
                })
            end,
        },
    },
    event = "InsertEnter",
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            mapping = {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local copilot = require("copilot.suggestion")
                    if copilot.is_visible() then
                        copilot.accept()
                    elseif cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        end
                        cmp.confirm()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    local copilot = require("copilot.suggestion")
                    if copilot.is_visible() then
                        copilot.next()
                    elseif cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            },
            view = {
                entries = { name = "custom" },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "lazydev",              group_index = 0 },
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            }),
        })
    end,
}
