local autoprojects = {
  {
    path = '/foobar/holoride',
    cmd = 'yarn dev'
  },
  {
    path = '/foobar/abicht-website',
    cmd = 'yarn dev'
  },
  {
    path = '/foobar/family-service',
    cmd = 'source .env && mix phx.server'
  },
}

function Start_server_if_project()
  for _, proj in ipairs(autoprojects) do
    if string.find(vim.fn.getcwd(), os.getenv('HOME') .. proj.path, 0, true) then
      require('harpoon.term').sendCommand(1, proj.cmd)
      if vim.fn.argc() == 0 then
        require('alpha').start(false)
      end
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
