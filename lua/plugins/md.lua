return {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
        file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
    config = function()
        -- if current dir == 'todays'
        -- print(vim.fn.expand('%'):find('todays'))
        local function trim(s)
            return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
        end

        if (vim.fn.expand('%'):find('todays')) then
            vim.keymap.set('n', '<leader>x', function()
                local line = trim(vim.api.nvim_get_current_line())
                if line:sub(1, 1) ~= "[" then
                    return
                end
                print(line)
                print(line:sub(2, 1))
                if (line:sub(2, 1) == " ") then
                    print("not done, put an x")
                    vim.cmd.normal('_f rx')
                else
                    print("the other thing")
                    vim.cmd.normal('_fxr ')
                end
            end)
        end
    end
}
