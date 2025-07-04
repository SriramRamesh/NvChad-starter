local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    -- python = { "ruff_format" },
    python = { "black" },
    -- python = { "yapf", "pylint" },
    json = { "jq" },
    -- python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { "prettierd", "prettier" },
    go = { "gofmt", "goimports" },
    css = { "prettier" },
    html = { "prettier" },
    sql = { "sqlfluff" },
    -- fsharp = { "fantomas" },
  },
  -- Customize formatters
  formatters = {
    zetasql = {
      -- Change where to find the command
      command = "zetasql-formatter",
      stdin = true,
    },
    shfmt = {
      prepend_args = { "-i", "2" },
    },
    sqlfluff = function()
      local args = { "fix", "--dialect", "bigquery", "--config", "/Users/sriram/.config/sqlfluff", "-" }
      local util = require "conform.util"
      return {
        command = "sqlfluff",
        args = args,
        stdin = true,
        -- timeout_ms = 2000, -- Set specific timeout for sqlfluff (15 seconds)
        -- exit_codes = { 0, 1 }, -- it seems to report any misformatted SQL as exit code 1
        cwd = util.root_file {
          ".sqlfluff",
          "pep8.ini",
          "pyproject.toml",
          "setup.cfg",
          "tox.ini",
        },
        require_cwd = false,
      }
    end,
  },
  -- Set up format-on-save
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    local disable_filetypes = { c = false, cpp = false }
    return {
      timeout_ms = 5000,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,
}

require("conform").setup(options)
