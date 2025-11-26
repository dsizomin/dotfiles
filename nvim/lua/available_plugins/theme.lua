return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      highlights = function()
        local colors = require("cyberdream.colors").default
        return {
          ["@lsp.type.property"] = { fg = colors.pink },
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
