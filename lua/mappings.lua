require "nvchad.mappings"

local nomap = vim.keymap.del

nomap("n", "<C-n>")

nomap("n", "<leader>b")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<leader>fm")

-- Remove Telescope
nomap("n", "<leader>fw")
nomap("n", "<leader>fb")
nomap("n", "<leader>fh")
nomap("n", "<leader>ma")
nomap("n", "<leader>fo")
nomap("n", "<leader>fz")
nomap("n", "<leader>cm")
nomap("n", "<leader>gt")
nomap("n", "<leader>pt")
nomap("n", "<leader>th")
nomap("n", "<leader>ff")
nomap("n", "<leader>fa")
nomap("n", "<tab>")
nomap("n", "<S-tab>")

-- Remove nvimtree focus
nomap("n", "<leader>e")

-- add yours here
local map = vim.keymap.set

map("n", "<C-tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<C-S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("i", "<C-tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("i", "<C-S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })


local M = {}

M.general = {
  n = {
    ["<leader>wh"] = { "<C-w>h", "Window left" },
    ["<leader>wl"] = { "<C-w>l", "Window right" },
    ["<leader>wj"] = { "<C-w>j", "Window down" },
    ["<leader>wk"] = { "<C-w>k", "Window up" },
    ["<leader>wd"] = { "<C-w>q", "Window kill" },
    ["<leader>wv"] = { "<cmd> vsplit<CR>", "Window split vertical" },
    ["<leader>ws"] = { "<cmd> split <CR>", "Window split horizontal" },
    ["<leader>bN"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>bs"] = { "<cmd> w <CR>", "New buffer" },
    ['<leader>yp'] = { function() vim.fn.setreg('+', vim.fn.expand('%:p:.')) end, desc = 'Yank file path' },
    ['<leader>yd'] = { function() vim.fn.setreg('+', vim.fn.expand('%:h')) end, desc = 'Yank directory path' },
    ['<leader>yf'] = { function() vim.fn.setreg('+', vim.fn.expand('%:t')) end, desc = 'Yank file name' }
  }
}

M.FzfLua = {
  n = {
    -- find
    ["<leader><leader>"] = { "<cmd>FzfLua files<CR>", "Find files" },
    ["<leader>sp"] = { "<cmd> FzfLua live_grep_glob git_icons=false <CR>", "Live grep glob" },
    ["<leader>sn"] = { "<cmd> FzfLua live_grep_native git_icons=false <CR>", "Live grep glob" },
    ["<leader>sw"] = { "<cmd> FzfLua grep_cword <CR>", "grep current word" },
    ["<leader>sW"] = { "<cmd> FzfLua grep_cWORD <CR>", "grep curent WORD" },
    ["<leader><"] = { "<cmd> FzfLua buffers <CR>", "Find buffers" },
    ["<leader>sh"] = { "<cmd> FzfLua helptags <CR>", "Help page" },
    ["<leader>fb"] = { "<cmd> FzfLua buffers <CR>", "Find buffers" },
    ["<leader>fr"] = { "<cmd> FzfLua oldfiles <CR>", "Find oldfiles" },
    ["<leader>fj"] = { "<cmd> FzfLua jumps <CR>", "Find Jumps" },
    ["<leader>fm"] = { "<cmd> FzfLua marks <CR>", "Find marks" },
    ["<leader>ss"] = { "<cmd> FzfLua lgrep_curbuf <CR>", "Find in current buffer" },

    -- git
    ["<leader>gc"] = { "<cmd> FzfLua git_commits <CR>", "Git commits" },
    ["<leader>gs"] = { "<cmd> FzfLua git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>ts"] = { "<cmd> FzfLua terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>st"] = {
      function()
        require("nvchad.themes").open()
      end, "Nvchad themes" },
    ["<leader>sd"] = {
      function()
        local cwd_path = vim.print(vim.fn.expand('%:h'))
        require("fzf-lua").live_grep_glob({ git_icons = false, cwd = cwd_path })
      end, "CWD search" },

    ["<leader>sm"] = { "<cmd> FzfLua marks <CR>", "telescope bookmarks" },

  },
}

M.Gitlinker = {
  n = {
    ["<leader>gY"] = {
      function()
        require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
      end,
      "Open git link for the line",
      opts = { silent = true },
    },
    ["<leader>gy"] = {
      function()
        require("gitlinker").get_buf_range_url()
        -- require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
      end,
      "Copy git link for the line",
      opts = { silent = true },
    },

  },
}

M.NeovimProject = {
  n = {
    ["<leader>pp"] = { "<cmd> NeovimProjectDiscover <CR>","Discover Projects" },
    ["<leader>pr"] = { "<cmd> NeovimProjectLoadRecent <CR>","Load Recent Projects" },
    ["<leader>px"] = { function () require("nvchad.tabufline").closeAllBufs(true) end, "Close all buffers"},
    ["<leader>po"] = { function () require("nvchad.tabufline").closeAllBufs(false) end, "Close other buffers"},
    -- ["<leader>p1"] = { function () require("nvchad.tabufline").closeAllBufs(false) end, "Close other buffers"},
    --   local cwd = vim.fn.getcwd()
    --   vim.opts.
    -- end,"Load Recent Projects" },
  }
}



for _, mappings in pairs(M) do
  -- print("plugin:", plugin)
  for mode, maps in pairs(mappings) do
    for key, val in pairs(maps) do
      -- print(mode)
      -- print(key)
      -- print(val[1])
      -- print(val[2])
      map(mode, key, val[1], { desc = val[2] })
    end
  end
end


-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>;", "<cmd> NvimTreeToggle <CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>.", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

map("n", "<leader>bf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })
