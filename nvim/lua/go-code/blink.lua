return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    {
      "fang2hou/blink-copilot",
      "onsails/lspkind.nvim",
      "nvim-mini/mini.nvim",
    },
  },
  opts = {
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "copilot",
      },
      providers = {
        lsp = {
          score_offset = 0, -- Boost/penalize the score of the items
          async = true,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          opts = {
            kind_hl = "MiniIconsGrey",
          },
        },
      },
    },
    cmdline = {
      enabled = true,
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline" }
        end
        return {}
      end,
    },
  },
}
