return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
  dependencies = { "Hdoc1509/gh-actions.nvim" },
	config = function()
		-- ─────────────────────────────────────────────
		--  Setup
		-- ─────────────────────────────────────────────
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Install parsers (no-op if already installed)
		require("nvim-treesitter")
			.install({
				"lua",
				"c",
				"cpp",
				"go",
				"rust",
				"python",
				"javascript",
				"typescript",
				"bash",
				"cuda",
			})
			:wait(300000)

		local fts = {
			"lua",
			"c",
			"cpp",
			"go",
			"rust",
			"python",
			"javascript",
			"typescript",
			"bash",
			"cuda",
		}

		-- ─────────────────────────────────────────────
		--  Highlighting
		-- ─────────────────────────────────────────────
		vim.api.nvim_create_autocmd("FileType", {
			pattern = fts,
			callback = function()
				vim.treesitter.start()
			end,
		})

		-- ─────────────────────────────────────────────
		--  Folding
		-- ─────────────────────────────────────────────
		vim.api.nvim_create_autocmd("FileType", {
			pattern = fts,
			callback = function()
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldenable = false
			end,
		})

		-- ─────────────────────────────────────────────
		--  Indentation (experimental)
		-- ─────────────────────────────────────────────
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "python", "go" },
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
    require("gh-actions.tree-sitter").setup()
	end,
}
