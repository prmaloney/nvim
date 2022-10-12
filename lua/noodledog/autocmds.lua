vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })]]

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function start_server_if_project ()
  if file_exists("package.json") then
    vim.cmd [[:term yarn dev]]
    vim.cmd [[:b#]]
  end
end

vim.cmd [[autocmd VimEnter * lua start_server_if_project()]]
