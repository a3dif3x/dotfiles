local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Latest stable release
		lazypath,
	})
end

vim.opt.laststatus = 0
vim.opt.termguicolors = true
vim.cmd("set number relativenumber!")
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

vim.o.background = "dark"

vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.fillchars = { eob = " " }
vim.loader.enable()
vim.cmd("hi LineNrAbove guifg=grey")
vim.api.nvim_set_hl(0, "LineNr", { fg = "yellow", bold = true })
vim.cmd("hi LineNrBelow guifg=grey")
vim.cmd("hi SignColumn guibg=none")
vim.cmd("highlight clear SignColumn")
