require "nvchad.options"

-- add yours here!
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.g.python3_host_prog = "/Users/sriram/.pyenv/shims/python"

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local enable_providers = {
  "python3_provider",
  -- "node_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

vim.g.loaded_python3_provider = nil
