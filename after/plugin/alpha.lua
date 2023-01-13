local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {
  "░░░░░░░▄▄▀▀▀▀▀▀▀▀▄▄▄░░░░░░░░░",
  "░░░░▄▀▀░░░░░░░░░░░░░▀▄░░░░░░░",
  "░░▄▀░░░░░░░░░░░░░░░░░░▀▀▄░░░░",
  "░░█░░░░░░░░░░░░░░░░░░░░░▀▄░░░",
  "░█░░░░░░░░░░░░░░░░░░░░░░░▀▄░░",
  "▄▀░░░░░░░░░░░░░░░░░░░░░░░░█░░",
  "█░░░░░░░░░░░░░░░░░░░░░░░░░░█░",
  "█░░░░░░░░░░░░░░░░░░░░░░░░░░█░",
  "▀▄░░░░░░░░░░░██░░░░░░░░██░░█░",
  "░█░░░░░░░░░░░░░░░░░░█░░░░░░█░",
  "░░█░░░▄▀░░░░░░░░░░░░░█░░░░░░█",
  "░░░█░░▀▄░░░░░░░░░░░░░▀▄░░░░█░",
  "░░░░█░░█░░░░░░░░▄▄▄▄▄▄█░░░▄▀░",
  "░░░░█░░▄▀▄░░░░░░░░░░░░░░░▄▀░░",
  "░░░█░░░█░░▀▄░░░▀▀▀▀▀▀▀▀░▄▀░░░",
  "░░░█░░░░░░░░▀▄░░░░░░░░░▄▀░░░░",
  "░░█░░░▄▄░░░░░░▀▀▄▄▄▄▄▀▀░░░░░░",
}
dashboard.section.header.opts.position = 'center'
dashboard.section.buttons.val = {
  dashboard.button("tff", "  Find file", "<CMD>silent Telescope find_files<CR>"),
  dashboard.button("tfg", "  Live grep", "<CMD>silent Telescope live_grep preview=true<CR>"),
  dashboard.button("tfr", "  Recent File", "<CMD>silent Telescope oldfiles preview=false<CR>"),
  dashboard.button("cfg", "  Config", "<CMD>silent cd ~/.config/nvim | e init.lua<CR>"),
  dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}
require('alpha').setup(dashboard.opts)
