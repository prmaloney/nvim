return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',

    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim',       tag = 'legacy', opts = { window = { border = "rounded" } } },

        -- Additional lua configuration, makes nvim stuff amazing!
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        'zbirenbaum/copilot.lua',
        'hrsh7th/cmp-nvim-lsp',
    },
    opts = {
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local function toggle_inlay_hints()
            if vim.lsp.inlay_hint.is_enabled() then
                vim.lsp.inlay_hint.enable(false)
            else
                vim.lsp.inlay_hint.enable()
            end
        end

        vim.api.nvim_create_user_command('InlayToggle', toggle_inlay_hints, {})
        vim.keymap.set('n', '<leader>i', toggle_inlay_hints, { desc = 'Toggle inlay hints' })
        --
        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(client, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end

            vim.diagnostic.config({ virtual_text = true })
            require('prmaloney.keymaps').lsp_keymaps()
        end

        local servers = {
            lua_ls = {
                Lua = {
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    telemetry = { enable = false },
                },
            },
            ts_ls = {
                filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
            },
            tailwindcss = {
                filetypes = { 'html', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'css', 'scss',
                    'sass', 'htmlangular', 'less', 'svelte', 'vue', 'astro' },
            },
            angularls = {
                -- root_dir = require('lspconfig.util').root_pattern("angular.json", "package.json", "tsconfig.json",
                --     "jsconfig.json"),
                filetypes = { 'htmlangular', 'typescript' },
            },
            eslint = {
                filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'htmlangular' }
            },
        }

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        -- Ensure the servers above are installed
        local mason_lspconfig = require('mason-lspconfig')

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_enable = true
        }

        -- mason_lspconfig.setup_handlers {
        --     function(server_name)
        --         -- print('setting up ' .. server_name .. ' capabilities ' .. vim.inspect(capabilities))
        --         require('lspconfig')[server_name].setup {
        --             capabilities = capabilities,
        --             on_attach = on_attach,
        --             settings = servers[server_name],
        --             filetypes = (servers[server_name] or {}).filetypes,
        --         }
        --     end
        -- }
        -- local lspconfig = require('lspconfig')
        -- require('java').setup({
        --     jdk = {
        --         auto_install = true,
        --         version = '21.0.4-tem',
        --     }
        -- })
        -- lspconfig.jdtls.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     settings = {
        --         java = {
        --             home = vim.fn.expand('~/.sdkman/candidates/java/21.0.4-tem'),
        --             configuration = {
        --                 runtimes = {
        --                     {
        --                         name = "JavaSE-21",
        --                         path = vim.fn.expand('~/.sdkman/candidates/java/21.0.4-tem'),
        --                         default = true,
        --                     }
        --                 }
        --             }
        --         }
        --     }
        -- })
        -- lspconfig.lua_ls.setup {
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = {
        --         Lua = {
        --             workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        --             diagnostics = { globals = { "vim" } },
        --             telemetry = { enable = false },
        --         },
        --     },
        -- }
        -- iterate over servers and setup with vim.lsp.config
        for server_name, settings in pairs(servers) do
            vim.lsp.config(server_name, {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = settings,
                filetypes = settings.filetypes,
            })
        end
        -- vim.lsp.config("lua_ls", {
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = servers.lua_ls,
        -- })
        -- vim.lsp.config("ts_ls", {
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = servers.ts_ls,
        -- })
        -- lspconfig.ts_ls.setup {
        --     capabilities = capabilities,
        --     init_options = {
        --         preferences = {
        --             includeInlayParameterNameHints = "all",
        --             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --             includeInlayFunctionParameterTypeHints = true,
        --             includeInlayVariableTypeHints = true,
        --             includeInlayPropertyDeclarationTypeHints = true,
        --             includeInlayFunctionLikeReturnTypeHints = true,
        --             includeInlayEnumMemberValueHints = true,
        --             importModuleSpecifierPreference = 'non-relative'
        --         },
        --     },
        --     on_attach = on_attach,
        --     filetypes = { 'js', 'ts', 'jsx', 'tsx', 'mjs', 'cjs' },
        -- }
        -- lspconfig.sourcekit.setup {
        --     cmd = { '/usr/bin/sourcekit-lsp' }
        -- }
        -- lspconfig.gopls.setup {
        --     capabilities = capabilities,
        --     on_attach = function(client, bufnr)
        --         on_attach(client, bufnr)
        --         vim.keymap.set('n', '<leader>ee', function()
        --             -- insert if err != nil {\nreturn err\n} below my cursor
        --             vim.api.nvim_put({ 'if err != nil {', '\treturn err', '}' }, 'l', false, true)
        --         end)
        --     end
        -- }
        -- lspconfig.svelte.setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach
        -- })
        --
        -- lspconfig.angularls.setup {
        --     root_dir = require('lspconfig.util').root_pattern("angular.json", "package.json", "tsconfig.json", "jsconfig.json"),
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     filetypes = { 'htmlangular', 'typescript' },
        -- }
        vim.lsp.config("*", {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.filetype.add({
            pattern = {
                [".*%.component%.html"] = "htmlangular", -- Sets the filetype to `htmlangular` if it matches the pattern
            },
        })
    end
}
