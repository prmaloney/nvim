return {
    'nvimtools/none-ls.nvim',
    config = function()
        require('null-ls').setup({
            sources = {
                require('null-ls').builtins.diagnostics.eslint,
                require('null-ls').builtins.code_actions.eslint,
                require('null-ls').builtins.formatting.prettier,
                require('null-ls').builtins.formatting.stylua,
                require('null-ls').builtins.diagnostics.luacheck
            }
        })
    end
}
