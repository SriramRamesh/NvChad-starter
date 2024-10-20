local configs = require "nvchad.configs.lspconfig"
local map = vim.keymap.set
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local navbuddy = require "nvim-navbuddy"
local servers = {
  html = {},
  awk_ls = {},
  bashls = {},
  ts_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
          -- library = {
          --   vim.env.VIMRUNTIME
          --   -- Depending on the usage, you might want to add additional paths here.
          --   -- "${3rd}/luv/library"
          --   -- "${3rd}/busted/library",
          -- },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  -- sqlls = {},

  pyright = {
    venvPath = "/Users/sriram/.pyenv/versions/",
    venv = "py37moloco",
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
        -- venvPath = "/Users/sriram/.pyenv/versions/",
        -- venv = "py37moloco",
      },
      -- venvPath = "/Users/sriram/.pyenv/versions/",
      -- venv = "py37moloco",
    },
  },
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        -- staticcheck = true,
        analyses = {
          unusedparams = true,
        },
      },
    },

  },
}

local fzf_key_map = {
  n = {
    ["gD"] = {
      function()
        require("fzf-lua").lsp_declarations { jump_to_single_result = true, silent = true }
      end,
      "Lsp declaration" },
    ["gd"] = {
      function()
        require("fzf-lua").lsp_definitions { jump_to_single_result = true, silent = true }
      end,
      "Lsp definitions" },
    ["gr"] = {
      function()
        require("fzf-lua").lsp_references { includeDeclaration = false, jump_to_single_result = true, silent = true }
      end,
      "Lsp references" },
    ["gI"] = {
      function()
        require("fzf-lua").lsp_implementations { jump_to_single_result = true, silent = true }
      end,
      "Lsp implementations" },
    ["gT"] = { "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>", "Lsp symbols" },
    ["gt"] = { "<cmd>Trouble symbols toggle focus=true win.position=right<cr>", "Lsp symbols" },
  },
}


local function on_attach(client, bufnr)
  -- on_attach_nvchad(client, bufnr)
  -- for mode, maps in pairs(fzf_key_map) do
  --   for key, val in pairs(maps) do
  --     map(mode, key, val[1], { buffer = bufnr, desc = val[2] })
  --   end
  -- end
  navbuddy.attach(client, bufnr)
  require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
  require("navigator.dochighlight").documentHighlight(bufnr)
  require("navigator.codeAction").code_action_prompt(bufnr)
end


for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  -- opts.on_attach = configs.on_attach
  opts.on_attach = on_attach
  opts.capabilities = configs.capabilities

  lspconfig[name].setup(opts)
end
