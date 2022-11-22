vim.opt.background = "dark"
vim.g.prmaloney_colorscheme = "rose-pine"
require("tokyonight").setup({
  style = "night",
  transparent = true,
})
require('rose-pine').setup({
  disable_background = true
})
vim.cmd("colorscheme " .. vim.g.prmaloney_colorscheme)
