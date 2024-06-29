return {
  'neoclide/coc.nvim',
  branch = 'release',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
  { "<leader>tv", "<cmd>CocCommand tsserver.chooseVersion<cr>", desc = "Choose tsserver version"},
  },
  config = function()
    vim.g.coc_global_extensions={'coc-tsserver', 'coc-json', 'coc-eslint', 'coc-snippets'}
    vim.g.coc_user_config = {
      ['eslint.autoFixOnSave'] = true,
      ['diagnostic.displayByAle'] = true,
    }
    vim.cmd [[ source ~/coc.nvim/doc/coc-example-config.vim ]]
  end
}
