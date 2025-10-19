local lsputils = require("lspconfig.util")
local cwd = vim.fn.getcwd()
local root_dir = lsputils.root_pattern(".git")(cwd)

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      ---
      diagnostics = { virtual_text = false, virtual_lines = { current_line = true } },
      servers = {

        eslint = {
          settings = vim.g.is_web_code and {
            workingDirectory = { mode = "auto" },
            nodePath = root_dir .. "/.yarn/sdks",
            experimental = {
              useFlatConfig = true,
            },
          } or {},
        },

        vtsls = {
          init_options = {
            hostInfo = "neovim",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              typescript = vim.g.is_web_code and {
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
                autoImports = not vim.g.is_web_code,
              },
              inlayHints = (not vim.g.is_web_code) and {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              } or {},
              tsserver = {
                maxTsServerMemory = vim.g.is_web_code and 10240 or 2048,
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        vtsls = function(_, _opts)
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "vtsls" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        -- require("typescript").setup({ server = opts })
        -- return true
        -- end,

        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
