return {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
        require('git-conflict').setup()

        vim.api.nvim_create_user_command('Conflicts', function()
            vim.cmd('GitConflictListQf')
        end, {})

        vim.api.nvim_create_autocmd('User', {
            pattern = 'GitConflictResolved',
            callback = function()
                local remaining = require('git-conflict').conflict_count()
                if remaining == 0 then
                    vim.notify('All conflicts resolved', vim.log.levels.INFO)
                end
            end
        })
    end,
}
