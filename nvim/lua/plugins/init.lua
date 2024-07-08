return {
  { "lbrayner/vim-rzip", lazy = false },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig",
      "pmizio/typescript-tools.nvim",
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup {
        automatic_installation = {
          exclude = { "eslint" },
        },
        ensure_installed = {
          "eslint@4.8.0",
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    -- event = "LspAttach",
    config = function()
      require("lspsaga").setup {}
    end,
    keys = {
      {"<leader>ac", "<cmd>Lspsaga code_action<CR>"},
      {"<leader>pd", "<cmd>Lspsaga peek_definition<CR>"},
      {"<leader>gd", "<cmd>Lspsaga goto_definition<CR>"},
      {"<leader>pt", "<cmd>Lspsaga peek_type_definition<CR>"},
      {"<leader>gt", "<cmd>Lspsaga goto_type_definition<CR>"},
      {"<leader>rn", "<cmd>Lspsaga rename<CR>"},
      {"<leader>fr", "<cmd>Lspsaga finder<CR>"},
      {"K", "<cmd>Lspsaga hover_doc<CR>"},
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      enable = false,
    },
    panel = {
      enable = false,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ft", "<cmd>Telescope file_browser<CR>" },
    },
    config = function()
      require("telescope").load_extension "file_browser"
    end,
  },
}
