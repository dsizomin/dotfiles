return {
	{
		"nvimdev/lspsaga.nvim",
		lazy = true,
		event = "BufEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		config = function()
			require("lspsaga").setup({
				ui = {
					code_action = "",
				},
			})
		end,
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
			},
		},
	},
	{
		"folke/trouble.nvim",
		lazy = true,
		event = "BufEnter",
		dependencies = {
			"nvim-web-devicons",
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		init = function()
			vim.o.signcolumn = "yes"

			vim.cmd([[
      sign define DiagnosticSignError text= texthl=DiagnosticSignError
      sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
      sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
      sign define DiagnosticSignHint text= texthl=DiagnosticSignHint
    ]])
		end,
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
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
