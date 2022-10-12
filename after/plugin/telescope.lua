local nnoremap = require('noodledog.keymap').nnoremap

require('telescope').setup{
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

nnoremap('<leader>f', '<cmd>lua require("telescope.builtin").find_files()<CR>')
nnoremap('<leader>F', '<cmd>lua require("telescope.builtin").live_grep()<CR>')
nnoremap('<leader>bf', '<cmd>lua require("telescope.builtin").buffers()<CR>')
