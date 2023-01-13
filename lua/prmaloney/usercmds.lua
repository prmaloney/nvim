vim.api.nvim_create_user_command('Config',
  function()
    require('telescope.builtin').find_files({ search_dirs = { '~/.config/nvim' } })
  end
  , {})

vim.api.nvim_create_user_command('Reload',
  function()
    for name, _ in pairs(package.loaded) do
      package.loaded[name] = nil
    end

    dofile(vim.env.MYVIMRC)
  end
  , {})
