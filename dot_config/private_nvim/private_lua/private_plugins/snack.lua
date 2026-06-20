return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dashboard = {
			enabled = true,
			sections = {
				{
					pane = 1,
					icon = " ",
					desc = "Browse Repo",
					padding = 1,
					key = "b",
					action = function()
						Snacks.gitbrowse()
					end,
				},
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							title = "Open Issues",
							cmd = "gh issue list -L 3",
							key = "i",
							action = function()
								vim.fn.jobstart("gh issue list --web", { detach = true })
							end,
							icon = " ",
							height = 7,
						},
						{
							icon = " ",
							title = "Open PRs",
							cmd = "gh pr list -L 3",
							key = "P",
							action = function()
								vim.fn.jobstart("gh pr list --web", { detach = true })
							end,
							height = 7,
						},
						{
							icon = " ",
							title = "Git Status",
							cmd = "git --no-pager diff --stat -B -M -C",
							height = 10,
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							pane = 1,
							section = "terminal",
							enabled = in_git,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						}, cmd)
					end, cmds)
				end,
				{ section = "startup" },
			},
		},
		bigfile = { enabled = true },
		explorer = { enabled = false },
		indent = { enabled = false },
		input = { enabled = true },
		picker = { enabled = false },
		notifier = { enabled = false },
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = {
			enabled = true,
			left = { "sign", "mark" },
			right = { "git", "fold" },
			folds = {
				open = true,
				git_hl = true,
			},
		},
		words = { enabled = false },
	},
}
