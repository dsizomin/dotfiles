return {
  "mfussenegger/nvim-lint",
  lazy = true,
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = {
        "eslint_d"
      },
      typescript = {
        "eslint_d"
      },
      javascriptreact = {
        "eslint_d"
      },
      typescriptreact = {
        "eslint_d"
      },
      lua = {
        "luacheck"
      }
    }

    vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
      callback = function()
        lint.try_lint()
    end,
  })
  end
}
