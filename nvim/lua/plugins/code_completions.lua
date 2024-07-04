return {
	"hrsh7th/nvim-cmp",
	-- load cmp on InsertEnter
	-- lazy = true,
	-- event = "InsertEnter",
	-- these dependencies will only be loaded when cmp loads
	-- dependencies are always lazy-loaded unless specified otherwise
	dependencies = {
		-- sources:
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"zbirenbaum/copilot-cmp",
		-- cmp:
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		-- snippets:
		"onsails/lspkind.nvim",
		"saadparwaiz1/cmp_luasnip",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
		"windwp/nvim-autopairs",
	},
	config = function()
		-- Set up nvim-cmp.
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					symbol_map = { Copilot = "" },
					-- mode = 'symbol', -- show only symbol annotations
					-- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- can also be a function to dynamically calculate max width such as
					-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
					-- ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					-- show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					-- before = function (entry, vim_item)
					-- ...
					-- return vim_item
					-- end
				}),
			},
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				-- { name = 'vsnip' }, -- For vsnip users.
				{ name = "luasnip" }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
				{ name = "copilot" },
			}, {
				{ name = "buffer" },
			}),
		})

		require("nvim-autopairs").setup({})
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
