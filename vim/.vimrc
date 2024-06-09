syntax on
set mouse=a
set tabstop=2
set number

if v:version < 802
  packadd! dracula
endif
colorscheme dracula

if v:version >= 900
  let g:coc_global_extensions = ['coc-tsserver']
  source ~/coc.nvim/doc/coc-example-config.vim
endif

