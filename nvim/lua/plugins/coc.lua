return {
  'neoclide/coc.nvim',
  branch = 'release',
  config = function()
    vim.g.coc_global_extensions={'coc-tsserver', 'coc-json', 'coc-eslint', 'coc-snippets'}
    vim.g.coc_user_config = {
      ['eslint.autoFixOnSave'] = true
    }
    vim.cmd [[ source ~/coc.nvim/doc/coc-example-config.vim ]]
  end
} 