return {
  "folke/snacks.nvim",
  version = "*",
  ---@type snacks.Config
  opts = {
    picker = {
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
    scroll = {
      enabled = false,
    },
    lazygit = {
      enabled = true,
    },
    statuscolumn = {
      folds = {
        open = true,
      },
    },
  },
  keys = {
    { "<leader>/", false },
  },
}
