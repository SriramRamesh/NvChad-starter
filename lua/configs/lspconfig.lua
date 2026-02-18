require("nvchad.configs.lspconfig").defaults()
local configs = require "nvchad.configs.lspconfig"
local map = vim.keymap.set
local navbuddy = require "nvim-navbuddy"

-- ----------------------------
-- uv venv helper (for basedpyright)
-- ----------------------------
local function find_uv_python(root_dir)
  -- Prefer active venv if you launched nvim from an activated env
  local venv = vim.env.VIRTUAL_ENV
  if venv and #venv > 0 then
    local py = vim.fs.joinpath(venv, "bin", "python")
    if vim.uv.fs_stat(py) then
      return py
    end
  end

  -- Common uv venv locations
  local candidates = {
    vim.fs.joinpath(root_dir, ".venv", "bin", "python"),
    vim.fs.joinpath(root_dir, "venv", "bin", "python"),
    vim.fs.joinpath(root_dir, ".uv", "venv", "bin", "python"),
  }

  for _, py in ipairs(candidates) do
    if vim.uv.fs_stat(py) then
      return py
    end
  end

  return nil
end

-- ----------------------------
-- Custom servers not in lspconfig
-- ----------------------------
vim.lsp.config("pbls", {
  cmd = { "pbls" },
  filetypes = { "proto" },
  root_markers = { ".git" },
})

-- ----------------------------
-- LSP keymaps + navbuddy on attach
-- ----------------------------
local fzf_key_map = {
  n = {
    ["gD"] = {
      function()
        require("fzf-lua").lsp_declarations { jump_to_single_result = true, silent = true }
      end,
      "Lsp declaration",
    },
    ["gd"] = {
      function()
        require("fzf-lua").lsp_definitions { jump_to_single_result = true, silent = true }
      end,
      "Lsp definitions",
    },
    ["gr"] = {
      function()
        require("fzf-lua").lsp_references { includeDeclaration = false, jump_to_single_result = true, silent = true }
      end,
      "Lsp references",
    },
    ["gI"] = {
      function()
        require("fzf-lua").lsp_implementations { jump_to_single_result = true, silent = true }
      end,
      "Lsp implementations",
    },
    ["gR"] = { vim.lsp.buf.rename, "Lsp Rename" },
    ["gS"] = { "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>", "Lsp symbols" },
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    navbuddy.attach(client, bufnr)
    for mode, maps in pairs(fzf_key_map) do
      for key, val in pairs(maps) do
        map(mode, key, val[1], { buffer = bufnr, desc = val[2] })
      end
    end
  end,
})

-- ----------------------------
-- Server-specific configs
-- (NvChad already sets capabilities + on_init globally via vim.lsp.config("*", ...))
-- ----------------------------
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        disable = { "missing-fields" },
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.api.nvim_get_runtime_file("", true),
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("basedpyright", {
  before_init = function(_, config)
    local root = config.root_dir or vim.uv.cwd()
    local py = find_uv_python(root)
    if py then
      config.settings = config.settings or {}
      config.settings.python = config.settings.python or {}
      config.settings.python.pythonPath = py
    end
  end,
  settings = {
    basedpyright = {
      analysis = { typeCheckingMode = "basic" },
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = { unusedparams = true },
    },
  },
})

-- ----------------------------
-- Enable servers
-- (lua_ls is already enabled by NvChad defaults, repeating is harmless)
-- ----------------------------
vim.lsp.enable {
  "html",
  "bashls",
  "pbls",
  "ts_ls",
  "lua_ls",
  "basedpyright",
  "gopls",
}
