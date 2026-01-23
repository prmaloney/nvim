local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp-nvim-lsp')
local capabilities = {}
if has_cmp_lsp then
    capabililties = cmp_lsp.default_capabilities()
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
        filetypes = { 'htmlangular', 'typescript' },
    },
    eslint = {
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'htmlangular' }
    },
}

-- iterate over servers and setup with vim.lsp.config
for server_name, settings in pairs(servers) do
    vim.lsp.config(server_name, {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = settings,
        filetypes = settings.filetypes,
    })
    vim.lsp.enable(server_name)
end

vim.filetype.add({
    pattern = {
        [".*%.component%.html"] = "htmlangular", -- Sets the filetype to `htmlangular` if it matches the pattern
    },
})
