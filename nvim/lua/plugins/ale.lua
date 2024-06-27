return {
  'dense-analysis/ale',
  config = function()
    vim.g.ale_sign_column_always = 1
    vim.o.signcolumn = 'yes'

    vim.cmd [[
      sign define DiagnosticSignError text= texthl=DiagnosticSignError
      sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
      sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
      sign define DiagnosticSignHint text= texthl=DiagnosticSignHint
    ]]

  end,
}
