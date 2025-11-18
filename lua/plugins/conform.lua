local prettier_default = { "prettierd", "prettier", stop_after_first = true }

return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            default_format_opts = {
                lsp_format = "fallback",
            },
            formatters = {
                scallop = {
                    command = "idea",
                    args = { "format", "-allowDefaults" },
                },
            },
            formatters_by_ft = {
                rust = { "rustfmt", lsp_format = "fallback" },
                java = { "google-java-format" },
                go = { "gofmt" },
                sclala = { "scalafmt" },
                javascript = prettier_default,
                typescript = prettier_default,
                html = prettier_default,
                css = prettier_default,
                scss = prettier_default,
                json = prettier_default,
                yaml = prettier_default,
                htmlangular = prettier_default,
            },
            -- format_on_save = {
            --     lsp_format = "fallback",
            --     timeout_ms = 500,
            -- }
            format_on_save = function(bufnr)
                local ignore_filetypes = { "scala" }
                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end
                return {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                }
            end,
        })

        vim.keymap.set({ 'v', 'n' }, '=', function()
            conform.format({ lsp_format = "fallback" })
        end)
    end
}
