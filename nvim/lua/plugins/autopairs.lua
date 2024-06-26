return {
  'windwp/nvim-autopairs',
  lazy = false,
  config = function()
    require('nvim-autopairs').setup({
      map_cr = false
    })
  end,
}
