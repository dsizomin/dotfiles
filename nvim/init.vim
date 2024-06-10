set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim

call plug#begin()
 Plug 'dracula/vim'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'nvim-tree/nvim-web-devicons'
 Plug 'nvim-tree/nvim-tree.lua'
 Plug 'romgrk/barbar.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

let g:coc_global_extensions = ['coc-tsserver']
source ~/coc.nvim/doc/coc-example-config.vim

colorscheme dracula

lua require'nvim-tree'.setup {}

lua require'nvim-treesitter.configs'.setup {
 \ ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "tsx" },
 \ auto_install = true,
 \ highlight = {
 \  enable = true,
 \ }
\ }

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
