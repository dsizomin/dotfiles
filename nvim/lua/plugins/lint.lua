return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      if vim.fn.getcwd():match('web%-code') then
        require('null-ls').setup({
          sources = {
            require("none-ls.formatting.eslint").with({
              command = '.yarn/sdks/eslint/bin/eslint.js',
            }),
            require("none-ls.diagnostics.eslint").with({
              command = '.yarn/sdks/eslint/bin/eslint.js',
            }),
            require("none-ls.code_actions.eslint").with({
              command = '.yarn/sdks/eslint/bin/eslint.js',
            }),
          }
        })
      else
        require('null-ls').setup({
          sources = {
            require("none-ls.formatting.eslint"),
            require("none-ls.diagnostics.eslint"),
            require("none-ls.code_actions.eslint"),
          }
        })
      end
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
