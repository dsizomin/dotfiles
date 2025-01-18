local cwd = vim.fn.getcwd()
local isWebCode = cwd:match "web%-code"

return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup {
        transparent = true,
        italic_comments = true,
        borderless_telescope = false,
        theme = {
          variant = "dark",
        },
      }
      vim.cmd "colorscheme cyberdream"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "v4.*",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",

        diagnostics_indicator = function(count, level)
          local sym = level == "error" and " " or (level == "warning" and " " or " ")
          return count .. sym
        end,
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        lsp = {
          signature = {
            enabled = false,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-web-devicons" },
    opts = function()
      return {
        options = {
          component_separators = { left = " ", right = " " },
          section_separators = { left = " ", right = " " },
          theme = "cyberdream",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              icon = "",
              fmt = function(mode)
                return mode:lower()
              end,
            },
          },
          -- lualine_b = { { "branch", icon = "" } },
          lualine_c = {
            {
              "filename",
              color = function()
                local _, hl = require("nvim-web-devicons").get_icon(vim.fn.expand "%:t")
                if hl then
                  return hl
                end
                return "Normal"
              end,
              fmt = function(name)
                local devicons = require "nvim-web-devicons"
                local ft = vim.bo.filetype
                local icon
                if icon == nil then
                  icon = devicons.get_icon(vim.fn.expand "%:t")
                end
                if icon == nil then
                  icon = devicons.get_icon_by_filetype(ft)
                end
                if icon == nil then
                  icon = " 󰈤"
                end

                return icon .. " " .. name
              end,
            },
            -- {
            --   function()
            --     if not pcall(require, "lsp_signature") then
            --       return
            --     end
            --     local sig = require("lsp_signature").status_line(50)
            --     return sig.label
            --   end,
            --   icon = "󰊕",
            --   color = "Special",
            -- },
            -- {
            --   function()
            --     if not pcall(require, "lsp_signature") then
            --       return
            --     end
            --     local sig = require("lsp_signature").status_line(50)
            --     return sig.hint
            --   end,
            --   icon = "󰀫",
            --   color = "String",
            -- },
          },
        },
      }
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ft", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>" },
    },
    config = function()
      require("telescope").load_extension "file_browser"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup {
        indent = { char = "│", highlight = "IblIndent" },
        scope = { char = "│", highlight = "IblScope" },
      }
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "luadoc",
        "printf",
        "vim",
        "vimdoc",
        "typescript",
        "javascript",
        "tsx",
        "html",
        "css",
        "markdown",
        "graphql",
      },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    -- event = "User FilePost",
    opts = function()
      return {
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "━" },
          topdelete = { text = "‾" },
          changedelete = { text = "" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "━" },
          topdelete = { text = "‾" },
          changedelete = { text = "" },
          untracked = { text = "┆" },
        },
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function opts(desc)
            return { buffer = bufnr, desc = desc }
          end

          local map = vim.keymap.set

          map("n", "<leader>rh", gs.reset_hunk, opts "Reset Hunk")
          map("n", "<leader>ph", gs.preview_hunk, opts "Preview Hunk")
          map("n", "<leader>gb", gs.blame_line, opts "Blame Line")
        end,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = function()
      require("mason").setup {}
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    -- event = "User FilePost",
    config = function()
      local x = vim.diagnostic.severity

      vim.diagnostic.config {
        severity_sort = true,
        virtual_text = { prefix = "" },
        signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
        underline = true,
        float = { border = "single" },
      }

      vim.fn.sign_define("DiagnosticSignError", { text = "󰅙", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "󰋼", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

      local map = vim.keymap.set
      -- on_attach
      local function on_attach(_, bufnr)
        local function opts(desc)
          return { buffer = bufnr, desc = "LSP " .. desc }
        end

        map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
        map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
        map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
        map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
        map("n", "K", vim.lsp.buf.hover, opts "Hover documentation")

        map("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts "List workspace folders")

        map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

        -- map("n", "<leader>ra", function()
        --   require "nvchad.lsp.renamer"()
        -- end, opts "NvRenamer")

        -- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
        map("n", "gr", vim.lsp.buf.references, opts "Show references")
      end

      -- on_init
      local function on_init(client, _)
        if client.supports_method "textDocument/semanticTokens" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local lspconfig = require "lspconfig"
      local lsputils = require "lspconfig.util"
      local root_dir = lsputils.root_pattern ".yarn"(cwd)

      -- lua
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = on_init,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.fn.expand "$VIMRUNTIME/lua",
                vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                "${3rd}/luv/library",
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }

      lspconfig.vtsls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        init_options = {
          hostInfo = "neovim",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            typescript = isWebCode and {
              globalTsdk = root_dir .. "/.yarn/sdks/typescript/lib",
            } or {},
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
              autoImports = not isWebCode,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
            tsserver = {
              maxTsServerMemory = isWebCode and 8192 or 2048,
            },
          },
        },
      }

      -- eslint
      lspconfig.eslint.setup {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
          on_attach(client, bufnr)
        end,
        on_init = on_init,
        capabilities = capabilities,
        workingDirectory = { mode = "auto" },
        settings = isWebCode and {
          nodePath = root_dir .. "/.yarn/sdks",
        } or {},
      }

      lspconfig.graphql.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }

      lspconfig.dockerls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }

      lspconfig.docker_compose_language_service.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      {
        "giuxtaposition/blink-cmp-copilot",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
      },
    },
    version = "v0.*",
    opts = {
      keymap = { preset = "enter" },
      snippets = { preset = "luasnip" },
      appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = false,
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          lsp = {
            score_offset = 0, -- Boost/penalize the score of the items
            async = true,
          },
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          treesitter_highlighting = true,
          window = {
            border = "rounded",
          },
        },
        menu = {
          border = "rounded",
          draw = {
            components = {
              kind_icon = {
                text = function(item)
                  local kind = (item.kind == "Copilot" and "") or require("lspkind").symbol_map[item.kind] or ""
                  return kind .. " "
                end,
              },
            },
          },
        },
        list = {
          selection = {
            preselect = false,
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     floating_window = false,
  --     hint_enable = false,
  --   },
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup {}
    end,
    keys = { {
      "<leader>ra",
      ":IncRename ",
      desc = "IncRename",
    } },
  },
  {
    "aznhe21/actions-preview.nvim",
    keys = {
      {
        "<leader>ca",
        function()
          require("actions-preview").code_actions()
        end,
        mode = { "n", "v" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "danymat/neogen",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("neogen").setup { snippet_engine = "luasnip" }
    end,
    keys = {
      { "<leader>gn", "<cmd>Neogen<CR>", desc = "Generate annotation" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    keys = {
      { "<leader>cp", "<cmd>CccPick<CR>", desc = "Color picker" },
    },
    config = function()
      require("ccc").setup {
        highlighter = {
          auto_enable = true,
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-jest"(isWebCode and {
            jestCommand = "jz test",
          } or {}),
        },
      }
    end,
  },
}
