return {
  'dense-analysis/ale',
  config = function()
    vim.g.ale_sign_column_always = 1
    vim.o.signcolumn = 'yes'

    vim.g.ale_linters = {
      typescript = {'eslint'},
    }

    vim.g.ale_fixers = {
      ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
      typescript = {'eslint'},
    }

    vim.g.ale_fix_on_save = 1

    vim.cmd [[
      sign define DiagnosticSignError text= texthl=DiagnosticSignError
      sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
      sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
      sign define DiagnosticSignHint text= texthl=DiagnosticSignHint
    ]]

  end,
}
