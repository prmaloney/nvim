local function codeiumStatus()
    return "󰘦 :" .. vim.fn['codeium#GetStatusString']()
end

return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
        options = {
            component_separators = '|',
            section_separators = '',
        },
        sections = {
            lualine_c = {
                { 'filename', path = 1 },
                {
                    codeiumStatus,
                    color = function()
                        return 'lualine_b_insert'
                    end
                },
            }
        }
    },
}
