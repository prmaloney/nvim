local M = {}
M.search_config = function(opts)
  vim.cmd('silent cd ~/.config/nvim')
  require('telescope.builtin').find_files(opts)
end

vim.api.nvim_create_user_command('Config',
  M.search_config
  , {})

vim.api.nvim_create_user_command('Reload',
  function()
    for name, _ in pairs(package.loaded) do
      package.loaded[name] = nil
    end

    dofile(vim.env.MYVIMRC)
  end
  , {})

return M
