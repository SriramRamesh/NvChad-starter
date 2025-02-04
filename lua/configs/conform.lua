local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    -- python = { "ruff_format" },
    python = { "yapf" }, --, "pylint" },
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
  },
  -- Set up format-on-save
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
