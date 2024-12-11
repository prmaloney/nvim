---@diagnostic disable: missing-fields
return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',

    },
    config = function()
        local cmp = require 'cmp'

        cmp.setup {
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
            },
            sources = {
                { name = 'nvim_lsp' },
            },
        }
        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })
    end
}
