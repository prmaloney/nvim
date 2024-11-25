return {
    'tpope/vim-surround',
    'tpope/vim-abolish',
    {
        'pixelastic/vim-undodir-tree',
        config = function()
            vim.cmd('set undofile')
        end
    },
    { 'numToStr/Comment.nvim', opts = {} },
}
