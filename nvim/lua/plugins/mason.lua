return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim"
    },
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
      })
    end
  },
}
