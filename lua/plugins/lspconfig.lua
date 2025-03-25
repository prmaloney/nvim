return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        -- Diagnostic keymaps
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

        local cmp = require('cmp')
        cmp.setup({
            mapping = {
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<Up>'] = cmp.mapping.select_prev_item(),
                ['<Down>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
            }, {
                { name = 'buffer' },
            })
        })

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

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
        end

        local servers = {
            svelte = {
                filetypes = { 'svelte', 'svx' }
            },
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
            ts_ls = {
                filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
            },
        }

        -- Setup neovim lua configuration
        require('neodev').setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                -- print('setting up ' .. server_name .. ' capabilities ' .. vim.inspect(capabilities))
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end
        }
        local lspconfig = require('lspconfig')
        -- require('java').setup({
        --     jdk = {
        --         auto_install = true,
        --         version = '21.0.4-tem',
        --     }
        -- })
        lspconfig.jdtls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                java = {
                    home = vim.fn.expand('~/.sdkman/candidates/java/21.0.4-tem'),
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-21",
                                path = vim.fn.expand('~/.sdkman/candidates/java/21.0.4-tem'),
                                default = true,
                            }
                        }
                    }
                }
            }
        })
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }
        lspconfig.ts_ls.setup {
            capabilities = capabilities,
            init_options = {
                preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                    importModuleSpecifierPreference = 'non-relative'
                },
            },
            on_attach = on_attach,
            filetypes = { 'js', 'ts', 'jsx', 'tsx', 'mjs', 'cjs' },
        }
        lspconfig.sourcekit.setup {
            cmd = { '/usr/bin/sourcekit-lsp' }
        }
        lspconfig.gopls.setup {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.keymap.set('n', '<leader>ee', function()
                    -- insert if err != nil {\nreturn err\n} below my cursor
                    vim.api.nvim_put({ 'if err != nil {', '\treturn err', '}' }, 'l', false, true)
                end)
            end
        }
        lspconfig.svelte.setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig.angularls.setup {
            root_dir = require('lspconfig.util').root_pattern("angular.json", "package.json", "tsconfig.json", "jsconfig.json"),
            on_attach = on_attach,
            capabilities = capabilities,
        }
        vim.filetype.add({
            pattern = {
                [".*%.component%.html"] = "htmlangular", -- Sets the filetype to `htmlangular` if it matches the pattern
            },
        })
    end
}
