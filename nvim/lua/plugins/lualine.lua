return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    "Mofiqul/dracula.nvim"
  },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'dracula-nvim'
      }
    }
  end,
}
