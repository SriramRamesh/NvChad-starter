-- _G.my_action = function(selected, opts)
--   if #selected>1 then
--     -- build the quickfix list from the selected items
--    require'fzf-lua'.actions.file_sel_to_qf(selected, opts)
--     -- call the command to open the 'trouble.nvim' interface
--     vim.cmd("<trouble nvim command>")
--   else
--     require'fzf-lua'.actions.file_edit(selected, opts)
--   end
-- end
--
-- require'fzf-lua'.setup {
--   files = {
--     actions = { ['ctrl-t'] = { fn = _G.my_action, prefix = 'select-all+' } },
--   }
-- }

local config = require("fzf-lua.config")
local actions = require("trouble.sources.fzf").actions
config.defaults.actions.files["ctrl-q"] = actions.open
