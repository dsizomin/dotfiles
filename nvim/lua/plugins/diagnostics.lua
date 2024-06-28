return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-web-devicons"
  },
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  init = function()
    vim.o.signcolumn = 'yes'

    vim.cmd [[
      sign define DiagnosticSignError text= texthl=DiagnosticSignError
      sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
      sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
      sign define DiagnosticSignHint text= texthl=DiagnosticSignHint
    ]]
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
}
