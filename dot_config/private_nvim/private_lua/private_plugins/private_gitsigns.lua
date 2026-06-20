return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signcolumn = true, -- Keep signs on
			numhl = false,
			linehl = false,
			word_diff = false,
		})
	end,
}
