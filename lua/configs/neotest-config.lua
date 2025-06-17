local neotest_golang_opts = {
  env = {
    GOENV = "test",
    CGO_ENABLED = 1,
  },
  go_test_args = {
    "-v",
    "-json",
    -- "-race",
    -- "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
    "-mod=vendor",
    "-ldflags=-s",
    -- '"-ldflags=-linkmode internal"',
  },
  -- runner = "gotestsum",
} -- Specify custom configuration
require("neotest").setup {
  adapters = {
    require "neotest-golang"(neotest_golang_opts), -- Registration
  },
  -- default_strategy = "dap",
  discovery = { enabled = false, concurrent = 1 },
  running = { concurrent = true },
  summary = { animated = false },
}
