return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    {
      "fang2hou/blink-copilot",
      "onsails/lspkind.nvim",
      "nvim-mini/mini.nvim",
      "Kaiser-Yang/blink-cmp-avante",
    },
  },
  opts = {
    sources = {
      default = { "avante", "lsp", "path", "snippets", "buffer", "copilot" },
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
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {
            -- options for blink-cmp-avante
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
