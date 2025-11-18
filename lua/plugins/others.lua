return {
    'tpope/vim-surround',
    { 'marcussimonsen/let-it-snow.nvim', opts = {}, cmd = 'LetItSnow' },
    'tpope/vim-abolish',
    {
        'pixelastic/vim-undodir-tree',
        config = function()
            vim.cmd('set undofile')
        end
    },
    { 'numToStr/Comment.nvim',           opts = {} },
    { 'yorickpeterse/nvim-pqf',          opts = {} },
}
