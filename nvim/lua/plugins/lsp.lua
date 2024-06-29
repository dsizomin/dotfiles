return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    lazy = true,
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
      },
      {
        "<leader>fr",
        "<cmd>Lspsaga finder<cr>",
        desc = "LSP Finder (Lspsaga)",
      },
      {
        "<leader>ou",
        "<cmd>Lspsaga outline<cr>",
        desc = "Outline (Lspsaga)",
      },
      {
        "<leader>te",
        "<cmd>Lspsaga term_toggle<cr>",
        desc = "Terminal Toggle (Lspsaga)",
      }
    },
  }
}
