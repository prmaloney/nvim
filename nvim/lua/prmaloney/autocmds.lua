local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
end

function start_server_if_project()
  if file_exists("package.json") then
    vim.cmd [[:term yarn dev]] --start server in new buffer
    vim.cmd [[:b#]] --go back to previous buffer
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = start_server_if_project
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  callback = function()
    vim.cmd [[EslintFixAll]]
    vim.cmd [[write]]
  end
})
