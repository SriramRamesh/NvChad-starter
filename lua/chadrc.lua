-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
local options = {

  base46 = {
    theme = "chadracula-evondev", -- default theme
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

      -- Use this for ignoring the warning in vscode
      -- NotifyBackground = { fg = "#ced6e3", bg = "#011627" },
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
    changed_themes = {},
    transparency = false,
    theme_toggle = { "onedark", "one_light" },
  },

  ui = {
    cmp = {
      icons = true,
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    statusline = {
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
    },

    nvdash = {
      load_on_startup = false,

      header = {
        "           ▄ ▄                   ",
        "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
        "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
        "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
        "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
        "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
        "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
        "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
        "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
      },

      buttons = {
        { "  Find File", "Spc f f", "Telescope find_files" },
        { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
        { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
        { "  Bookmarks", "Spc m a", "Telescope marks" },
        { "  Themes", "Spc t h", "Telescope themes" },
        { "  Mappings", "Spc c h", "NvCheatsheet" },
      },
    },
  },

  term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  lsp = { signature = true },

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = { cmd = true, pkgs = {} },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
