return {
    'tpope/vim-fugitive',
    'tpope/vim-surround',
    {
        'stevearc/oil.nvim',
        opts = {
            default_file_explorer = true,
            view_options = {
                show_hidden = true
            }
        }
    },
    { 'numToStr/Comment.nvim', opts = {} },
}
