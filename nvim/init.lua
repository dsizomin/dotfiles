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

require('config.lazy')

vim.cmd [[
  hi! link BufferCurrent DraculaFgBold
  hi! link BufferVisible DraculaFgBold

  hi! link BufferVisibleMod DraculaOrangeBold
  hi! link BufferCurrentMod DraculaOrangeBold
  hi! link BufferInactiveMod DraculaOrange
  
  hi! link FoldColumn DraculaBoundary
  hi! link MoreMsg DraculaCyan
]]

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function setup_lsp(preset)
  local lspconfig = require('lspconfig')

  require('mason-lspconfig').setup {
    automatic_installation = true,
  }

  require('lspsaga').setup({})

  if preset == 'ts' then
    lspconfig.tsserver.setup {
      capabilities = capabilities,
    }
  elseif preset =='ts:uber-web' then
    lspconfig.tsserver.setup {
      capabilities = capabilities,
      tsserver = {
        path = (vim.fn.getcwd()..'/.yarn/sdks/typescript/lib')
      }
    }
  elseif preset == 'lua' then
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
    }
  end

end

vim.api.nvim_create_user_command('Lingo', function (opts)
  local preset = opts.fargs[1]
    setup_lsp(preset)
  end, {
  nargs = 1,
})

local cwd = vim.fn.getcwd()
if cwd:match('dotfiles') then
  setup_lsp('lua')
elseif cwd:match('web%-code') then
  setup_lsp('ts:uber-web')
end

