-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "ayu_dark",

  hl_override = {
    -- this will use the black color from nvchad theme & lighten it by 2x
    -- use a negative number to darken it
    Visual = {
      bg = {"one_bg3", 2}
    },
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- MyHighlightGroup = { -- custom highlights are also allowed
    --   fg = "red",
    --   bg = "darker_black"
    -- }
  },
}

return M
