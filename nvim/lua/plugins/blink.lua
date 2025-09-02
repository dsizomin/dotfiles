return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    {
      "giuxtaposition/blink-cmp-copilot",
      "onsails/lspkind.nvim",
      "nvim-mini/mini.nvim",
      "Kaiser-Yang/blink-cmp-avante",
    },
  },
  opts = {
    fuzzy = {
      implementation = "prefer_rust",
    },
    sources = {
      default = { "avante", "lsp", "path", "snippets", "buffer", "copilot" },
      providers = {
        lsp = {
          score_offset = 0, -- Boost/penalize the score of the items
          async = true,
        },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
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
    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                if ctx.kind == "Copilot" then
                  return ""
                end
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                if ctx.kind == "Copilot" then
                  return "MiniIconsGrey"
                end
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                if ctx.kind == "Copilot" then
                  return "MiniIconsGrey"
                end
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
  },
}
