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
  Plug('github/copilot.vim')
  Plug('sindrets/diffview.nvim')
vim.call('plug#end')

vim.g.coc_global_extensions={'coc-tsserver', 'coc-json', 'coc-eslint', 'coc-snippets'}
vim.g.coc_user_config = {
  ['eslint.autoFixOnSave'] = true
}

vim.cmd [[ source ~/coc.nvim/doc/coc-example-config.vim ]]
vim.cmd [[ colorscheme dracula ]]

require("ibl").setup()

require('nvim-autopairs').setup({
  map_cr = false
})

require("barbar").setup()

require('lualine').setup {
  options = {
    theme = 'dracula'
  }
}

require('gitsigns').setup()
local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too

require('nvim-tree').setup({
  update_focused_file = {
    enable = true
  },
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "tsx" },
  auto_install = true,
  highlight = {
   enable = true,
  }
})

require('Comment').setup()

require("diffview").setup()

vim.cmd [[
  " Find files using Telescope command-line sugar.
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>

  nnoremap <leader>nt <cmd>NvimTreeToggle<cr>
]]

