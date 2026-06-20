return {
	{
		"williamboman/mason.nvim",
		opts = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp", "saghen/blink.lib" },
		config = function()
			local capabilities = require("blink-cmp").get_lsp_capabilities()
		local lspconfig = vim.lsp.config
			local opts = { noremap = true, silent = true }
			local on_attach = function(_, bufnr)
				opts.buffer = bufnr

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Show LSP definition"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions trim_text=true<cr>", opts)
			end

			lspconfig("sourcekit", {
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = function(_, callback)
					callback(
						require("lspconfig.util").root_pattern("Package.swift")(vim.fn.getcwd())
							or require("lspconfig.util").find_git_ancestor(vim.fn.getcwd())
					)
				end,
				cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
		})
			vim.lsp.enable("sourcekit")
			vim.lsp.enable("clangd")
			vim.lsp.enable("lua_ls")
      vim.lsp.enable("gh_actions_ls")

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},
}
