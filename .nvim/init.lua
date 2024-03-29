vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- load basic configuration
local utils = require('utils')
-- load plugins
utils.load_plugins()

for _, module_name in ipairs({ 'options', 'keymap', 'commands' }) do
  local ok, err = pcall(require, module_name)
  if not ok then
    local msg = "calling module: " .. module_name .. " fail: " .. err
    utils.log_err(msg)
  end
end
