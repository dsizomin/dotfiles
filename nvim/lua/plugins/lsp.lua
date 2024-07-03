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
		"neovim/nvim-lspconfig",

		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local cwd = vim.fn.getcwd()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			if cwd:match("web%-code") then
				local lsputils = require("lspconfig.util")
				local root_dir = lsputils.root_pattern(".yarn")
				lspconfig.tsserver.setup({
					capabilities = capabilities,
					init_options = {
						maxTsServerMemory = 8192,
						tsserver = {
							path = root_dir(cwd) .. "/.yarn/sdks/typescript/lib/tsserver.js",
						},
					},
				})
				lspconfig.eslint.setup({
					capabilities = capabilities,
					workingDirectory = { mode = "auto" },
					settings = {
						nodePath = root_dir(cwd) .. "/.yarn/sdks",
					},
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				})
			else
				lspconfig.tsserver.setup({
					capabilities = capabilities,
				})
				lspconfig.eslint.setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				})
			end
		end,
	},
}
