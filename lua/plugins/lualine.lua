local function codeiumStatus()
    return "󰘦 :" .. vim.fn['codeium#GetStatusString']()
end

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            component_separators = '|',
            section_separators = '',
        },
        sections = {
            lualine_c = {
                { 'filename', path = 4 },
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
