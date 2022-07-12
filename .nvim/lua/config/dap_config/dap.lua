local function import(parent,modules)
  for id, name in ipairs(modules) do
    modules[id] = require(parent..'.'..name)
  end
end
import('config.dap_config.lua',{
  'dap_cpp',
  'dap_flutter',
  'dap_haskell'
})

