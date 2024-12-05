require("codecompanion").setup({
  strategies = { -- Change the adapters as required
    chat = { adapter = "ollama" },
    inline = { adapter = "ollama" },
    agent = { adapter = "ollama" },
  },
  display = {
    diff = {
      provider = "mini_diff",
    },
  },
  opts = {
    log_level = "DEBUG",
  },
  -- adapters = {
  --   ollama = function()
  --     return require("codecompanion.adapters").extend("openai_compatible", {
  --       env = {
  --         -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
  --         -- api_key = "OpenAI_API_KEY",               -- optional: if your endpoint is authenticated
  --         -- chat_url = "/v1/chat/completions",        -- optional: default value, override if different
  --       },
  --       schema = {
  --         model = {
  --           default = "qwen2.5-coder:14b",
  --         }
  --       },
  --     })
  --   end,
  -- },
})
