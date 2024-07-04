return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = {
          exclude = { "eslint" },
        },
        ensure_installed = {
          "eslint@4.8.0",
        },
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        hint_enable = false,
      })
    end,
  },
  {
    "ray-x/navigator.lua",
    dependencies = {
      {
        "ray-x/guihua.lua",
        run = "cd lua/fzy && make",
      },

      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      local cwd = vim.fn.getcwd()
      local lsputils = require("lspconfig.util")
      local root_dir = lsputils.root_pattern(".yarn")(cwd)

      require("navigator").setup({
        mason = true,
        default_mapping = false,
        lsp = {
          diagnostics = {
            severity_sort = true,
          },
          tsserver = cwd:match("web%-code") and {
            init_options = {
              maxTsServerMemory = 8192,
              tsserver = {
                path = root_dir .. "/.yarn/sdks/typescript/lib/tsserver.js",
              },
            },
          } or {},
          eslint = cwd:match("web%-code") and {
            workingDirectory = { mode = "auto" },
            settings = {
              nodePath = root_dir .. "/.yarn/sdks",
            },
          } or {},
        },
        icons = {
          icons = false,
          code_action_icon = " ",
          code_lens_action_icon = "",
        },
        keymaps = {
          {
            key = "<Leader>gr",
            func = require("navigator.reference").async_ref,
            desc = "async_ref",
          },
          { key = "<Leader>gd", func = require("navigator.definition").definition, desc = "definition" },
          {
            key = "<Leader>pd",
            func = require("navigator.definition").definition_preview,
            desc = "definition (preview)",
          },
          {
            key = "K",
            func = vim.lsp.buf.hover,
            desc = "hover",
          },
          {
            key = "<Leader>rn",
            func = require("navigator.rename").rename,
            desc = "rename",
          },
          {
            key = "<Leader>ca",
            mode = "n",
            func = require("navigator.codeAction").code_action,
            desc = "code_action",
          },
          {
            key = "<Leader>ca",
            mode = "v",
            func = require("navigator.codeAction").range_code_action,
            desc = "range_code_action",
          },
          {
            key = "<Leader>la",
            mode = "n",
            func = require("navigator.codelens").run_action,
            desc = "run code lens action",
          },
          {
            key = "<Leader>dl",
            func = require("navigator.diagnostics").show_diagnostics,
            desc = "show_diagnostics",
          },
          {
            key = "<Leader>df",
            func = require("navigator.diagnostics").show_buf_diagnostics,
            desc = "show_buf_diagnostics",
          },
          {
            key = "<Leader>dt",
            func = require("navigator.diagnostics").toggle_diagnostics,
            desc = "toggle_diagnostics",
          },
        },
      })

      vim.api.nvim_set_hl(0, "DiagnosticsSignHint", { link = "DiagnosticSignHint" })
    end,
  },
  -- {
  -- 	"neovim/nvim-lspconfig",
  --
  -- 	dependencies = {
  -- 		"hrsh7th/cmp-nvim-lsp",
  -- 	},
  --
  -- 	config = function()
  -- 		local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- 		local lspconfig = require("lspconfig")
  -- 		local cwd = vim.fn.getcwd()
  --
  -- 		lspconfig.lua_ls.setup({
  -- 			capabilities = capabilities,
  -- 		})
  --
  -- 		if cwd:match("web%-code") then
  -- 			local lsputils = require("lspconfig.util")
  -- 			local root_dir = lsputils.root_pattern(".yarn")
  -- 			lspconfig.tsserver.setup({
  -- 				capabilities = capabilities,
  -- 				init_options = {
  -- 					maxTsServerMemory = 8192,
  -- 					tsserver = {
  -- 						path = root_dir(cwd) .. "/.yarn/sdks/typescript/lib/tsserver.js",
  -- 					},
  -- 				},
  -- 			})
  -- 			lspconfig.eslint.setup({
  -- 				capabilities = capabilities,
  -- 				workingDirectory = { mode = "auto" },
  -- 				settings = {
  -- 					nodePath = root_dir(cwd) .. "/.yarn/sdks",
  -- 				},
  -- 				on_attach = function(client, bufnr)
  -- 					vim.api.nvim_create_autocmd("BufWritePre", {
  -- 						buffer = bufnr,
  -- 						command = "EslintFixAll",
  -- 					})
  -- 				end,
  -- 			})
  -- 		else
  -- 			lspconfig.tsserver.setup({
  -- 				capabilities = capabilities,
  -- 			})
  -- 			lspconfig.eslint.setup({
  -- 				capabilities = capabilities,
  -- 				on_attach = function(client, bufnr)
  -- 					vim.api.nvim_create_autocmd("BufWritePre", {
  -- 						buffer = bufnr,
  -- 						command = "EslintFixAll",
  -- 					})
  -- 				end,
  -- 			})
  -- 		end
  -- 	end,
  -- },
}
