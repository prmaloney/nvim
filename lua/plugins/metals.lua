return {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { {
                "mfussenegger/nvim-dap",
                config = function()
                    -- Debug settings if you're using nvim-dap
                    local dap = require("dap")
                    local dap_ui = require("dapui")
                    dap_ui.setup()

                    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = '', numhl = '' })

                    vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>")
                    vim.keymap.set("n", "<leader>dr", "<cmd>DapToggleRepl<cr>")
                    vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")

                    vim.keymap.set("n", "<leader>du", dap_ui.open)

                    dap.configurations.scala = {
                        {
                            type = "scala",
                            request = "launch",
                            name = "Run",
                            metals = {
                                runType = "run",
                            },
                        },
                        {
                            type = "scala",
                            request = "launch",
                            name = "RunOrTest",
                            metals = {
                                runType = "runOrTestFile",
                                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                            },
                        },
                        {
                            type = "scala",
                            request = "launch",
                            name = "Test Target",
                            metals = {
                                runType = "testTarget",
                            },
                        },
                    }
                end
            }, "nvim-neotest/nvim-nio" }
        }
        ,
    },
    ft = { "scala", "sbt", "mill" },
    opts = function()
        local metals_config = require("metals").bare_config()
        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
        metals_config.init_options.statusBarProvider = "off"
        metals_config.on_attach = function(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end

            require('prmaloney.keymaps').lsp_keymaps()

            require("metals").setup_dap()
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
