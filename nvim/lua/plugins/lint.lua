return {
  {
    'nvimtools/none-ls.nvim',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require('null-ls').setup()
    end
  }
  -- "mfussenegger/nvim-lint",
  -- config = function()
  --   local lint = require("lint")
  --   lint.linters_by_ft = {
  --     javascript = {
  --       "eslint_d"
  --     },
  --     typescript = {
  --       "eslint_d"
  --     },
  --     javascriptreact = {
  --       "eslint_d"
  --     },
  --     typescriptreact = {
  --       "eslint_d"
  --     },
  --     lua = {
  --       "luacheck"
  --     }
  --   }
  --
  --   vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
  --     callback = function()
  --       lint.try_lint()
  --   end,
  -- })
  -- end
}
