return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false

    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map('n', '<D-;>', '<Cmd>BufferPrevious<CR>', opts)
    map('n', "<D-'>", '<Cmd>BufferNext<CR>', opts)
    -- Re-order to previous/next
    -- map('n', '<D-<>', '<Cmd>BufferMovePrevious<CR>', opts)
    -- map('n', '<D->>', '<Cmd>BufferMoveNext<CR>', opts)
    -- Goto buffer in position...
    -- map('n', '<D-1>', '<Cmd>BufferGoto 1<CR>', opts)
    -- map('n', '<D-2>', '<Cmd>BufferGoto 2<CR>', opts)
    -- map('n', '<D-3>', '<Cmd>BufferGoto 3<CR>', opts)
    -- map('n', '<D-4>', '<Cmd>BufferGoto 4<CR>', opts)
    -- map('n', '<D-5>', '<Cmd>BufferGoto 5<CR>', opts)
    -- map('n', '<D-6>', '<Cmd>BufferGoto 6<CR>', opts)
    -- map('n', '<D-7>', '<Cmd>BufferGoto 7<CR>', opts)
    -- map('n', '<D-8>', '<Cmd>BufferGoto 8<CR>', opts)
    -- map('n', '<D-9>', '<Cmd>BufferGoto 9<CR>', opts)
    -- map('n', '<D-0>', '<Cmd>BufferLast<CR>', opts)
    -- Pin/unpin buffer
    -- map('n', '<D-p>', '<Cmd>BufferPin<CR>', opts)
    -- -- Close buffer
    map('n', '<D-c>', '<Cmd>BufferClose<CR>', opts)
    -- Wipeout buffer
    --                 :BufferWipeout
    -- Close commands
    --                 :BufferCloseAllButCurrent
    --                 :BufferCloseAllButPinned
    --                 :BufferCloseAllButCurrentOrPinned
    --                 :BufferCloseBuffersLeft
    --                 :BufferCloseBuffersRight
    -- Magic buffer-picking mode
    map('n', '<D-p>', '<Cmd>BufferPick<CR>', opts)
    -- Sort automatically by...
    map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
    map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
    map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
    map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
    map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

    -- Other:
    -- :BarbarEnable - enables barbar (enabled by default)
    -- :BarbarDisable - very bad command, should never be used
  end,
  opts = {
    icons = {
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = true },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      gitsigns = {
        added = { enabled = true },
        changed = { enabled = true },
        deleted = { enabled = true },
      },
    }
  },
  -- version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
