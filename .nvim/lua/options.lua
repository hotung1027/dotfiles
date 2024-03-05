local opt = vim.opt

opt.encoding = 'utf-8'

-- enable number and relative line number
opt.number = true
opt.rnu = true

-- line behind cursor
opt.cursorline = true

-- [[
-- TAB SETTING
-- Use a mix of tab and space to avoid mix up file
-- ]]
-- Use the appropriate number of spaces to insert a <Tab>.
opt.expandtab = true
-- Number of spaces that a <Tab> in the file counts for.
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- Copy indent from current line when starting a new line
-- opt.autoindent=true

-- A List is an ordered sequence of items.
opt.list = true
opt.listchars = "tab:-->,trail:·"

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 5

-- Time in milliseconds to wait for a key code sequence to complete
opt.timeoutlen = 200
opt.ttimeoutlen = 0
-- no waiting for key combination
opt.timeout = false

-- remember where to recover cursor
opt.viewoptions = 'cursor,folds,slash,unix'

-- [[
-- lines longer than the width of the window will wrap and displaying continues
-- on the next line.
-- ]]
opt.wrap = true
opt.tw = 0
opt.cindent = true
opt.splitright = true
opt.splitbelow = true
opt.showmode = false
opt.showcmd = true
opt.syntax = "on"
-- auto completion on command
opt.wildmenu = true

-- ignore case when searching and only on searching
opt.ignorecase = true
opt.smartcase = true

vim.cmd("set shortmess+=cwm")
opt.inccommand = 'split'
opt.completeopt = { "menuone", "noselect", "menu" }
opt.ttyfast = true
opt.lazyredraw = true
opt.visualbell = true
opt.updatetime = 4000
opt.virtualedit = 'block'
opt.colorcolumn = '100'
opt.lazyredraw = true
opt.signcolumn = "yes:1"
opt.mouse = 'a'
opt.pumheight = 10
opt.foldlevel = 0
opt.foldenable = false
opt.formatoptions = 'qj'
opt.hidden = true

-- Changed home directory here
local backup_dir = vim.fn.stdpath("cache") .. "/backup"
local backup_stat = pcall(os.execute, "mkdir -p " .. backup_dir)
if backup_stat then
  opt.backupdir = backup_dir
  opt.directory = backup_dir
end

local undo_dir = vim.fn.stdpath("cache") .. "/undo"
local undo_stat = pcall(os.execute, "mkdir -p " .. undo_dir)
local has_persist = vim.fn.has("persistent_undo")
if undo_stat and has_persist == 1 then
  opt.undofile = true
  opt.undodir = undo_dir
end
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod = 'expr'
--     vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
--   end
-- })
local term = vim.api.nvim_create_augroup('term', {})
local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter", "BufWinEnter" }, {
  group = term,
  callback = function(args)
    set_terminal_keymaps()
    if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
      vim.cmd("startinsert")
    end
  end
})
vim.cmd [[filetype plugin indent  on]]
vim.cmd [[syntax on]]

local sessions = vim.api.nvim_create_augroup('sessions', {})
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = "SessionLoadPost",
  group = sessions,
  callback = function()
    require('nvim-tree.api').tree.toggle(false, true)
  end,
})
-- Auto save session
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- Don't save while there's any 'nofile' buffer open.
      if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
        return
      end
    end
    require('session_manager').save_current_session()
  end
})
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function()
    require('session_manager').load_current_dir_session()
    -- vim.cmd('TwilightEnable')
  end
})
local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })

vim.api.nvim_create_autocmd('BufRead', {
  group = prefetch,
  pattern = '*.py',
  callback = function()
    require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
  end
})

local nvim_cmp = vim.api.nvim_create_augroup("nvim-cmp", { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHoldI', 'TextChangedP' }, {
  group = nvim_cmp,
  callback = function()
    local cmp = require('cmp')
    local current_line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)[2]

    --
    local current = string.sub(current_line, cursor, cursor + 1)
    if current == "." or current == "," then
      cmp.close()
    end
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and
          vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local before_line = string.sub(current_line, 1, cursor + 1)
    local after_line = string.sub(current_line, cursor + 1, -1)
    -- if not string.match(before_line, '^%s+$') then
    if after_line == "" or string.match(before_line, " $") or string.match(before_line, "%.$") then
      cmp.complete()
    end
  end
})
--
-- vim.api.nvim_create_autocmd(
--   { "TextChangedI", "TextChangedP" },
--   {
--     group = nvim_cmp,
--
--     pattern = "*",
--     callback = function()
-- end
---
--   })
