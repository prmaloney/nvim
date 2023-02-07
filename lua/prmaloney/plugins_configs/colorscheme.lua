return {
  'rose-pine/neovim',
  config = function()
    require('rose-pine').setup({
      disable_background = true
    })
  end
}
--vim.opt.background = "dark"
--vim.g.prmaloney_colorscheme = "catppuccin"
--print('setting colorscheme')

-- require("tokyonight").setup({
--   style = "night",
--   transparent = true,
-- })


--require('catppuccin').setup({
--  flavour = "mocha",
--  transparent_background = true
--})

