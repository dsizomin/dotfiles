return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      ---
      diagnostics = { virtual_text = false, virtual_lines = { current_line = true } },
    },
  },
}
