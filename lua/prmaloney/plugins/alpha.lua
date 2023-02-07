return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local dashboard = require('alpha.themes.dashboard')
    dashboard.section.header.opts.hl = 'Function'
    dashboard.section.header.val = {
      "                ▄▄                  ",
      "              ▄▀  █                 ",
      "             █  ██ █                ",
      "              █     ▀▀▄▄            ",
      "             ▄▄▀ ▄▀▀▄▄▄▀▀▀▄         ",
      "            █    █▄ ▄  ▀▄  █        ",
      "            ▀▄     ▀█▀▄▄▀▀▄▀        ",
      "            ▄▀▀█▄  █▄ █             ",
      "     ▄▄▀▀▀▀▀▀    ▀██ ▀              ",
      "   ▄▀              █                ",
      "   ▀▄██▀▀▀▀▄▄▄     ▀▄               ",
      "      ▀▀▄▄▄  ▀▄▀▀█   █              ",
      "           ▀▀▄  ▄▀    ▀▄            ",
      "             ▀▄ █▀▄     ▀▄▄         ",
      "            ▄▀ ▄▀  ▀▄▄  █  ▀▄       ",
      "             ▀▀       ▀▀▄   ▀▄      ",
      "                         ▀▀▄ ▀▄▀▀▄  ",
      "                            ▀▄   █  ",
      "                              ▀▄  █ ",
      "                                █ █ ",
      "                                ▀▄▀ ",
    }
    -- dashboard.section.header.val = {
    --   "░░░░░░░▄▄▀▀▀▀▀▀▀▀▄▄▄░░░░░░░░░",
    --   "░░░░▄▀▀░░░░░░░░░░░░░▀▄░░░░░░░",
    --   "░░▄▀░░░░░░░░░░░░░░░░░░▀▀▄░░░░",
    --   "░░█░░░░░░░░░░░░░░░░░░░░░▀▄░░░",
    --   "░█░░░░░░░░░░░░░░░░░░░░░░░▀▄░░",
    --   "▄▀░░░░░░░░░░░░░░░░░░░░░░░░█░░",
    --   "█░░░░░░░░░░░░░░░░░░░░░░░░░░█░",
    --   "█░░░░░░░░░░░░░░░░░░░░░░░░░░█░",
    --   "▀▄░░░░░░░░░░░██░░░░░░░░██░░█░",
    --   "░█░░░░░░░░░░░░░░░░░░█░░░░░░█░",
    --   "░░█░░░▄▀░░░░░░░░░░░░░█░░░░░░█",
    --   "░░░█░░▀▄░░░░░░░░░░░░░▀▄░░░░█░",
    --   "░░░░█░░█░░░░░░░░▄▄▄▄▄▄█░░░▄▀░",
    --   "░░░░█░░▄▀▄░░░░░░░░░░░░░░░▄▀░░",
    --   "░░░█░░░█░░▀▄░░░▀▀▀▀▀▀▀▀░▄▀░░░",
    --   "░░░█░░░░░░░░▀▄░░░░░░░░░▄▀░░░░",
    --   "░░█░░░▄▄░░░░░░▀▀▄▄▄▄▄▀▀░░░░░░",
    -- }
    dashboard.section.header.opts.position = 'center'
    dashboard.section.buttons.val = {
      dashboard.button("tff", "  Find file",
        [[<Cmd>lua require('telescope.builtin').find_files({ layout_strategy = 'vertical' })<CR>]]),
      dashboard.button("tfg", "  Live grep",
        "<CMD>lua require('telescope.builtin').live_grep({ layout_strategy = 'vertical', preview = true })<CR>"),
      dashboard.button("tfr", "  Recent File", "<CMD>silent Telescope oldfiles preview=false<CR>"),
      dashboard.button("cfg", "  Config",
        "<CMD>lua require('prmaloney.usercmds').search_config({ layout_strategy = 'vertical' })<CR>"),
      dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
    }
    local quotes = {
      { "Yo did he just walk up slowly and downsmash?", "", "-bobby scar" },
      { "Show me ya moves", "", "-C. Falcon" },
      { "You're like 3 knees and people cheer, I'm like pivot stuff and people pass out.", "", "-n0ne" },
      { "Happy feet, WOMBO COMBO!" },
      { "ggs you just got bonded", "", "-bond" },
      { "Don't get hit", "", "-isai" },
      { "unplug your controller dog", "", "-HMW" }
    }
    dashboard.section.footer.val = quotes[math.random(1, #quotes)]
    require('alpha').setup(dashboard.opts)
  end
}