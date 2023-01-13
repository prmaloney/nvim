require("telescope").load_extension("git_worktree")
local Worktree = require('git-worktree')
local nnoremap = require('prmaloney.keymap').nnoremap
local Job = require('plenary.job')

nnoremap('<leader>wt', function()
  require('telescope').extensions.git_worktree.git_worktrees()
end)

nnoremap('<leader>nwt', function()
  require('telescope').extensions.git_worktree.create_git_worktree()
end)

Worktree.on_tree_change(function (op, metadata)
  if op == Worktree.Operations.Switch then
    if require('prmaloney.utils').fileExists('package.json') then
      print('path', metadata.path)
      Job:new({
        'yarn', 'install'
      }):start()
    end
  end
end)
