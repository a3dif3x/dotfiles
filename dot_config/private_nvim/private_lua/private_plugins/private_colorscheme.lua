-- return {
-- 	"colepeters/spacemacs-theme.vim",
-- 	config = function()
-- 		vim.cmd("colorscheme spacemacs-theme")
-- 	end,
-- }
-- return {
-- 	"wnkz/monoglow.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		require("monoglow").setup({
-- 			-- Change the "glow" color
-- 			on_colors = function(colors)
-- 				colors.glow = "#FBFE32"
-- 				colors.bg = "#181818"
-- 			end,
--
-- 			on_highlights = function(hl, c)
-- 				-- Override with full definition (recommended)
-- 				hl.Conditional = { fg = "#FBFE32" }
-- 				hl.Boolean = { fg = "#FBFE32" }
--
-- 				hl["@boolean"] = { fg = "#FBFE32", italic = false }
-- 				hl["@keyword.conditional"] = { fg = "#FBFE32", italic = false }
-- 				hl["@keyword.return"] = { fg = "#FBFE32", italic = false }
-- 				hl["@keyword.modifier"] = { fg = "#FBFE32", italic = false }
-- 				hl["@keyword.qualifier"] = { fg = "#FBFE32", italic = false }
-- 			end,
-- 		})
-- 		vim.cmd.colorscheme("monoglow")
-- 	end,
-- }

return {
	"thesimonho/kanagawa-paper.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd.colorscheme("kanagawa-paper-canvas")
	end,
}
