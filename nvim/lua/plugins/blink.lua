return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "giuxtaposition/blink-cmp-copilot",
      "onsails/lspkind.nvim",
      "nvim-tree/nvim-web-devicons",
      "Kaiser-Yang/blink-cmp-avante",
    },
  },
  opts = {
    keymap = { preset = "enter" },
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
      keymap = {
        ["<Tab>"] = { "show", "accept" },
      },
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
      completion = {
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ":"
          end,
        },
      },
    },
    completion = {
      menu = {
        auto_show = true,
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local lspkind = require("lspkind")
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                elseif ctx.kind == "Copilot" then
                  icon = ""
                elseif ctx.kind == "Avante" then
                  icon = "󰖷"
                else
                  icon = lspkind.symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,

              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
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
      -- enabled = true,
    },
  },
}
