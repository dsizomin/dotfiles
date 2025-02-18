return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "giuxtaposition/blink-cmp-copilot",
      "onsails/lspkind.nvim",
    },
  },
  opts = {
    keymap = { preset = "enter" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
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
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
    },
    cmdline = {
      enabled = true,
      keymap = nil, -- Inherits from top level `keymap` config when not set
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
        auto_show = true,
        draw = {
          components = {
            kind_icon = {
              text = function(item)
                local kind = (item.kind == "Copilot" and "") or require("lspkind").symbol_map[item.kind] or ""
                return kind .. " "
              end,
            },
          },
        },
      },
      list = {
        selection = {
          preselect = false,
        },
      },
    },

    signature = {
      enabled = true,
    },
  },
}
