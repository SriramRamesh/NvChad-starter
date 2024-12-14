local highlight = {
  "White"
}
-- "RainbowViolet",
--   "RainbowBlue",
--   "RainbowCyan",
--   "RainbowGreen",
--   "RainbowYellow",
--   "RainbowOrange",
--   "RainbowRed",
-- }

local hooks = require "ibl.hooks"
-- Register the highlight groups in the highlight setup hook
-- so they are reset every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "White", { fg = "#FFFFFF" })
  --   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

-- Configure ibl with the highlight groups
vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup {
  scope = {
    highlight = highlight,
  },
}

-- Use the built-in scope highlight function
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
