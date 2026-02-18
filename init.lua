vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- Fix NvChad tabufline + fzf-lua race condition:
-- fzf-lua's hide profile may wipe a temporary buffer before NvChad's
-- BufAdd handler runs, causing "Invalid buffer id" errors at lazyload.lua:36:
--   nvim_buf_get_name(bufs[1])  → patched to return ""
--   nvim_get_option_value("modified", {buf=bufs[1]}) → patched to return false
local _orig_buf_get_name = vim.api.nvim_buf_get_name
vim.api.nvim_buf_get_name = function(buf)
  if buf ~= 0 and not vim.api.nvim_buf_is_valid(buf) then
    return ""
  end
  return _orig_buf_get_name(buf)
end

local _orig_get_option_value = vim.api.nvim_get_option_value
vim.api.nvim_get_option_value = function(name, opts)
  if opts and opts.buf and opts.buf ~= 0 and not vim.api.nvim_buf_is_valid(opts.buf) then
    return false
  end
  return _orig_get_option_value(name, opts)
end
vim.g.maplocalleader = " "
vim.opt.relativenumber = true
vim.o.guifont = "JetBrainsMono Nerd Font:h16:#h-slight" -- Source Code Pro:h12:#h-slight
vim.o.cmdheight = 0
-- vim.env.PYENV_VERSION = vim.fn.system('pyenv version'):match('(%S+)%s+%(.-%)')
-- vim.opt.inccommand = "split"
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_command "autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi,*.fsl,*.fsy set filetype=fsharp"
vim.g.neotest_log_level = 1
if vim.g.neovide then
  -- Allow clipboard copy paste in neovim
  vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<D-v>", function()
    vim.api.nvim_paste(vim.fn.getreg "+", true, -1)
  end, { noremap = true, silent = true })

  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00

  local home_dir = vim.fn.expand "~"
  vim.cmd("cd " .. home_dir)
end
