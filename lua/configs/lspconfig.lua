require("nvchad.configs.lspconfig").defaults()
local configs = require "nvchad.configs.lspconfig"
local map = vim.keymap.set
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local navbuddy = require "nvim-navbuddy"

local lsp_configs = require "lspconfig.configs"

-- ...share/nvim/lazy/nvim-lspconfig/lua/lspconfig/configs.lua:42: attempt to index field 'default_config' (a nil value)

-- # stacktrace:
-- - ~/.config/nvim/lua/configs/lspconfig.lua:15
-- - ~/.config/nvim/lua/plugins/init.lua:102 _in_ **config**
-- - /NvChad/lua/nvchad/autocmds.lua:15
-- - /fzf-lua/lua/fzf-lua/fzf.lua:308

-- lsp_configs.bqls = {
--   default_config = {
--     cmd = { "/Users/sriram/bqls/bqls" },
--     filetypes = { "sql" },
--     root_dir = util.root_pattern ".git",
--     settings = {
--       project_id = "focal-elf-631",
--     },
--   },
-- }

lsp_configs.pbls = {
  default_config = {
    cmd = { "pbls" },
    filetypes = { "proto" },
    -- single_file_support = true,
    -- root_dir = function() end,
    root_dir = function(fname)
      return util.root_pattern ".git"(fname)
    end,
  },
}
-- lsp_configs.buf = {
--   default_config = {
--     cmd = { 'buf', 'beta', 'lsp' },
--     filetypes = { 'proto' },
--     root_dir = function(fname)
--       return util.root_pattern( '.git')(fname)
--     end,
--   },
-- }
-- lsp_configs.protobuf_language_server = {
--     default_config = {
--         cmd = { '/Users/sriram/go/bin/protobuf-language-server' },
--         filetypes = { 'proto', 'cpp' },
--         root_dir = util.root_pattern('.git'),
--         single_file_support = false,
--         settings = {
--             -- ["additional-proto-dirs"] = [
--             --     -- path to additional protobuf directories
--             --     -- "vendor",
--             --     -- "third_party",
--             -- ]
--         },
--     }
-- }

