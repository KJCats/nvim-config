--Theme
vim.cmd("colorscheme catppuccin")

--Keymaps
local keymaps = require("keymaps")
keymaps.set_keymaps()

-- LAZY.NVIM BOOTSTRAP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim
local opts = {}

require("lazy").setup("plugins")

-- Floating Terminal
require("terminal")

-- Statusline
local statusline = require("statusline")
statusline.setup()

--Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

--Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

--Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

--Visual Settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = true
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

-- Auto create Undo dir
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- Behavior settings
vim.opt.hidden = true
--vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
--vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
--vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

-- Commandline Completion
vim.opt.wildmenu = true

--Cursor Settings
vim.cmd("set guicursor=n-v-c-ve:block,i-ci:ver25,r-cr:hor20,o:hor50")

local function show_word_definition()
	local word = vim.fn.expand("<cword>")
	if word == "" then
		print("No word under cursor")
		return
	end

	local definition = vim.fn.systemlist("dict " .. vim.fn.shellescape(word))

	if vim.v.shell_error ~= 0 or #definition == 0 or definition[1]:match("No definitions found") then
		print("No definition found for '" .. word .. "'.")
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "cursor",
		width = 80,
		height = 20,
		style = "minimal",
		border = "rounded",
		row = 1,
		col = 0,
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, definition)

	vim.api.nvim_set_current_win(win)

	local close_win = function()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	vim.keymap.set("n", "q", close_win, { buffer = buf, silent = true, desc = "Close definition window" })
	vim.keymap.set("n", "<Esc>", close_win, { buffer = buf, silent = true, desc = "Close definition window" })
end

vim.keymap.set("n", "<leader>k", show_word_definition, { desc = "Show word definition" })
