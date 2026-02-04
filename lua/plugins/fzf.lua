return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "elanmed/fzf-lua-frecency.nvim" },
    config = function(_, opts)
        local fzf = require('fzf-lua')
        local fzf_frecency = require('fzf-lua-frecency')
        fzf.setup(opts)
        fzf.register_ui_select()
        fzf_frecency.setup()
        vim.keymap.set('n', '<leader>ss', fzf.global)
        vim.keymap.set('n', '<leader>sf', function() fzf_frecency.frecency({ cwd_only = true }) end)
        vim.keymap.set('n', '<leader>sg', fzf.live_grep)
        vim.keymap.set('n', '<leader><space>', fzf.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set('n', '<leader>gb', fzf.git_branches, { desc = '[G]it [B]ranches' })
        vim.keymap.set('n', '<leader>sl', fzf.helptags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]resume' })
    end,
}
