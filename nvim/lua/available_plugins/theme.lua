return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      hide_fillchars = false,
      borderless_pickers = false,
      highlights = function()
        local colors = require("cyberdream.colors").default
        return {
          ["@lsp.type.property"] = { fg = colors.pink },
          NonText = { fg = colors.grey },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
}
