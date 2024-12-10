local alpha = require("alpha")
-- local startify = require'alpha.themes.startify'
-- local dashboard = require'alpha.themes.dashboard'
-- local theta = require'alpha.themes.theta'

-- alpha.setup(dashboard.config)
-- alpha.setup(theta.config)

----- NEW
---
local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
  [[                                                                       ]],
}
dashboard.section.header.opts.hl = "DashboardHeader"
dashboard.config.layout[1].val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }
dashboard.config.layout[3].val = 3
dashboard.config.opts.noautocmd = true
dashboard.section.buttons.val = {
  dashboard.button("SPC p p", "󰝰  Open Project"),
  dashboard.button("SPC p r", "󰈸  Recent Project"),
  dashboard.button("SPC p a", "  Add Project"),
  dashboard.button("SPC f r", "  Recently opened files"),
  dashboard.button("SPC s p", "󰍉  Search in Project"),
  dashboard.button("SPC SPC", "󰈞  Find file"),
  dashboard.button("SPC f j", "  Goto Jumps"),
  dashboard.button("SPC s s", "  Run Swiper"),
}

require("alpha").setup(dashboard.config)

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "LazyVimStarted",
  desc = "Add Alpha dashboard footer",
  once = true,
  callback = function()
    local stats = require("lazy").stats()
    local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
    dashboard.section.footer.val = {
      "   Have Fun with NvChad"
        .. "  󰀨 v"
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. "  ⚡NvChad loaded "
        .. stats.count
        .. " plugins  in "
        .. ms
        .. "ms",
    }
    dashboard.section.footer.opts.hl = "DashboardFooter"
    pcall(vim.cmd.AlphaRedraw)
  end,
})
alpha.setup(dashboard.config)

