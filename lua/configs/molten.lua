local map = vim.keymap.set


-- these are examples, not defaults. Please see the readme
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_win_max_height = 20

--- Notebook setup
---
-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = false

-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = true

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
-- vim.g.molten_virt_lines_off_by_1 = true
-- vim.g.molten_cover_empty_lines = true
-- vim.g.molten_comment_string = "# %%"
-- vim.g.molten_auto_image_popup = true
-- vim.g.molten_show_mimetype_debug = true
-- vim.g.molten_auto_open_output = false
-- vim.g.molten_output_show_more = true
-- vim.g.molten_output_win_border = { "", "━", "", "" }
-- vim.g.molten_output_win_max_height = 12
-- vim.g.molten_output_virt_lines = true
-- vim.g.molten_virt_text_output = true
-- vim.g.molten_use_border_highlights = true
-- vim.g.molten_virt_lines_off_by_1 = true
-- vim.g.molten_wrap_output = true
-- vim.g.molten_tick_rate = 142


----- Key Maps
map("n", "<leader>mi", ":MoltenInit<CR>",
  { silent = true, desc = "Initialize the plugin" })
map("n", "<localleader>mI", ":MoltenInit rust<CR>",
  { silent = true, desc = "Initialize the plugin with rust" })


map("n", "<leader>me", ":MoltenEvaluateOperator<CR>",
  { silent = true, desc = "run operator selection" })
map("n", "<leader>ml", ":MoltenEvaluateLine<CR>",
  { silent = true, desc = "evaluate line" })
map("n", "<leader>mr", ":MoltenReevaluateCell<CR>",
  { silent = true, desc = "re-evaluate cell" })
map("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv",
  { silent = true, desc = "evaluate visual selection" })
map("n", "<leader>mD", ":MoltenDelete<CR>",
  { silent = true, desc = "molten delete cell" })
map("n", "<leader>mh", ":MoltenHideOutput<CR>",
  { silent = true, desc = "hide output" })
map("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>",
  { silent = true, desc = "show/enter output" })
