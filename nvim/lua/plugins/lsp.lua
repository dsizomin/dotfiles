local cwd = vim.fn.getcwd()
local isWebCode = cwd:match("web%-code")
local lsputils = require("lspconfig.util")
local root_dir = lsputils.root_pattern(".yarn")(cwd)

return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type lspconfig.options
    servers = {
      -- tsserver will be automatically installed with mason and loaded with lspconfig
      -- tsserver = {},
      marksman = {},
      graphql = {},
      dockerls = {},
      docker_compose_language_service = {},
      bashls = {},

      eslint = {
        workingDirectory = { mode = "auto" },
        settings = isWebCode and {
          nodePath = root_dir .. "/.yarn/sdks",
        } or {},
      },

      vtsls = {
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
      },
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      -- require("typescript").setup({ server = opts })
      -- return true
      -- end,

      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
    },
  },
}
