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

map("n", "<A-}>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<A-{>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("i", "<C-tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("i", "<C-S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

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
    ["yf"] = { ":%y+<CR>", "Copy entire file to clipboard" },
    ["<leader>yp"] = {
      function()
        vim.fn.setreg("+", vim.fn.expand "%:p:.")
      end,
      desc = "Yank file path",
    },
    ["<leader>yd"] = {
      function()
        vim.fn.setreg("+", vim.fn.expand "%:h")
      end,
      desc = "Yank directory path",
    },
    ["<leader>yf"] = {
      function()
        vim.fn.setreg("+", vim.fn.expand "%:t")
      end,
      desc = "Yank file name",
    },
    ["<leader>th"] = {
      function()
        require("nvchad.themes").open()
      end,
      desc = "Theme switcher",
    },
    ["<leader>jq"] = { "<cmd>%! jq .<CR>", desc = "JQ formatter" },
  },
}

M.Twilight = {
  n = {
    ["<leader>T"] = {
      function()
        require("twilight").toggle()
      end,
      desc = "twilight toggle",
    },
  },
}

M.diagnostic = {
  n = {
    ["<leader>De"] = {
      ":lua vim.diagnostic.enable(true, { bufnr = 0 })<CR>",
      "Enable diagnostic messages in this file",
    },
    ["<leader>Dd"] = {
      ":lua vim.diagnostic.enable(false, { bufnr = 0 })<CR>",
      "Disable diagnostic messages in this file",
    },
  },
}

M.dap = {
  n = {
    ["<leader>du"] = {
      function()
        require("dapui").toggle {}
      end,
      desc = "[d]ap [u]i",
    },
    ["<leader>de"] = {
      function()
        require("dapui").eval()
      end,
      desc = "[d]ap [e]val",
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "toggle [d]ebug [b]reakpoint",
    },
    ["<leader>dB"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      desc = "[d]ebug [B]reakpoint",
    },
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      desc = "[d]ebug [c]ontinue (start here)",
    },
    ["<leader>dC"] = {
      function()
        require("dap").run_to_cursor()
      end,
      desc = "[d]ebug [C]ursor",
    },
    ["<leader>dg"] = {
      function()
        require("dap").goto_()
      end,
      desc = "[d]ebug [g]o to line",
    },
    ["<leader>do"] = {
      function()
        require("dap").step_over()
      end,
      desc = "[d]ebug step [o]ver",
    },
    ["<leader>dO"] = {
      function()
        require("dap").step_out()
      end,
      desc = "[d]ebug step [O]ut",
    },
    ["<leader>di"] = {
      function()
        require("dap").step_into()
      end,
      desc = "[d]ebug [i]nto",
    },
    ["<leader>dj"] = {
      function()
        require("dap").down()
      end,
      desc = "[d]ebug [j]ump down",
    },
    ["<leader>dk"] = {
      function()
        require("dap").up()
      end,
      desc = "[d]ebug [k]ump up",
    },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      desc = "[d]ebug [l]ast",
    },
    ["<leader>dp"] = {
      function()
        require("dap").pause()
      end,
      desc = "[d]ebug [p]ause",
    },
    ["<leader>dr"] = {
      function()
        require("dap").repl.toggle()
      end,
      desc = "[d]ebug [r]epl",
    },
    ["<leader>dR"] = {
      function()
        require("dap").clear_breakpoints()
      end,
      desc = "[d]ebug [R]emove breakpoints",
    },
    ["<leader>ds"] = {
      function()
        require("dap").session()
      end,
      desc = "[d]ebug [s]ession",
    },
    ["<leader>dt"] = {
      function()
        require("dap").terminate()
      end,
      desc = "[d]ebug [t]erminate",
    },
    ["<leader>dw"] = {
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "[d]ebug [w]idgets",
    },
  },
}

M.NvimTreesitterContext = {
  n = {
    ["[c"] = {
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end,
      "Jump to context",
    },
    ["[t"] = {
      "<cmd>TSContext toggle<CR>",
      "Toggle TSContext",
    },
  },
}

M.Neotest = {
  n = {
    ["<leader>ta"] = {
      function()
        require("neotest").run.attach()
      end,
      "[t]est [a]ttach",
    },
    ["<leader>tf"] = {
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      "[t]est run [f]ile",
    },
    ["<leader>tA"] = {
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      "[t]est [A]ll files",
    },
    ["<leader>tS"] = {
      function()
        require("neotest").run.run { suite = true }
      end,
      "[t]est [S]uite",
    },
    ["<leader>tn"] = {
      function()
        require("neotest").run.run()
      end,
      "[t]est [n]earest",
    },
    ["<leader>tl"] = {
      function()
        require("neotest").run.run_last()
      end,
      "[t]est [l]ast",
    },
    ["<leader>ts"] = {
      function()
        require("neotest").summary.toggle()
      end,
      "[t]est [s]ummary",
    },
    ["<leader>to"] = {
      function()
        require("neotest").output.open { enter = true, auto_close = true }
      end,
      "[t]est [o]utput",
    },
    ["<leader>tO"] = {
      function()
        require("neotest").output_panel.toggle()
      end,
      "[t]est [O]utput panel",
    },
    ["<leader>tt"] = {
      function()
        require("neotest").run.stop()
      end,
      "[t]est [t]erminate",
    },
    ["<leader>td"] = {
      function()
        require("neotest").run.run { suite = false, strategy = "dap" }
      end,
      "Debug nearest test",
    },
    ["<leader>tD"] = {
      function()
        require("neotest").run.run { vim.fn.expand "%", strategy = "dap" }
      end,
      "Debug current file",
    },
  },
}

