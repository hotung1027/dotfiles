local M = {}

M.map = function (mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    local stat, error = pcall(vim.api.nvim_set_keymap, mode, lhs, rhs, options)
    if not stat then
      vim.notify(error, vim.log.levels.ERROR, {title='keymap'})
    end
end

M.new_cmd = function (cmd, repl, force)
    local command
    if force then
      command = "command! "..cmd.." "..repl
    else
      command = "command "..cmd.." "..repl
    end
    local ok, err = pcall(vim.cmd, command)
    if not ok then
      vim.notify("setting cmd: "..cmd.." "..err, vim.log.levels.ERROR, {title='command'})
    end
end

M.executable = function (name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end


M.log_err = function (msg, title)
  vim.notify(msg, vim.log.levels.ERROR, {title=title})
end

M.log_info = function (msg, title)
  vim.notify(msg, vim.log.levels.INFO, {title=title})
end

-- This is a hook, to setup for lazy loaded plugins
local function setup_plugins_after_loaded()
    -- Run rooter when it is the first time enter the neovim
    vim.cmd[[autocmd VimEnter * Rooter]]
    require("colors")
end

local function setup_plugins_before_loaded()
  if not vim.fn.has("nvim-0.6") then
    -- for filetype.nvim
    -- If using a Neovim version earlier than 0.6.0
    vim.g.did_load_filetypes = 1
  end
end

M.load_plugins = function()
  -- detecting plugin manager
  local no_packer = false
  local fn = vim.fn
  local install_path = fn.stdpath("data") ..
                           "/site/pack/packer/opt/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
      M.log_info("Installing packer to " .. install_path)
      no_packer = fn.system({
          'git', 'clone', '--depth', '1',
          'https://github.com/wbthomason/packer.nvim', install_path
      })
  end

  local packer_call, error_msg = pcall(vim.cmd, [[packadd packer.nvim]])
  if not packer_call then
      M.log_err(error_msg, "load plugin")
      return
  end

  -- add a hook
  setup_plugins_before_loaded()

  -- Reading plugins configuration
  local ok, error = pcall(require, 'plugins')
  if not ok then
    M.log_err("Load plugins: "..error, "load plugins")
  end

  vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

  if no_packer then
    require('packer').sync()
    return
  end

  -- add a hook
  setup_plugins_after_loaded()
end

return M
