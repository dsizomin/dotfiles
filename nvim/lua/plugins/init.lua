return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup {
        transparent = true,
        italic_comments = true,
        borderless_telescope = true,
        theme = {
          variant = "dark",
        },
      }
      vim.cmd "colorscheme cyberdream"
    end,
  },
  {
    "akinsho/bufferline.nvim",
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
            {
              function()
                if not pcall(require, "lsp_signature") then
                  return
                end
                local sig = require("lsp_signature").status_line(50)
                return sig.label
              end,
              icon = "󰊕",
              color = "Special",
            },
            {
              function()
                if not pcall(require, "lsp_signature") then
                  return
                end
                local sig = require("lsp_signature").status_line(50)
                return sig.hint
              end,
              icon = "󰀫",
              color = "String",
            },
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
        -- if client.supports_method "textDocument/semanticTokens" then
        --   client.server_capabilities.semanticTokensProvider = nil
        -- end
      end

      -- capabilities
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.completion.completionItem = {
      --   documentationFormat = { "markdown", "plaintext" },
      --   snippetSupport = true,
      --   preselectSupport = true,
      --   insertReplaceSupport = true,
      --   labelDetailsSupport = true,
      --   deprecatedSupport = true,
      --   commitCharactersSupport = true,
      --   tagSupport = { valueSet = { 1 } },
      --   resolveSupport = {
      --     properties = {
      --       "documentation",
      --       "detail",
      --       "additionalTextEdits",
      --     },
      --   },
      -- }
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local lspconfig = require "lspconfig"
      local cwd = vim.fn.getcwd()
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

      -- typescript
      lspconfig.ts_ls.setup(cwd:match "web%-code" and {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        init_options = {
          maxTsServerMemory = 65536,
          tsserver = {
            path = root_dir .. "/.yarn/sdks/typescript/lib/tsserver.js",
          },
        },
      } or {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      })

      -- eslint
      lspconfig.eslint.setup(cwd:match "web%-code" and {
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
        settings = {
          nodePath = root_dir .. "/.yarn/sdks",
        },
      } or {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      })

      lspconfig.graphql.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end,
  },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
      {
        "giuxtaposition/blink-cmp-copilot",
        "rafamadriz/friendly-snippets",
      },
    },
    -- use a release tag to download pre-built binaries
    version = "v0.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = "enter" },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
        -- optionally disable cmdline completions
        -- cmdline = {},
      },
      completion = {
        list = {
          selection = "auto_insert",
        },
      },
      -- experimental signature help support
      -- signature = { enabled = true }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     {
  --       "onsails/lspkind.nvim",
  --       config = function()
  --         require("lspkind").init {
  --           mode = "symbol_text",
  --           symbol_map = {
  --             Text = "󰉿",
  --             Method = "󰆧",
  --             Function = "󰊕",
  --             Constructor = "",
  --             Field = "󰜢",
  --             Variable = "󰀫",
  --             Class = "󰠱",
  --             Interface = "",
  --             Module = "",
  --             Property = "󰜢",
  --             Unit = "󰑭",
  --             Value = "󰎠",
  --             Enum = "",
  --             Keyword = "󰌋",
  --             Snippet = "",
  --             Color = "󰏘",
  --             File = "󰈙",
  --             Reference = "󰈇",
  --             Folder = "󰉋",
  --             EnumMember = "",
  --             Constant = "󰏿",
  --             Struct = "󰙅",
  --             Event = "",
  --             Operator = "󰆕",
  --             TypeParameter = "󰗴",
  --             Copilot = "",
  --           },
  --         }
  --       end,
  --     },
  --     {
  --       -- snippet plugin
  --       "L3MON4D3/LuaSnip",
  --       dependencies = "rafamadriz/friendly-snippets",
  --       opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  --       config = function(_, opts)
  --         require("luasnip").config.set_config(opts)
  --         -- vscode format
  --         require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
  --         require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
  --
  --         -- snipmate format
  --         require("luasnip.loaders.from_snipmate").load()
  --         require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
  --
  --         -- lua format
  --         require("luasnip.loaders.from_lua").load()
  --         require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
  --
  --         vim.api.nvim_create_autocmd("InsertLeave", {
  --           callback = function()
  --             if
  --               require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
  --               and not require("luasnip").session.jump_active
  --             then
  --               require("luasnip").unlink_current()
  --             end
  --           end,
  --         })
  --       end,
  --     },
  --
  --     -- autopairing of (){}[] etc
  --     {
  --       "windwp/nvim-autopairs",
  --       opts = {
  --         fast_wrap = {},
  --         disable_filetype = { "TelescopePrompt", "vim" },
  --       },
  --       config = function(_, opts)
  --         require("nvim-autopairs").setup(opts)
  --
  --         -- setup cmp for autopairs
  --         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  --         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --       end,
  --     },
  --
  --     -- cmp sources plugins
  --     {
  --       "saadparwaiz1/cmp_luasnip",
  --       "hrsh7th/cmp-nvim-lua",
  --       "hrsh7th/cmp-nvim-lsp",
  --       "hrsh7th/cmp-buffer",
  --       "hrsh7th/cmp-path",
  --     },
  --   },
  --   opts = function()
  --     local cmp = require "cmp"
  --
  --     return {
  --       completion = {
  --         completeopt = "menu,menuone",
  --       },
  --
  --       snippet = {
  --         expand = function(args)
  --           require("luasnip").lsp_expand(args.body)
  --         end,
  --       },
  --       formatting = {
  --         format = function(entry, vim_item)
  --           if vim.tbl_contains({ "path" }, entry.source.name) then
  --             local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
  --             if icon then
  --               vim_item.kind = icon
  --               vim_item.kind_hl_group = hl_group
  --               return vim_item
  --             end
  --           end
  --
  --           return require("lspkind").cmp_format {}(entry, vim_item)
  --         end,
  --       },
  --
  --       mapping = {
  --         ["<C-p>"] = cmp.mapping.select_prev_item(),
  --         ["<C-n>"] = cmp.mapping.select_next_item(),
  --         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.close(),
  --
  --         ["<CR>"] = cmp.mapping.confirm {
  --           behavior = cmp.ConfirmBehavior.Insert,
  --           select = true,
  --         },
  --
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif require("luasnip").expand_or_jumpable() then
  --             require("luasnip").expand_or_jump()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif require("luasnip").jumpable(-1) then
  --             require("luasnip").jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --       },
  --       sources = {
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "buffer" },
  --         { name = "nvim_lua" },
  --         { name = "path" },
  --         { name = "copilot" },
  --       },
  --     }
  --   end,
  -- },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      floating_window = false,
      hint_enable = false,
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
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
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
