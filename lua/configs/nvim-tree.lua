local utils = require("utils")
local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too
local fzf = require 'fzf-lua'

-- Path to the file where directory paths will be appended
-- Path to the file where directory paths will be appended
local target_filepath = vim.fn.stdpath("config") .. "/projects"

-- Function to append the directory path to the target file if it doesn't exist, with confirmation
local function append_directory_to_file(node)
  -- Ensure the selected node is a directory
  if node.type ~= "directory" then
    vim.notify("Selected node is not a directory.", vim.log.levels.WARN)
    return
  end

  utils.append_path_to_file(node.absolute_path, target_filepath)
end

-- Add a custom keybinding to Nvim-Tree to trigger the function
require("nvim-tree").setup({
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    -- Define the custom keybinding (e.g., <leader>a)
    vim.keymap.set("n", "<leader>a", function()
      local node = api.tree.get_node_under_cursor()
      append_directory_to_file(node)
    end, { buffer = bufnr, desc = "Append Directory Path to File" })
  end,
})

local function relative_path_under_cursor()
  local node = require("nvim-tree.core").get_explorer():get_node_at_cursor()
  if node == nil then
    return
  end
  local current_path = node.absolute_path
  if node.type == "file" then
    return node.parent.absolute_path
  end
  if current_path == nil then
    return
  end
  local cwd = vim.fn.getcwd()
  local relative_path, _ = string.gsub(current_path, utils.literalize(cwd), ".")
  return relative_path
end

