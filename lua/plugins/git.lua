return {
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup {}
    end,
  },
  { "sindrets/diffview.nvim" },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    config = function()
      -- require "configs.neogit"
      local neogit = require "neogit"
      neogit.setup {}
      dofile(vim.g.base46_cache .. "git")
      dofile(vim.g.base46_cache .. "neogit")
    end,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "LazyGit" },
    },
  },
}
