-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?.lua"
-- /Users/sriram/.luarocks
--
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  -- {
  --     "williamboman/mason-lspconfig.nvim",
  --     dependencies = {
  --     "williamboman/mason.nvim",
  --     "neovim/nvim-lspconfig",
  --       {
  --         "SmiteshP/nvim-navbuddy",
  --         dependencies = {
  --           "SmiteshP/nvim-navic",
  --           "MunifTanjim/nui.nvim"
  --         },
  --         opts = { lsp = { auto_attach = true } }
  --       }
  --     },
  --     config = function()
  --       require "configs.mazonlsp.lua"
  --       -- require("nvchad.configs.lspconfig").defaults()
  --       -- require "configs.lspconfig"
  --     end,
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "lua-language-server", "stylua",
  --       "html-lsp", "css-lsp", "prettier"
  --     },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "go",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "sql",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "java",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    -- opts = { max_lines = 1 },
    event = "BufReadPost",
    config = function ()
      require("configs.nvim-treesitter-context")
    end
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require "configs.alpha"
    end,
  },
  -- { 'echasnovski/mini.jump',
  --   version = false,
  --   lazy = false,
  --   config = function ()
  --     require 'configs.mini'
  --   end
  -- },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- ---@type Flash.Config
    -- opts = {},
    -- stylua: ignore
    -- keys = {
    --   { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    --   { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    --   { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    --   { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --   { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    -- },
    config = function()
      require "configs.flash"
    end
    ,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    -- enabled = false,
    pts = { extensions_list = { "fzf" } },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    -- config = function()
    --   require('telescope').setup {
    --     defaults = {
    --       previewer = true,
    --       file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    --       grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    --       qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    --     }
    --   }
    -- end
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icon support
    cmd = "FzfLua",
    config = function()
      require "configs.fzflua"
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "ibhagwan/fzf-lua", -- optional
    },
    cmd = "Neogit",
    config = function()
      require "configs.neogit"
    end,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "LazyGit" },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Gitlinker",
    config = function()
      require("gitlinker").setup {}
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      keys = {
        ["<tab>"] = "fold_toggle",
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>cd",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>cD",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      -- {
      --   "<leader>cs",
      --   "<cmd>Trouble symbols toggle focus=false<cr>",
      --   desc = "Symbols (Trouble)",
      -- },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>cL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>cQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    config = function()
      require "configs.trouble"
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      -- you'll need at least one of these
      -- {'nvim-telescope/telescope.nvim'},
      "ibhagwan/fzf-lua",
    },
    config = function()
      require "configs.neoclip"
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    cmd = "Navbuddy",
    config = function()
      require "configs.navbuddy"
    end,
    keys = {
      {
        "gs",
        function()
          require("nvim-navbuddy").open()
        end,
        desc = "open navbuddy",
      },
    },

  },
  -- {
  --   "ray-x/navigator.lua",
  --   dependencies = {
  --     { "ray-x/guihua.lua",     build = "cd lua/fzy && make" },
  --     { "neovim/nvim-lspconfig" },
  --   },
  --   config = function()
  --     require "configs.navigator"
  --   end,
  -- },
  -- UI
  -- {
  --   "ray-x/guihua.lua",
  --   build = "cd lua/fzy && make",
  --   lazy = true,
  --   init = function()
  --     -- vim.cmd([[hi default GuihuaTextViewDark guifg=#e0d8f4 guibg=#332e55]])
  --     -- vim.cmd([[hi default GuihuaListDark guifg=#e0d8f4 guibg=#103234]])
  --     -- vim.cmd([[hi default GuihuaListHl guifg=#e0d8f4 guibg=#404254]])
  --     vim.cmd([[hi default GuihuaTextViewDark ctermfg=white ctermbg=236 cterm=NONE]])
  --     vim.cmd([[hi default GuihuaListDark ctermfg=white ctermbg=236 cterm=NONE]])
  --     vim.cmd([[hi default GuihuaListHl ctermfg=white ctermbg=cyan]])
  --   end
  -- },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    -- lazy = false,
    build = ":UpdateRemotePlugins",
    init = function()
      require "configs.molten"
    end,
  },
  {
    "3rd/image.nvim",
    config = function()
      require "configs.image"
    end,
  },
  {
    "willothy/wezterm.nvim",
    config = true,
  },
  {
    "Olical/conjure",
    cmd = "ConjureSchool",
    config = function()
      -- Disable the documentation mapping
      vim.g["conjure#mapping#doc_word"] = false

      -- Rebind it from K to <prefix>gk
      vim.g["conjure#mapping#doc_word"] = "gk"

      -- Reset it to the default unprefixed K (note the special table wrapped syntax)
      vim.g["conjure#mapping#doc_word"] = { "K" }
    end,
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/refile.org',
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
		  vim.g.db_ui_env_variable_url = "https://www.googleapis.com/bigquery/v2:443?format=sparse&use_legacy_sql=false"
		  vim.g.db_ui_auto_execute_table_helpers = 1
		  -- vim.g.db_ui_execute_on_save = 0
    end,
  }
}
