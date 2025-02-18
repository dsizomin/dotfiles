return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
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
    {
      "<leader>fw",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
  },
}
