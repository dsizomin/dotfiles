vim.cmd [[
  set nocompatible            " disable compatibility to old-time vi
  set showmatch               " show matching 
  set ignorecase              " case insensitive 
  set mouse=v                 " middle-click paste with 
  set hlsearch                " highlight search 
  set incsearch               " incremental search
  set tabstop=2               " number of columns occupied by a tab 
  set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
  set expandtab               " converts tabs to white space
  set shiftwidth=2            " width for autoindents
  set autoindent              " indent a new line the same amount as the line just typed
  set number                  " add line numbers
  set wildmode=longest,list   " get bash-like tab completions
  filetype plugin indent on   " allow auto-indenting depending on file type
  syntax on                   " syntax highlighting
  set mouse=a                 " enable mouse click
  set clipboard=unnamedplus   " using system clipboard
  filetype plugin on
  set ttyfast                 " Speed up scrolling in Vim
]]

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local Plug = vim.fn['plug#']
vim.call('plug#begin')
  Plug('dracula/vim')
  Plug('windwp/nvim-autopairs')
  Plug('lukas-reineke/indent-blankline.nvim')
  Plug('neoclide/coc.nvim', { branch = 'release' })
  Plug('nvim-tree/nvim-web-devicons')
  Plug('nvim-tree/nvim-tree.lua')
  Plug('lewis6991/gitsigns.nvim')
  Plug('romgrk/barbar.nvim')
  Plug('nvim-lua/plenary.nvim')
  Plug('nvim-telescope/telescope.nvim')
  Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
  Plug('nvim-lualine/lualine.nvim')
  Plug('numToStr/Comment.nvim')
vim.call('plug#end')

vim.g.coc_global_extensions={'coc-tsserver', 'coc-json', 'coc-eslint'}
vim.g.coc_user_config = {
  ['eslint.autoFixOnSave'] = true
}

vim.cmd [[ source ~/coc.nvim/doc/coc-example-config.vim ]]
vim.cmd [[ colorscheme dracula ]]

require("ibl").setup()

require('nvim-autopairs').setup({
  map_cr = false
})

require("barbar").setup({
  sidebar_filetypes = {
    NvimTree = true,
  },
  view = {
    width = 60
  }
})

require('lualine').setup {
  options = {
    theme = 'dracula'
  }
}

require('gitsigns').setup()

require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  },
  view = {
    width = 60
  }
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "tsx" },
  auto_install = true,
  highlight = {
   enable = true,
  }
})

require('Comment').setup()

vim.cmd [[
  " Find files using Telescope command-line sugar.
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
]]

