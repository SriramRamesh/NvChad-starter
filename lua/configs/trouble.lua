local trouble = require "trouble"

trouble.setup {
  focus = false,
  keys = {
    ["<tab>"] = "fold_toggle",
  },
  -- preview = {
  --   type = "split",
  --   relative = "win",
  --   position = "right",
  --   size = 0.3,
  -- },
  preview = {
    type = "float",
    relative = "editor",
    border = "rounded",
    title = "Preview",
    title_pos = "center",
    position = "center",
    size = { width = 0.5, height = 0.5 },
    zindex = 200,
  },
}
