-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local CursorLineHighlight = {  bg = "#44475A" }

M.ui = {
  theme = "chadracula",

  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLine = CursorLineHighlight,
    CursorLineNr = CursorLineHighlight,
    TelescopeSelection = CursorLineHighlight,
  },
  statusline = {
    theme = "minimal",
  },
  nvdash = {
    load_on_startup = true,
  }
}

return M
