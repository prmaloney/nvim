local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp-nvim-lsp')
local capabilities = {}
if has_cmp_lsp then
    capabilities = cmp_lsp.default_capabilities()
end

local function toggle_inlay_hints()
    if vim.lsp.inlay_hint.is_enabled() then
        vim.lsp.inlay_hint.enable(false)
    else
        vim.lsp.inlay_hint.enable()
    end
end
vim.api.nvim_create_user_command('InlayToggle', toggle_inlay_hints, {})
vim.keymap.set('n', '<leader>i', toggle_inlay_hints, { desc = 'Toggle inlay hints' })

local on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end

    vim.diagnostic.config({ virtual_text = true })
    require('prmaloney.keymaps').lsp_keymaps()
end

local servers = {
    lua_ls = {
        cmd = { "lua-language-server" },
        Lua = {
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
        filetypes = { "lua" }
    },
    ts_ls = {
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        cmd = { "typescript-language-server", "--stdio" },
        root_markers = { 'package.json', '.git' },
    },
    tailwindcss = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts',
            'package.json', '.git' },
        filetypes = { 'html', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'css', 'scss',
            'sass', 'htmlangular', 'less', 'svelte', 'vue', 'astro' },
    },
    angularls = {
        filetypes = { 'htmlangular', 'typescript' },
        cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            ".",
            "./node_modules",
            "--ngProbeLocations",
            ".",
            "./node_modules",
        },
        root_dir = function(fname)
            return vim.fs.root(fname, { 'angular.json', 'project.json', 'nx.json', 'package.json', '.git' })
        end,
        get_language_id = function(_bufnr, filetype)
            if filetype == 'htmlangular' then
                return 'html'
            end
            return filetype
        end,
        settings = {},
    },
    eslint = {
        cmd = { "vscode-eslint-language-server", "--stdio" },
        root_markers = {
            'eslint.config.js',
            '.eslintrc',
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            'package.json',
            '.git',
        },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
        settings = {
            validate = 'on',
            packageManager = nil,
            useESLintClass = false,
            experimental = {
                useFlatConfig = false,
            },
            codeActionOnSave = {
                enable = false,
                mode = 'all',
            },
            format = true,
            quiet = false,
            onIgnoredFiles = 'off',
            rulesCustomizations = {},
            run = 'onType',
            problems = {
                shortenToSingleLine = false,
            },
            -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
            -- This path is relative to the workspace folder (root dir) of the server instance.
            nodePath = '',
            -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
            workingDirectory = { mode = 'auto' },
            codeAction = {
                disableRuleComment = {
                    enable = true,
                    location = 'separateLine',
                },
                showDocumentation = {
                    enable = true,
                },
            },
        },
    },
}

-- iterate over servers and setup with vim.lsp.config
for server_name, settings in pairs(servers) do
    local lsp_settings = settings.settings or settings
    if lsp_settings == settings and (settings.filetypes or settings.root_dir or settings.cmd) then
        lsp_settings = vim.tbl_deep_extend('force', {}, settings)
        lsp_settings.filetypes = nil
        lsp_settings.root_dir = nil
        lsp_settings.cmd = nil
    end
    vim.lsp.config(server_name, {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = lsp_settings,
        filetypes = settings.filetypes,
        root_dir = settings.root_dir,
        cmd = settings.cmd,
    })
    vim.lsp.enable(server_name)
end

vim.filetype.add({
    pattern = {
        [".*%.component%.html"] = "htmlangular", -- Sets the filetype to `htmlangular` if it matches the pattern
    },
})
