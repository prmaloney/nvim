-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Scrolloff - this sets the cursor to stay in the middle
vim.o.scrolloff = 100


vim.opt.termguicolors = true

-- Max columns
vim.o.colorcolumn = "80"

-- no wrap
vim.o.wrap = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.winborder = 'rounded'

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 400

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

vim.filetype.add({
	extension = {
		svx = "svelte"
	}
})

vim.cmd("packadd cfilter")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Ensure Fidget uses an opaque background even if the colorscheme doesn't set one.
local function set_fidget_highlights()
	local float_hl = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
	local pmenu_hl = vim.api.nvim_get_hl(0, { name = "Pmenu" })
	local bg = float_hl.bg or pmenu_hl.bg
	local fg = float_hl.fg

	if bg then
		vim.api.nvim_set_hl(0, "FidgetTask", { fg = fg, bg = bg })
	else
		vim.api.nvim_set_hl(0, "FidgetTask", { link = "NormalFloat" })
	end
	vim.api.nvim_set_hl(0, "FidgetTitle", { link = "FloatTitle" })
end

local fidget_group = vim.api.nvim_create_augroup("FidgetHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_fidget_highlights,
	group = fidget_group,
})
set_fidget_highlights()