require('nvim-tree').setup({
  git = {
    enable = true,
    timeout = 400 -- (in ms)
  },
  filters = { dotfiles = false },
  disable_netrw = true,
  update_cwd = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
        - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        }
        , 
        git = { unmerged = "" },
      },
    },
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- BEGIN_DEFAULT_ON_ATTACH
    vim.keymap.set("n", "<C-]>",          api.tree.change_root_to_node,       opts("CD"))
    vim.keymap.set("n", "<C-e>",          api.node.open.replace_tree_buffer,  opts("Open: In Place"))
    vim.keymap.set("n", "<C-k>",          api.node.show_info_popup,           opts("Info"))
    vim.keymap.set("n", "<C-r>",          api.fs.rename_sub,                  opts("Rename: Omit Filename"))
    vim.keymap.set("n", "<C-t>",          api.node.open.tab,                  opts("Open: New Tab"))
    vim.keymap.set("n", "<C-v>",          api.node.open.vertical,             opts("Open: Vertical Split"))
    vim.keymap.set("n", "<C-x>",          api.node.open.horizontal,           opts("Open: Horizontal Split"))
    vim.keymap.set("n", "<BS>",           api.node.navigate.parent_close,     opts("Close Directory"))
    vim.keymap.set("n", "<CR>",           api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "<Tab>",          api.node.open.preview,              opts("Open Preview"))
    vim.keymap.set("n", ">",              api.node.navigate.sibling.next,     opts("Next Sibling"))
    vim.keymap.set("n", "<",              api.node.navigate.sibling.prev,     opts("Previous Sibling"))
    vim.keymap.set("n", ".",              api.node.run.cmd,                   opts("Run Command"))
    vim.keymap.set("n", "-",              api.tree.change_root_to_parent,     opts("Up"))
    vim.keymap.set("n", "a",              api.fs.create,                      opts("Create File Or Directory"))
    vim.keymap.set("n", "bd",             api.marks.bulk.delete,              opts("Delete Bookmarked"))
    vim.keymap.set("n", "bt",             api.marks.bulk.trash,               opts("Trash Bookmarked"))
    vim.keymap.set("n", "bmv",            api.marks.bulk.move,                opts("Move Bookmarked"))
    vim.keymap.set("n", "B",              api.tree.toggle_no_buffer_filter,   opts("Toggle Filter: No Buffer"))
    vim.keymap.set("n", "c",              api.fs.copy.node,                   opts("Copy"))
    vim.keymap.set("n", "C",              api.tree.toggle_git_clean_filter,   opts("Toggle Filter: Git Clean"))
    vim.keymap.set("n", "[c",             api.node.navigate.git.prev,         opts("Prev Git"))
    vim.keymap.set("n", "]c",             api.node.navigate.git.next,         opts("Next Git"))
    vim.keymap.set("n", "d",              api.fs.remove,                      opts("Delete"))
    vim.keymap.set("n", "D",              api.fs.trash,                       opts("Trash"))
    vim.keymap.set("n", "E",              api.tree.expand_all,                opts("Expand All"))
    vim.keymap.set("n", "e",              api.fs.rename_basename,             opts("Rename: Basename"))
    vim.keymap.set("n", "]e",             api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
    vim.keymap.set("n", "[e",             api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
    vim.keymap.set("n", "F",              api.live_filter.clear,              opts("Live Filter: Clear"))
    vim.keymap.set("n", "f",              api.live_filter.start,              opts("Live Filter: Start"))
    vim.keymap.set("n", "g?",             api.tree.toggle_help,               opts("Help"))
    vim.keymap.set("n", "gy",             api.fs.copy.absolute_path,          opts("Copy Absolute Path"))
    vim.keymap.set("n", "ge",             api.fs.copy.basename,               opts("Copy Basename"))
    vim.keymap.set("n", "H",              api.tree.toggle_hidden_filter,      opts("Toggle Filter: Dotfiles"))
    vim.keymap.set("n", "I",              api.tree.toggle_gitignore_filter,   opts("Toggle Filter: Git Ignore"))
    vim.keymap.set("n", "J",              api.node.navigate.sibling.last,     opts("Last Sibling"))
    vim.keymap.set("n", "K",              api.node.navigate.sibling.first,    opts("First Sibling"))
    vim.keymap.set("n", "L",              api.node.open.toggle_group_empty,   opts("Toggle Group Empty"))
    vim.keymap.set("n", "M",              api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
    vim.keymap.set("n", "m",              api.marks.toggle,                   opts("Toggle Bookmark"))
    vim.keymap.set("n", "o",              api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "O",              api.node.open.no_window_picker,     opts("Open: No Window Picker"))
    vim.keymap.set("n", "p",              api.fs.paste,                       opts("Paste"))
    vim.keymap.set("n", "P",              api.node.navigate.parent,           opts("Parent Directory"))
    vim.keymap.set("n", "q",              api.tree.close,                     opts("Close"))
    vim.keymap.set("n", "r",              api.fs.rename,                      opts("Rename"))
    vim.keymap.set("n", "R",              api.tree.reload,                    opts("Refresh"))
    vim.keymap.set("n", "s",              api.node.run.system,                opts("Run System"))
    vim.keymap.set("n", "S",              api.tree.search_node,               opts("Search"))
    vim.keymap.set("n", "u",              api.fs.rename_full,                 opts("Rename: Full Path"))
    vim.keymap.set("n", "U",              api.tree.toggle_custom_filter,      opts("Toggle Filter: Hidden"))
    vim.keymap.set("n", "W",              api.tree.collapse_all,              opts("Collapse"))
    vim.keymap.set("n", "x",              api.fs.cut,                         opts("Cut"))
    vim.keymap.set("n", "y",              api.fs.copy.filename,               opts("Copy Name"))
    vim.keymap.set("n", "Y",              api.fs.copy.relative_path,          opts("Copy Relative Path"))
    vim.keymap.set("n", "<2-LeftMouse>",  api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node,       opts("CD"))

    vim.keymap.set("n", "T", function()
      -- get current window buffers' paths
      local buf_ids = vim.fn.tabpagebuflist()
      local win_ids = vim.api.nvim_tabpage_list_wins(0)
      local dir_paths = {}
      for _,win_id in ipairs(win_ids) do
        table.insert(dir_paths, vim.fn.getcwd(win_id))
      end
      for _, buf_id in ipairs(buf_ids) do
        local ft = vim.api.nvim_get_option_value("ft",buf_id)
        if ft ~= "NvimTree" then
          local path = vim.fn.expand(string.format("#%d:p:h", buf_id))
          if path ~= nil and path ~= "" then
            table.insert(dir_paths, path)
          end
        end
      end
      dir_paths = utils.list_unique(dir_paths)
      if #dir_paths > 1 then
        vim.ui.select(dir_paths, { prompt = "Select path to change root" }, function(choice)
          require("nvim-tree.api").tree.change_root(choice)
        end)
      else
        require("nvim-tree.api").tree.change_root(dir_paths[1])
      end
    end, opts("Toggle root"))

    vim.keymap.set("n", "<leader><leader>", function()
      local relative_path = relative_path_under_cursor()
      if not fzf then
        return
      end
      api.tree.close()
      fzf.files({
        prompt_title = "find file under: " .. relative_path,
        cwd = relative_path,
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = {},
      })
    end, opts("Find file"))

    vim.keymap.set("n", "<leader>sd", function()
      local relative_path = relative_path_under_cursor()
      if not fzf then
        return
      end
      fzf.live_grep_glob({
        git_icons=false,
        cwd = relative_path,
        preview = true,
        hidden = true,
        no_ignore = true,
      })
    end, opts("Live grep"))
    -- Define the custom keybinding (e.g., <leader>a)
    vim.keymap.set("n", "<leader>pa", function()
      local node = api.tree.get_node_under_cursor()
      append_directory_to_file(node)
    end, { buffer = bufnr, desc = "Append Directory Path to File" })
  end

})
