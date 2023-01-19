vim.opt.background = "dark"
vim.g.prmaloney_colorscheme = "catppuccin"

-- require("tokyonight").setup({
--   style = "night",
--   transparent = true,
-- })

require('rose-pine').setup({
  disable_background = true
})

require('catppuccin').setup({
  flavour = "mocha",
  transparent_background = true
})

vim.cmd("colorscheme " .. vim.g.prmaloney_colorscheme)
