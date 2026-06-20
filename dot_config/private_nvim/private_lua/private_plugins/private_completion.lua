return {
  {
    "onsails/lspkind.nvim",
    lazy = false,
  },
  {
    "github/copilot.vim",
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        window = {
          -- documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered({
            border = "none",
            side_padding = 0,

          }),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 30 })(entry, vim_item)
            vim_item.abbr = (vim_item.abbr or "")
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              luasnip = "[LuaSnip]",
              buffer = "[Buffer]",
            })[entry.source.name]
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            return kind
          end,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
