local nnoremap = require('prmaloney.keymap').nnoremap

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous
      }
    }
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<C-x>"] = "delete_buffer",
        }
      }
    }
  }
}

nnoremap('<leader>f', function() require("telescope.builtin").find_files() end)
nnoremap('<leader>F', function() require("telescope.builtin").live_grep() end)
nnoremap('<leader>bf', function() require("telescope.builtin").buffers() end)
nnoremap('<leader>br', function() require("telescope.builtin").git_branches() end)
nnoremap('<leader>st', function() require("telescope.builtin").git_stash() end)
nnoremap('<leader>no', function()
  if not require('prmaloney.utils').fileExists('package.json') then
    error('no package.json file found')
  end
  local package = io.open('package.json', 'r')
  if not package then return end
  local scripts = {}
  for key, _ in pairs(vim.json.decode(package:read("*a")).scripts) do
    table.insert(scripts, key)
  end
  require('telescope.pickers').new({}, {
    prompt_title = 'node scripts',
    finder = require('telescope.finders').new_table { results = scripts },
    sorter = require('telescope.config').values.generic_sorter(),
    attach_mappings = function(prompt_bufnr)
      local actions = require('telescope.actions')
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        require('harpoon.term').sendCommand(1, string.format('yarn %s', selection[1]))
      end)
      return true
    end
  }):find()
end)