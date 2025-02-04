-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?.lua"
-- /Users/sriram/.luarocks
--
return {
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
        "proto",
        "sql",
        "query",
        "regex",
        "toml",
        "tsx",
        "kdl",
        "typescript",
        "vim",
        "java",
        "vimdoc",
        "xml",
        "yaml",
        "fsharp",
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
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "MunifTanjim/nui.nvim",
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("nvim-navic").setup {}
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    cmd = "Navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
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
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        opts = { lsp = { auto_attach = true } },
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "nvim-web-devicons"
    end,
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require "configs.alpha"
    end,
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
    "nvim-lua/plenary.nvim",
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
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false win.position=bottom",
        desc = "Symbols (Trouble)",
      },
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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "configs.nvim-tree"
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    config = function()
      require "configs.codecompanion"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require "configs.indent-blankline"
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {}
      vim.api.nvim_create_user_command("RunCommand", function(opts)
        local command = opts.args
        vim.fn.jobstart(command, {
          stdout_buffered = true,
          on_stdout = function(_, data)
            if data then
              require "notify"(table.concat(data, "\n"))
            end
          end,
          on_stderr = function(_, data)
            if data then
              require "notify"("Error: " .. table.concat(data, "\n"), "error")
            end
          end,
        })
      end, { nargs = 1 })

      -- Example usage:
      -- :RunCommand ls -la
    end,
  },
  {
    "gbprod/substitute.nvim",
    config = function()
      require "configs.substitute"
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.noice"
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 10, -- amount of lines we will try to show around the current line
        treesitter = true, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require "configs.nvim-treesitter-textobjects"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "microsoft/python-type-stubs" },
  -- {
  --   "kitagry/bqls.nvim",
  --   dependencies = {
  --     "nvim-neo-tree/neo-tree.nvim",
  --   },
  --   config = function()
  --     require("lspconfig").bqls.setup {
  --       -- capabilities = require("kitagry.lsp").capabilities,
  --       init_options = {
  --         project_id = "focal-elf-631",
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   cmd = "Neotree",
  --   config = function()
  --     require("neo-tree").setup {
  --       sources = {
  --         "filesystem",
  --         "buffers",
  --         "git_status",
  --         "bqls",
  --       },
  --       bqls = {
  --         project_ids = { "focal-elf-631" }, -- default is {"bigquery-public-data"}
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   'saghen/blink.cmp',
  --   -- optional: provides snippets for the snippet source
  --   dependencies = 'rafamadriz/friendly-snippets',
  --
  --   -- use a release tag to download pre-built binaries
  --   version = '*',
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   -- If you use nix, you can build from source using latest nightly rust with:
  --   -- build = 'nix run .#build-plugin',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     -- 'default' for mappings similar to built-in completion
  --     -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  --     -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  --     -- See the full "keymap" documentation for information on defining your own keymap.
  --     keymap = { preset = 'default' },
  --
  --     appearance = {
  --       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- Useful for when your theme doesn't support blink.cmp
  --       -- Will be removed in a future release
  --       use_nvim_cmp_as_default = false,
  --       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = 'mono'
  --     },
  --
  --     -- Default list of enabled providers defined so that you can extend it
  --     -- elsewhere in your config, without redefining it, due to `opts_extend`
  --     sources = {
  --       default = { 'lsp', 'path', 'snippets', 'buffer' },
  --     },
  --   },
  --   opts_extend = { "sources.default" }
  -- }
}
-- https://github.com/chrisgrieser/nvim-scissors
-- https://github.com/ecthelionvi/NeoComposer.nvim
-- https://github.com/m4xshen/hardtime.nvim
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
-- https://github.com/junegunn/goyo.vim
-- https://github.com/preservim/vim-pencil
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- https://github.com/iamcco/markdown-preview.nvim
-- set spell https://youtu.be/oLpGahrsSGQ?t=327
-- https://github.com/jackMort/ChatGPT.nvim
-- https://github.com/OXY2DEV/markview.nvim
-- https://github.com/folke/persistence.nvim
-- https://github.com/folke/lazydev.nvim
