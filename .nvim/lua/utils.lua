local M = {}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  local stat, error
  if type(rhs) == "string" then
    stat, error = pcall(vim.api.nvim_set_keymap, mode, lhs, rhs, options)
  else
    stat, error = pcall(vim.keymap.set, mode, lhs, rhs, options)
  end
  if not stat then
    vim.notify(error, vim.log.levels.ERROR, { title = 'keymap' })
  end
end

M.new_cmd = function(cmd, repl, force)
  local command
  if force then
    command = "command! " .. cmd .. " " .. repl
  else
    command = "command " .. cmd .. " " .. repl
  end
  local ok, err = pcall(vim.cmd, command)
  if not ok then
    vim.notify("setting cmd: " .. cmd .. " " .. err, vim.log.levels.ERROR, { title = 'command' })
  end
end

M.executable = function(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

function M.exists(list, val)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set[val]
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function M.is_empty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd "q!"
      end
    end)
  else
    vim.cmd "q!"
  end
end

function M.get_repo_name()
  if
      #vim.api.nvim_list_tabpages() > 1 and vim.fn.trim(vim.fn.system "git rev-parse --is-inside-work-tree") == "true"
  then
    return vim.fn.trim(vim.fn.system "basename `git rev-parse --show-toplevel`")
  end
  return ""
end

M.log_err = function(msg, title)
  vim.notify(msg, vim.log.levels.ERROR, { title = title })
end

M.log_info = function(msg, title)
  vim.notify(msg, vim.log.levels.INFO, { title = title })
end

-- This is a hook, to setup for lazy loaded plugins
local function setup_plugins_after_loaded()
  -- Run rooter when it is the first time enter the neovim
  vim.cmd [[autocmd VimEnter * Rooter]]
  require("colors")
end

local function setup_plugins_before_loaded()
  if not vim.fn.has("nvim-0.8") then
    -- for filetype.nvim
    -- If using a Neovim version earlier than 0.8.0
    vim.g.did_load_filetypes = 1
  end
end



M.load_plugins = function()
  -- detecting plugin manager
  local no_lazy = false
  local fn = vim.fn
  local install_path = fn.stdpath("data") ..
      "pack/lazy/lazy.nvim"

  if not vim.loop.fs_stat((install_path)) then
    M.log_info("Installing lazy to " .. install_path)
    no_lazy = fn.system({
      'git', 'clone', '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      "--branch=stable",
      install_path
    })
  end
  vim.opt.rtp:prepend(install_path)

  -- add a hook
  setup_plugins_before_loaded()

  -- Reading plugins configuration
  local ok, error = pcall(require, 'plugins')
  if not ok then
    M.log_err("Load plugins: " .. error, "load plugins")
  end
  local ok, err = pcall(require, "impatient")
  if not ok then
    M.log_err("Load Cached plugins: " .. error, "load plugins")
  end

  vim.cmd([[autocmd BufWritePost plugins.lua source <afile> ]])

  if no_lazy then
    require('lazy').sync()
    return
  end

  -- add a hook
  setup_plugins_after_loaded()
end

return M
