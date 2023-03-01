# my config for neovim

## install

- you'll need to install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) if you haven't already
- clone this repo into your config directory (usually `$HOME/.config/nvim`

That's it, you should be good to go

## good stuff to know

- most of the keymaps are in `/lua/prmaloney/remaps.lua`, but there's quite a few more scattered around
  - to find those you can open neovim in your config directory and press `<space>Shift+f` to run a live grep across the whole project (you can search for `nnoremap` to find instances where I define a few more of the keymaps)
- most plugin-specific configuration is located in files that look like `/after/plugin/{plugin-name}.lua`
- I have a few custom editor commands defined in `/lua/prmaloney/usercmds.lua` for things I do fairly often, but not often enough to have a keybinding for
