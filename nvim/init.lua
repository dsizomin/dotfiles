require "config.options"
require "config.lazy"

vim.schedule(function()
  require "config.mappings"
  require "config.coc"
end)