local servers = {
  html = {},
  awk_ls = {},
  bashls = {},
  -- bqls = {
  --   on_init = function(client)
  --     client.server_capabilities.documentFormattingProvider = false
  --     client.server_capabilities.documentFormattingRangeProvider = false
  --   end,
  --   on_attach = function(client, bufnr)
  --     -- Disable formatting for tsserver
  --     client.server_capabilities.documentFormattingProvider = false
  --     client.server_capabilities.documentRangeFormattingProvider = false
  --   end,
  --   autoformat = false,
  --   init_options = {
  --     provideFormatter = false,
  --   },
  -- },
  -- protols = {},
  -- pb = {},
  -- protobuf_language_server ={},
  -- buf = {},
  pbls = {},
  ts_ls = {},
  fsautocomplete = {
    default_config = {
      cmd = { "fsautocomplete", "--adaptive-lsp-server-enabled" },
      root_dir = util.root_pattern("*.sln", "*.fsproj", ".git"),
      filetypes = { "fsharp" },
      init_options = {
        AutomaticWorkspaceInit = true,
      },
      -- this recommended settings values taken from  https://github.com/ionide/FsAutoComplete?tab=readme-ov-file#settings
      settings = {
        FSharp = {
          keywordsAutocomplete = true,
          ExternalAutocomplete = false,
          Linter = true,
          UnionCaseStubGeneration = true,
          UnionCaseStubGenerationBody = 'failwith "Not Implemented"',
          RecordStubGeneration = true,
          RecordStubGenerationBody = 'failwith "Not Implemented"',
          InterfaceStubGeneration = true,
          InterfaceStubGenerationObjectIdentifier = "this",
          InterfaceStubGenerationMethodBody = 'failwith "Not Implemented"',
          UnusedOpensAnalyzer = true,
          UnusedDeclarationsAnalyzer = true,
          UseSdkScripts = true,
          SimplifyNameAnalyzer = true,
          ResolveNamespaces = true,
          EnableReferenceCodeLens = true,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          disable = { "missing-fields" },
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          checkThirdParty = false,
          library = {
            vim.api.nvim_get_runtime_file("", true),
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths here.
            "${3rd}/luv/library",
            -- "${3rd}/busted/library",
          },
          -- didChangeWatchedFiles = {
          --   dynamicRegistration = false,
          --   relativePatternSupport = false,
          -- },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false,
        relativePatternSupport = false,
      },
    },
  },
  -- sqlls = {},
  -- pythonPath = vim.fn.exepath "python3",
  -- venvPath = vim.fn.exepath "pyenv",
  -- venv = "py37moloco",
  -- NEED: nested "pylsp" dict
  --   TALK: https://github.com/neovim/nvim-lspconfig/issues/1347
  --   FIXED: https://neovim.discourse.group/t/pylsp-config-is-not-taken-into-account/1846/2
  -- pylsp = {
  --   configurationSources = { "pylint" },
  --   plugins = {
  --     -- BAD:NEED: $ paci nuspell
  --     pylint = { enabled = true }, -- , args = {"--rcfile=pylint.ini", "--disable C0301"}
  --     -- isort = { enabled = true },
  --     -- black = { enabled = true, cache_config = true },
  --     mypy = { enabled = true },
  --     rope_completion = { enabled = true },
  --
  --     -- DEP: pylsp-autoimport
  --     -- FAIL: autoimport = { enabled = true },
  --     -- SRC: https://github.com/bageljrkhanofemus/dotfiles/blob/4a8d7e555ca96d0d4b17eda6ed37c68c7ec6a045/dot_config/nvim/lua/configs/lsp.lua
  --     -- WAIT https://github.com/python-lsp/python-lsp-server/pull/199
  --     -- NEED: $ pip install . --user
  --     -- DISABLED:ERR: code errors
  --     -- rope_autoimport = { enabled = true },
  --
  --     pydocstyle = { enabled = false },
  --     autopep8 = { enabled = false },
  --     yapf = { enabled = false },
  --     flake8 = { enabled = false },
  --     pycodestyle = { enabled = false, maxLineLength = 88 },
  --     pyflakes = { enabled = false },
  --   },
  -- },
  basedpyright = {
    -- venvPath = "/Users/sriram/.venv_rmp_infra",
    -- venv = ".venv_rmp_infra",
    settings = {
      -- pyright = {
      --   -- Using Ruff's import organizer
      --   disableOrganizeImports = true
      -- },
      basedpyright = {
        -- venvPath = "/Users/sriram/.venv_rmp_infra/",
        -- venv = ".venv_rmp_infra",

        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  },
  -- basedpyright = {
  --   typeCheckingMode = "off",
  --   diagnosticMode = "off",
  --   settings = {
  --     pyright = {
  --       -- Using Ruff's import organizer
  --       disableOrganizeImports = true
  --     },
  --     basedpyright = {
  --       analysis = {
  --         typeCheckingMode = "off",
  --         diagnosticSeverityOverrides = {
  --           reportUnusedCallResult = "information",
  --           reportUnusedExpression = "information",
  --           reportUnknownMemberType = "none",
  --           reportUnknownLambdaType = "none",
  --           reportUnknownParameterType = "none",
  --           reportMissingParameterType = "none",
  --           reportUnknownVariableType = "none",
  --           reportUnknownArgumentType = "none",
  --           reportAny = "none",
  --         },
  --       }
  --     }
  --   }
  -- },
  -- pyright = {
  --   -- venvPath = "/Users/sriram/.pyenv/versions/",
  --   -- venv = "3.11.7",
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         typeCheckingMode = "basic",
  --       },
  --       -- venvPath = "/Users/sriram/.pyenv/versions/",
  --       -- venv = "py37moloco",
  --     },
  --     -- venvPath = "/Users/sriram/.pyenv/versions/",
  --     -- venv = "py37moloco",
  --   },
  -- },
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
    -- ["gT"] = { "<cmd>Trouble symbols toggle focus=true win.position=right<cr>", "Lsp symbols" },
    ["gS"] = { "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>", "Lsp symbols" },
  },
}

local function on_attach(client, bufnr)
  -- on_attach_nvchad(client, bufnr)
  -- if client ~= "bqls" then
  navbuddy.attach(client, bufnr)
  -- end
  for mode, maps in pairs(fzf_key_map) do
    for key, val in pairs(maps) do
      map(mode, key, val[1], { buffer = bufnr, desc = val[2] })
    end
  end
  -- require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
  -- require("navigator.dochighlight").documentHighlight(bufnr)
  -- require("navigator.codeAction").code_action_prompt(bufnr)
  -- map("n")
end

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  -- opts.on_attach = configs.on_attach
  opts.on_attach = on_attach
  opts.capabilities = configs.capabilities
  lspconfig[name].setup(opts)
end
