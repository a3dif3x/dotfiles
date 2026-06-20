return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
      },
      win_options = {
        signcolumn = "yes",
        cursorcolumn = true,
      },
    })
  end,
}
