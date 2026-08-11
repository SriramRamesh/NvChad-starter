require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "<c-v>",
    },
    include_surrounding_whitespace = true,
  },
  move = {
    set_jumps = true,
  },
}

local select = require "nvim-treesitter-textobjects.select"
local move = require "nvim-treesitter-textobjects.move"
local swap = require "nvim-treesitter-textobjects.swap"
local repeatable = require "nvim-treesitter-textobjects.repeatable_move"

local map = vim.keymap.set

-- Selection
map({ "x", "o" }, "af", function()
  select.select_textobject("@function.outer", "textobjects")
end, { desc = "Select around function" })
map({ "x", "o" }, "if", function()
  select.select_textobject("@function.inner", "textobjects")
end, { desc = "Select inside function" })
map({ "x", "o" }, "ac", function()
  select.select_textobject("@class.outer", "textobjects")
end, { desc = "Select around class" })
map({ "x", "o" }, "ic", function()
  select.select_textobject("@class.inner", "textobjects")
end, { desc = "Select inner part of a class region" })
map({ "x", "o" }, "as", function()
  select.select_textobject("@local.scope", "locals")
end, { desc = "Select language scope" })

-- Movement (repeatable with ; / ,)
local next_start = repeatable.make_repeatable_move(move.goto_next_start)
local next_end = repeatable.make_repeatable_move(move.goto_next_end)
local prev_start = repeatable.make_repeatable_move(move.goto_previous_start)
local prev_end = repeatable.make_repeatable_move(move.goto_previous_end)
local goto_next = repeatable.make_repeatable_move(move.goto_next)
local goto_previous = repeatable.make_repeatable_move(move.goto_previous)

map({ "n", "x", "o" }, "]f", function()
  next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })
map({ "n", "x", "o" }, "]F", function()
  next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })
map({ "n", "x", "o" }, "[f", function()
  prev_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })
map({ "n", "x", "o" }, "[F", function()
  prev_end("@function.outer", "textobjects")
end, { desc = "Previous function end" })

map({ "n", "x", "o" }, "]o", function()
  next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Next loop" })

map({ "n", "x", "o" }, "]]", function()
  next_start("@local.scope", "locals")
end, { desc = "Next scope" })
map({ "n", "x", "o" }, "[[", function()
  prev_start("@local.scope", "locals")
end, { desc = "Previous scope" })
map({ "n", "x", "o" }, "][", function()
  next_end("@local.scope", "locals")
end, { desc = "End of scope" })
map({ "n", "x", "o" }, "[]", function()
  prev_end("@local.scope", "locals")
end, { desc = "End of previous scope" })

map({ "n", "x", "o" }, "]z", function()
  next_start("@fold", "folds")
end, { desc = "Next fold" })

map({ "n", "x", "o" }, "]d", function()
  goto_next("@conditional.outer", "textobjects")
end, { desc = "Next conditional" })
map({ "n", "x", "o" }, "[d", function()
  goto_previous("@conditional.outer", "textobjects")
end, { desc = "Previous conditional" })

-- Swap
map("n", "<leader>a", function()
  swap.swap_next "@parameter.inner"
end, { desc = "Swap next parameter" })
map("n", "<leader>A", function()
  swap.swap_previous "@parameter.inner"
end, { desc = "Swap previous parameter" })
