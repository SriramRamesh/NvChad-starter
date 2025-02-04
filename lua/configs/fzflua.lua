local trouble_actions = require("trouble.sources.fzf").actions
local fzf = require "fzf-lua"
local utils = require "utils"
local notify = require "notify"
local target_filepath = vim.fn.stdpath "config" .. "/projects"

local home_dir = vim.fn.expand "~"

local function browse_directory(current_dir, directory_fn)
  -- If the current directory is within the home directory, replace it with '~' for display
  local display_dir = current_dir:gsub("^" .. vim.pesc(home_dir), "~")

  local find_command = string.format(
    "echo '%s' && find '%s' -mindepth 1 -maxdepth 2 -type d ! -name '.*' -print | sed 's|^%s|~|' && echo ..",
    current_dir:gsub("^" .. vim.pesc(home_dir), "~"),
    current_dir,
    vim.pesc(home_dir)
  )
  fzf.fzf_exec(find_command, {
    prompt = "Select a directory (" .. display_dir .. ") > ",
    previewer = false, -- Hide the preview window
    cwd = current_dir, -- Start fzf in the current directory
    actions = {
      ["default"] = function(selected)
        -- Ensure selected is a table (list of selections)
        if type(selected) == "string" then
          selected = { selected }
        end

        -- Handle the selected directory
        for _, path in ipairs(selected) do
          if path == ".." then
            -- Go up one level and re-run the browse function
            local parent_dir = vim.fn.fnamemodify(current_dir, ":h")
            browse_directory(parent_dir, directory_fn)
            return
          end
          -- Ensure the path is absolute
          local abs_path = vim.fn.fnamemodify(path, ":p")

          -- Append the selected path to the file
          directory_fn(abs_path)
        end
      end,
    },
  })
end

local function choose_directory()
  local function directory_fn(abs_path)
    vim.cmd("cd " .. abs_path)
    vim.print("change directory in vim " .. abs_path)
  end
  -- Start browsing from the current working directory
  local current_dir = vim.fn.getcwd()
  browse_directory(current_dir, directory_fn)
end

-- Keybinding to trigger the function
vim.keymap.set("n", "<leader>cd", choose_directory, { desc = "Choose a directory with fzf-lua" })

-- Function to select items from the file and delete the selected ones
local function select_and_delete_items()
  -- Read all lines from the target file
  local lines = utils.read_lines_from_file(target_filepath)
  if #lines == 0 then
    vim.notify("No items found in the file.", vim.log.levels.WARN)
    return
  end

  -- Use fzf-lua to let the user select multiple lines
  fzf.fzf_exec(lines, {
    prompt = "Select items to delete > ",
    actions = {
      ["default"] = function(selected_items)
        -- Remove trailing commas from selected items
        for i, item in ipairs(selected_items) do
          selected_items[i] = utils.remove_trailing_comma(item)
        end

        -- Create a set of selected items for quick lookup
        local selected_set = {}
        for _, item in ipairs(selected_items) do
          selected_set[item] = true
        end

        -- Filter out the selected items
        local new_lines = {}
        local deleted_items = {}
        for _, line in ipairs(lines) do
          local cleaned_line = utils.remove_trailing_comma(line)
          if selected_set[cleaned_line] then
            table.insert(deleted_items, cleaned_line)
          else
            table.insert(new_lines, line)
          end
        end

        -- Write the updated lines back to the file
        utils.write_lines_to_file(target_filepath, new_lines)

        -- Show notification with the deleted directories
        if #deleted_items == 1 then
          local message = "Deleted directories: " .. tostring(deleted_items[1])
          notify(message, vim.log.levels.INFO)
        else
          vim.notify("No directories were deleted.", vim.log.levels.INFO)
        end
      end,
    },
  })
end

-- Example keybinding to trigger the function
vim.keymap.set("n", "<leader>pd", select_and_delete_items, { desc = "Select and delete items from file" })
fzf.setup {
  keymap = {
    -- Below are the default binds, setting any value in these tables will override
    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      false, -- uncomment to inherit all the below in your custom config
      ["<M-Esc>"] = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
      ["<F1>"] = "toggle-help",
      ["<F2>"] = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"] = "toggle-preview-wrap",
      ["<F4>"] = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
      -- `ts-ctx` binds require `nvim-treesitter-context`
      ["<F7>"] = "toggle-preview-ts-ctx",
      ["<F8>"] = "preview-ts-ctx-dec",
      ["<F9>"] = "preview-ts-ctx-inc",
      ["<S-Left>"] = "preview-reset",
      -- Custom
      ["<C-k>"] = "preview-up",
      ["<C-j>"] = "preview-down",
      ["<C-u>"] = "preview-page-up",
      ["<C-d>"] = "preview-page-down",
    },
    fzf = {
      -- fzf '--bind=' options
      false, -- uncomment to inherit all the below in your custom config
      ["ctrl-z"] = "abort",
      -- ["ctrl-u"] = "unix-line-discard",
      ["ctrl-f"] = "half-page-down",
      ["ctrl-b"] = "half-page-up",
      ["ctrl-a"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      ["alt-a"] = "toggle-all",
      ["alt-g"] = "first",
      ["alt-G"] = "last",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"] = "toggle-preview-wrap",
      ["f4"] = "toggle-preview",
      -- custom
      ["ctrl-k"] = "preview-up",
      ["ctrl-j"] = "preview-down",
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-d"] = "preview-page-down",
    },
  },
  oldfiles = {
    cwd_only = true,
  },
}

local config = require "fzf-lua.config"
config.defaults.actions.files["ctrl-q"] = trouble_actions.open_all
