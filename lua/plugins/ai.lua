return {
    -- {
    --     "supermaven-inc/supermaven-nvim",
    --     config = function()
    --         require("supermaven-nvim").setup({})
    --     end,
    -- },
    -- {
    --     "github/copilot.vim",
    -- },
    -- {
    --     "azorng/goose.nvim",
    --     config = function()
    --         require("goose").setup({})
    --     end,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         {
    --             "MeanderingProgrammer/render-markdown.nvim",
    --             opts = {
    --                 anti_conceal = { enabled = false },
    --             },
    --         }
    --     },
    -- },
    { "zbirenbaum/copilot-cmp", opts = {} },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        dependencies = {
            "zbirenbaum/copilot-cmp"
        },
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },
    {
        "yetone/avante.nvim",
        build = function()
            if vim.fn.has("win32") == 1 then
                return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            else
                return "make"
            end
        end,
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- provider = "gemini",
            provider = "copilot",
            -- providers = {
            --     claude = {
            --         endpoint = "https://api.anthropic.com",
            --         model = "claude-sonnet-4-20250514",
            --         timeout = 30000, -- Timeout in milliseconds
            --         extra_request_body = {
            --             temperature = 0.75,
            --             max_tokens = 20480,
            --         },
            --     },
            -- },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua",
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        use_absolute_path = true,
                    },
                },
            },
        },
    }
}