-- User command to run selected Lua code in visual mode
vim.api.nvim_create_user_command("RunLuaRegion", function()
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  local lines = vim.fn.getline(start_line, end_line)
  local code = table.concat(lines, "\n")
  load(code)()
end, { range = true })

M.lua = {
  n = {
    ["<leader>lx"] = { ":luafile %<CR>", "Run the file" },
  },
  v = {
    ["<leader>lx"] = { ":RunLuaRegion<CR>", "Run the region" },
  },
}

M.FzfLua = {
  n = {
    -- find
    ["<leader><leader>"] = { "<cmd>FzfLua files<CR>", "Find files" },
    ["<leader>sp"] = { "<cmd> FzfLua live_grep_glob git_icons=false <CR>", "Live grep glob" },
    ["<leader>fp"] = {
      function()
        require("fzf-lua").files { cwd = vim.fn.stdpath "config" }
      end,
      "Find files in config directory",
    },
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
      end,
      "Nvchad themes",
    },
    ["<leader>sd"] = {
      function()
        local cwd_path = vim.print(vim.fn.expand "%:h")
        require("fzf-lua").live_grep_glob { git_icons = false, cwd = cwd_path }
      end,
      "CWD search",
    },

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
    -- ["<leader>pp"] = { "<cmd> NeovimProjectDiscover <CR>", "Discover Projects" },
    -- ["<leader>pr"] = { "<cmd> NeovimProjectLoadRecent <CR>", "Load Recent Projects" },
    ["<leader>px"] = {
      function()
        require("nvchad.tabufline").closeAllBufs(true)
      end,
      "Close all buffers",
    },
    ["<leader>po"] = {
      function()
        require("nvchad.tabufline").closeAllBufs(false)
      end,
      "Close other buffers",
    },
    -- ["<leader>p1"] = { function () require("nvchad.tabufline").closeAllBufs(false) end, "Close other buffers"},
    --   local cwd = vim.fn.getcwd()
    --   vim.opts.
    -- end,"Load Recent Projects" },
  },
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

M.conform = {
  n = {
    ["<leader>bd"] = { ":FormatDisable<CR>", "Disable Formatter" },
    ["<leader>be"] = { ":FormatEnable<CR>", "Enable Formatter" },
  },
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

map("n", "<leader>W", function()
  vim.b.disable_autoformat = true
  vim.cmd "write"
  vim.defer_fn(function()
    vim.b.disable_autoformat = false
  end, 0)
end, { desc = "Write without autoformatting (one-time)" })
-- Lua
-- map("n", "s", require("substitute").operator, {desc = "substitute operator"})
-- map("n", "ss", require("substitute").line, {desc = "substitute line"})
-- map("n", "S", require("substitute").eol, {desc = "substitute eol"})
-- map("x", "s", require("substitute").visual, {desc = "substitute visual"})
map("n", "gx", require("substitute.exchange").operator, { desc = "substitute.exchange operator" })
map("n", "gX", require("substitute.exchange").line, { desc = "substitute.exchange line" })
map("x", "gx", require("substitute.exchange").visual, { desc = "substitute.exchange visual" })

map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>;", "<cmd> NvimTreeToggle <CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>.", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Auto-format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*", -- Apply to all file types; you can customize this with patterns like "*.lua", "*.js", etc.
--   callback = function()
--     require("conform").format { lsp_fallback = true }
--   end,
--   desc = "Auto-format on save with Conform",
-- })

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

-- This repeats the last query with always previous direction and to the start of the range.
map({ "n", "x", "o" }, "<home>", function()
  ts_repeat_move.repeat_last_move { forward = false, start = true }
end)

-- This repeats the last query with always next direction and to the end of the range.
map({ "n", "x", "o" }, "<end>", function()
  ts_repeat_move.repeat_last_move { forward = true, start = false }
end)
-- example: make gitsigns.nvim movement repeatable with ; and , keys.
local gs = require "gitsigns"

-- make sure forward function comes first
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

map({ "n", "x", "o" }, "]h", next_hunk_repeat)
map({ "n", "x", "o" }, "[h", prev_hunk_repeat)
