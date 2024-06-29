return {
  'sindrets/diffview.nvim',
  lazy = true,
  keys = {
    {
      '<leader>dv',
      '<cmd>DiffviewOpen<cr>',
    },
    {
      '<leader>dc',
      '<cmd>DiffviewClose<cr>',
    },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
}
