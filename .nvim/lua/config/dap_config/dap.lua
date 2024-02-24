local function import(parent, modules)
  for id, name in ipairs(modules) do
    modules[id] = require(parent .. '.' .. name)
  end
end
import('config.dap_config.lua', {
  'dap_cpp',
  'dap_flutter',
  'dap_haskell'
})
local M = {}
local installer_path = '/Users/randyt/.local/share/nvim/mason/bin/'
local nvim_dap = require('mason-nvim-dap').setup({
  ensure_installed = { 'codelldb' },
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,
    python = function(config)
      config.adapters = {
        type = "executable",
        command = "/usr/bin/python",
        args = {
          "-m",
          "debugpy.adapter",
        },
      }
      require('mason-nvim-dap').default_setup(config) -- don't forget this!
    end,
    cpp = function(config)
      config.adapters = {
        type = "executable",
        command = installer_path .. "codelldb",
        port = "${port}",
        args = {
          "--port",
          "${port}",
        },

      }
      require('mason-nvim-dap').default_setup(config) -- don't forget this!
    end
  }
})
M.installer_path = installer_path
return M
