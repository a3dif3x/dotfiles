local colors = {
	bg = "#E1E1DE",
	fg = "#73787E",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a tabline in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return " "
	end,
})

ins_right({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.fg },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = "✘ ", warn = " ", info = " ", hint = " " },
	colored = true,
	diagnostics_color = {
		-- Same values as the general color option can be used here.
		error = { fg = colors.fg }, -- Changes diagnostics' error color.
		warn = { fg = colors.fg }, -- Changes diagnostics' warn color.
		info = { fg = colors.fg }, -- Changes diagnostics' info color.
		hint = { fg = colors.fg }, -- Changes diagnostics' hint color.
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

ins_left({
	"branch",
	color = { fg = colors.fg },
	icons_enabled = false,
})

ins_left({
	"diff",
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.fg },
		modified = { fg = colors.fg },
		removed = { fg = colors.fg },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	"filetype",
	icon_only = true,
	colored = false,
})

ins_right({
	-- Lsp server name .
	function()
		local msg = "󰜺 "
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return " "
			end
		end
		return msg
	end,
	color = { fg = colors.fg },
})

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup(config)
		end,
	},
}
