return {
  'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      icons = {
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = {enabled = true},
          [vim.diagnostic.severity.WARN] = {enabled = true},
          [vim.diagnostic.severity.INFO] = {enabled = true},
          [vim.diagnostic.severity.HINT] = {enabled = true},
        },
        gitsigns = {
          added = {enabled = true},
          changed = {enabled = true},
          deleted = {enabled = true},
        },
      }
    },
    -- version = '^1.0.0', -- optional: only update when a new 1.x version is released
  }

