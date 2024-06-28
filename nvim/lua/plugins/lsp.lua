return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require('lspconfig').tsserver.setup({})
      require('lspconfig').lua_ls.setup({})
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
     dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    keys = {
      {
        "<leader>ca",
        "<cmd>Lspsaga code_action<cr>",
        desc = "Code Actions (Lspsaga)",
      },
      {
        "<leader>pd",
        "<cmd>Lspsaga peek_definition<cr>",
        desc = "Peek Definition (Lspsaga)",
      },
      {
        "<leader>gd",
        "<cmd>Lspsaga goto_definition<cr>",
        desc = "Goto Definition (Lspsaga)",
      },
      {
        "<leader>rn",
        "<cmd>Lspsaga rename<cr>",
        desc = "Rename (Lspsaga)",
      }
    },
    config = function()
        require('lspsaga').setup({})
    end,
  }
}
