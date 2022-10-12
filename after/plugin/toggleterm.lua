require("toggleterm").setup{
  open_mapping = [[<c-\>]],
}
local nnoremap = require('noodledog/keymap').nnoremap
local Terminal = require('toggleterm.terminal').Terminal

nnoremap('<C-|>', '<cmd>ToggleTermToggleAll<CR>')
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

local vertical = Terminal:new({
  direction = "vertical",
  size = vim.o.columns * 0.4
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>ToggleTerm direction=vertical size=50<CR>", {noremap = true, silent = true})
