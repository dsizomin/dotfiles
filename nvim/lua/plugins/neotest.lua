local cwd = vim.fn.getcwd()
local isWebCode = cwd:match("web%-code")

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")(isWebCode and {
          jestCommand = "jz test",
        } or {}),
      },
    })
  end,
}
