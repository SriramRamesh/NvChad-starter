-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- theme = "ayu-dark",
  theme = "tokyodark",
  hl_add = {
    CurSearch = {
      bg = "orange",
      fg = "one_bg",
    },
  },
  hl_override = {
    -- this will use the black color from nvchad theme & lighten it by 2x
    -- use a negative number to darken it
    Visual = {
      bg = { "one_bg3", 2 },
    },
    -- IncSearch = {
    --   bg = { "orange", 0}
    -- },
    -- -- CurV
    -- guibg=#ffb86c
    -- highlight CurSearch guibg=orange
    -- Normal = {
    --   bg = { "one_bg3", 1 }
    -- },
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- MyHighlightGroup = { -- custom highlights are also allowed
    --   fg = "red",
    --   bg = "darker_black"
    -- }
    -- LspReferenceWrite = {
    --   -- underline = true,
    --   -- bg = "#5c6370",
    --   bg = "lightbg",
    -- },
    -- LspReferenceText = {
    --   bg = { "one_bg3", 2 },
    -- }
  },
  integrations = { "neogit" },
}

return M
