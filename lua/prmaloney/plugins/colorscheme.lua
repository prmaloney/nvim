local function setColorscheme() 
  vim.cmd.colorscheme('rose-pine')
end
  
return {
  -- rose pine
  {
    'rose-pine/neovim',
    config = function()
      require('rose-pine').setup({
        disable_background = true
      })
      setColorscheme()
    end
  },
  {
  'catppuccin/nvim',
  config = function()
    require('catppuccin').setup({
      flavour = "mocha",
      transparent_background = true
    })
    setColorscheme()
  end
  }
}
