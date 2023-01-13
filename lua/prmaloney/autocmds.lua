function Start_server_if_project()
  if require('prmaloney.utils').fileExists("package.json") then
    require('harpoon.term').sendCommand(1, 'yarn dev')
    -- start alpha screen if no argc given
    if vim.fn.argc() == 0 then
      require('alpha').start(false)
    end
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    Start_server_if_project()
  end
})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  callback = function()
    if vim.fn.exists(':EslintFixAll') > 0 then vim.cmd [[EslintFixAll]] end
    vim.cmd [[write]]
  end
})
