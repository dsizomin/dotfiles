-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local coq = require "coq"

local lspconfig = require "lspconfig"
local servers = { "marksman" }

local cwd = vim.fn.getcwd()
local lsputils = require "lspconfig.util"
local root_dir = lsputils.root_pattern ".yarn"(cwd)

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

-- typescript
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities(cwd:match "web%-code" and {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    maxTsServerMemory = 8192,
    tsserver = {
      path = root_dir .. "/.yarn/sdks/typescript/lib/tsserver.js",
    },
  },
} or {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}))

-- eslint
lspconfig.eslint.setup(coq.lsp_ensure_capabilities(cwd:match "web%-code" and {
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
}))
