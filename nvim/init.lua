vim.cmd([[
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
]])

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.diagnostic.config({
  severity_sort = true,
})

vim.cmd([[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint
]])

require("config.lazy")
