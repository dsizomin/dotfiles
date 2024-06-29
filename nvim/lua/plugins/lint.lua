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
}
