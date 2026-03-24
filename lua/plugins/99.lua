return {
    "ThePrimeagen/99",
    config = function()
        local _99 = require("99")

        local cwd = vim.uv.cwd()
        local basename = vim.fs.basename(cwd)


        _99.setup({
            logger = {
                level = _99.DEBUG,
                path = "/tmp/" .. basename .. ".99.debug",
                print_on_error = true,
            },

            provider = require('99.providers').ClaudeCodeProvider,
            model = "claude-haiku-4-5",

            completion = {
                custom_rules = {
                    "scratch/custom_rules/",
                },

                source = "cmp",
            },

            md_files = {
                "AGENT.md",
            },
        })

        vim.keymap.set("n", "<leader>off", function()
            _99.fill_in_function()
        end)
        vim.keymap.set("n", "<leader>ofp", function()
            _99.fill_in_function_prompt()
        end)
        vim.keymap.set("n", "<leader>ofd", function()
            _99.fill_in_function({
                additional_rules = {
                    _99:rule_from_path("~/.behaviors/debug.md"),
                },
            })
        end)
        vim.keymap.set("n", "<leader>os", function()
            _99.search()
        end)
        vim.keymap.set("v", "<leader>ov", function()
            _99.visual()
        end)
        vim.keymap.set("v", "<leader>op", function()
            _99.visual_prompt()
        end)
    end,
}
