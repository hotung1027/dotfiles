-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/randyt/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/randyt/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/randyt/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/randyt/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/randyt/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.comment\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LeaderF = {
    commands = { "Leaderf" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/LeaderF",
    url = "https://github.com/Yggdroot/LeaderF"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["aerojump.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/aerojump.nvim",
    url = "https://github.com/ripxorip/aerojump.nvim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/asynctasks.vim",
    url = "https://github.com/skywind3000/asynctasks.vim"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\nf\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14log_level\tinfo\25auto_session_enabled\2\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\n \1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0026\3\6\0009\3\a\0039\3\b\3=\3\t\2B\0\2\1K\0\1\0\ftimeout\15timeoutlen\6o\bvim\fmapping\1\0\2\22clear_empty_lines\2\tkeys\n<Esc>\1\2\0\0\ajj\nsetup\18better_escape\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/better-escape.nvim",
    url = "https://github.com/max397574/better-escape.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-fuzzy-buffer"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-fuzzy-buffer",
    url = "https://github.com/tzachar/cmp-fuzzy-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after = { "nvim-lspconfig" },
    after_files = { "/home/randyt/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-nvim-tags"] = {
    after_files = { "/home/randyt/.local/share/nvim/site/pack/packer/opt/cmp-nvim-tags/after/plugin/cmp_nvim_tags.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/cmp-nvim-tags",
    url = "https://github.com/quangnguyen30192/cmp-nvim-tags"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-tabnine"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  ["cmp-tmux"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-tmux",
    url = "https://github.com/andersevenrud/cmp-tmux"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["colorbuddy.vim"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/colorbuddy.vim",
    url = "https://github.com/tjdevries/colorbuddy.vim"
  },
  ["committia.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/committia.vim",
    url = "https://github.com/rhysd/committia.vim"
  },
  delimitMate = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/delimitMate",
    url = "https://github.com/Raimondi/delimitMate"
  },
  ["diaglist.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/diaglist.nvim",
    url = "https://github.com/onsails/diaglist.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["filetype.nvim"] = {
    config = { "\27LJ\2\nO\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\14overrides\1\0\0\nsetup\rfiletype\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["fuzzy.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/fuzzy.nvim",
    url = "https://github.com/tzachar/fuzzy.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.statusline\frequire\0" },
    load_after = {
      ["nvim-web-devicons"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/galaxyline.nvim",
    url = "https://github.com/glepnir/galaxyline.nvim"
  },
  ["gen_tags.vim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/gen_tags.vim",
    url = "https://github.com/jsfaint/gen_tags.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.gitsign\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  ["haskell-vim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24config.lang.haskell\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/haskell-vim",
    url = "https://github.com/neovimhaskell/haskell-vim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15config.hop\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18config.indent\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["julia-vim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.lang.julia\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/julia-vim",
    url = "https://github.com/JuliaEditorSupport/julia-vim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  neoformat = {
    commands = { "Neoformat" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.formatter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\nÍ\1\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\nsigns\thunk\1\3\0\0\bïƒš\bï¸\titem\1\3\0\0\bï‚¤\bï‚§\fsection\1\0\0\1\3\0\0\bï»\bï¼\17integrations\1\0\1\tkind\16split_above\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  neomake = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.neomake\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/neomake",
    url = "https://github.com/neomake/neomake"
  },
  ["nnn.nvim"] = {
    commands = { "NnnPicker", "NnnExplorer" },
    config = { "\27LJ\2\n¾\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vpicker\1\0\0\nstyle\1\0\1\vborder\vshadow\1\0\2\fsession\vshared\bcmdFNNN_PLUG=\"p:preview-tui\" ICONLOOKUP=1 tmux new-session nnn -a -Pp\nsetup\bnnn\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nnn.nvim",
    url = "https://github.com/luukvbaal/nnn.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.autopairs\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15config.bqf\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    after = { "cmp-nvim-lsp" },
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.nvim-cmp\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.dap_config\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28config.dap_config.dapui\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-hlslens"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-hs.vim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/nvim-hs.vim",
    url = "https://github.com/neovimhaskell/nvim-hs.vim"
  },
  ["nvim-lsp-installer"] = {
    after = { "nvim-lspconfig" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15config.lsp\frequire\0" },
    load_after = {
      ["nvim-lsp-installer"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/nvim-lsputils",
    url = "https://github.com/RishabhRD/nvim-lsputils"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\ne\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0'\2\4\0B\0\2\1K\0\1\0\vnotify\19load_extension\14telescope\18config.notify\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-reload"] = {
    commands = { "Reload", "Restart" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-reload",
    url = "https://github.com/famiu/nvim-reload"
  },
  ["nvim-tmux-navigation"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/nvim-tmux-navigation",
    url = "https://github.com/alexghergh/nvim-tmux-navigation"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeRefresh", "NvimTreeToggle" },
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.nvimtree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "colorbuddy.vim" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    after = { "galaxyline.nvim" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["open-browser.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/open-browser.vim",
    url = "https://github.com/tyru/open-browser.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/popfix",
    url = "https://github.com/RishabhRd/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["searchbox.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/searchbox.nvim",
    url = "https://github.com/VonHeikemen/searchbox.nvim"
  },
  ["split-term.vim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/split-term.vim",
    url = "https://github.com/vimlab/split-term.vim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.symbols\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  tabular = {
    after_files = { "/home/randyt/.local/share/nvim/site/pack/packer/opt/tabular/after/plugin/TabularMaps.vim" },
    commands = { "Tabularize" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-dap.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bdap\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-lsp-handlers.nvim"] = {
    config = { "\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\17lsp_handlers\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/telescope-lsp-handlers.nvim",
    url = "https://github.com/gbrlsnchs/telescope-lsp-handlers.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope-repo.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/telescope-repo.nvim",
    url = "https://github.com/cljoly/telescope-repo.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.trouble\frequire\0" },
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["unicode.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/unicode.vim",
    url = "https://github.com/chrisbra/unicode.vim"
  },
  ["vim-clang-format"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-clang-format",
    url = "https://github.com/rhysd/vim-clang-format"
  },
  ["vim-colortemplate"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/vim-colortemplate",
    url = "https://github.com/lifepillar/vim-colortemplate"
  },
  ["vim-cool"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-easy-align"] = {
    commands = { "EasyAlign" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-flog"] = {
    commands = { "Flog" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-flog",
    url = "https://github.com/rbong/vim-flog"
  },
  ["vim-fugitive"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-grammarous"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/vim-grammarous",
    url = "https://github.com/rhysd/vim-grammarous"
  },
  ["vim-gruvbox8"] = {
    loaded = true,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/start/vim-gruvbox8",
    url = "https://github.com/lifepillar/vim-gruvbox8"
  },
  ["vim-gutentags"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-gutentags",
    url = "https://github.com/ludovicchabant/vim-gutentags"
  },
  ["vim-hexokinase"] = {
    commands = { "HexokinaseToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-hexokinase",
    url = "https://github.com/RRethy/vim-hexokinase"
  },
  ["vim-indent-object"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-markdownfootnotes"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-markdownfootnotes",
    url = "https://github.com/vim-pandoc/vim-markdownfootnotes"
  },
  ["vim-matchup"] = {
    after_files = { "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-rooter"] = {
    commands = { "Rooter" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-surround"] = {
    load_after = {
      ["wildfire.vim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-tmux",
    url = "https://github.com/tmux-plugins/vim-tmux"
  },
  ["vim-visual-multi"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vista.vim"] = {
    commands = { "Vista" },
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16config.tags\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["wildfire.vim"] = {
    after = { "vim-surround" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/randyt/.local/share/nvim/site/pack/packer/opt/wildfire.vim",
    url = "https://github.com/gcmt/wildfire.vim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^dap"] = "nvim-dap",
  ["^dapui"] = "nvim-dap-ui",
  ["^nvim%-treesitter"] = "nvim-treesitter",
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: vim-hexokinase
time([[Setup for vim-hexokinase]], true)
try_loadstring("\27LJ\2\n”\1\0\0\2\0\6\0\t6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0K\0\1\0\1\6\0\0\rfull_hex\brgb\trgba\bhsl\thsla\29Hexokinase_optInPatterns\1\2\0\0\19foregroundfull\28Hexokinase_highlighters\6g\bvim\0", "setup", "vim-hexokinase")
time([[Setup for vim-hexokinase]], false)
-- Setup for: committia.vim
time([[Setup for committia.vim]], true)
vim.cmd('packadd committia.vim')
time([[Setup for committia.vim]], false)
-- Setup for: vim-rooter
time([[Setup for vim-rooter]], true)
try_loadstring("\27LJ\2\n®\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0K\0\1\0\1\3\0\0\t.git\15Cargo.toml\20rooter_patterns\fcurrent2rooter_change_directory_for_non_project_files\23rooter_manual_only\6g\bvim\0", "setup", "vim-rooter")
time([[Setup for vim-rooter]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\nf\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14log_level\tinfo\25auto_session_enabled\2\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.trouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: julia-vim
time([[Config for julia-vim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.lang.julia\frequire\0", "config", "julia-vim")
time([[Config for julia-vim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.comment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: telescope-lsp-handlers.nvim
time([[Config for telescope-lsp-handlers.nvim]], true)
try_loadstring("\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\17lsp_handlers\19load_extension\14telescope\frequire\0", "config", "telescope-lsp-handlers.nvim")
time([[Config for telescope-lsp-handlers.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.gitsign\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: haskell-vim
time([[Config for haskell-vim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24config.lang.haskell\frequire\0", "config", "haskell-vim")
time([[Config for haskell-vim]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)
-- Config for: telescope-dap.nvim
time([[Config for telescope-dap.nvim]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bdap\19load_extension\14telescope\frequire\0", "config", "telescope-dap.nvim")
time([[Config for telescope-dap.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: telescope-fzf-native.nvim
time([[Config for telescope-fzf-native.nvim]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0", "config", "telescope-fzf-native.nvim")
time([[Config for telescope-fzf-native.nvim]], false)
-- Config for: neomake
time([[Config for neomake]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.neomake\frequire\0", "config", "neomake")
time([[Config for neomake]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\14overrides\1\0\0\nsetup\rfiletype\frequire\0", "config", "filetype.nvim")
time([[Config for filetype.nvim]], false)
-- Config for: better-escape.nvim
time([[Config for better-escape.nvim]], true)
try_loadstring("\27LJ\2\n \1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0026\3\6\0009\3\a\0039\3\b\3=\3\t\2B\0\2\1K\0\1\0\ftimeout\15timeoutlen\6o\bvim\fmapping\1\0\2\22clear_empty_lines\2\tkeys\n<Esc>\1\2\0\0\ajj\nsetup\18better_escape\frequire\0", "config", "better-escape.nvim")
time([[Config for better-escape.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lspkind-nvim ]]
vim.cmd [[ packadd nvim-cmp ]]

-- Config for: nvim-cmp
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.nvim-cmp\frequire\0", "config", "nvim-cmp")

vim.cmd [[ packadd cmp-nvim-lsp ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neoformat lua require("packer.load")({'neoformat'}, { cmd = "Neoformat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Reload lua require("packer.load")({'nvim-reload'}, { cmd = "Reload", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Restart lua require("packer.load")({'nvim-reload'}, { cmd = "Restart", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Tabularize lua require("packer.load")({'tabular'}, { cmd = "Tabularize", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file EasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "EasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NnnPicker lua require("packer.load")({'nnn.nvim'}, { cmd = "NnnPicker", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Leaderf lua require("packer.load")({'LeaderF'}, { cmd = "Leaderf", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Rooter lua require("packer.load")({'vim-rooter'}, { cmd = "Rooter", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Flog lua require("packer.load")({'vim-flog'}, { cmd = "Flog", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NnnExplorer lua require("packer.load")({'nnn.nvim'}, { cmd = "NnnExplorer", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HexokinaseToggle lua require("packer.load")({'vim-hexokinase'}, { cmd = "HexokinaseToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeRefresh lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeRefresh", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Vista lua require("packer.load")({'vista.vim'}, { cmd = "Vista", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType haskell ++once lua require("packer.load")({'nvim-treesitter', 'nvim-lsp-installer', 'cmp-nvim-tags'}, { ft = "haskell" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'nvim-treesitter', 'vim-clang-format', 'nvim-lsp-installer', 'cmp-nvim-tags'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'nvim-treesitter', 'vim-clang-format', 'nvim-lsp-installer', 'cmp-nvim-tags'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType h ++once lua require("packer.load")({'vim-clang-format'}, { ft = "h" }, _G.packer_plugins)]]
vim.cmd [[au FileType bash ++once lua require("packer.load")({'nvim-lsp-installer'}, { ft = "bash" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'nvim-treesitter', 'nvim-lsp-installer'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'vim-markdownfootnotes', 'nvim-lsp-installer'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-lsp-installer'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType toml ++once lua require("packer.load")({'nvim-treesitter', 'nvim-lsp-installer'}, { ft = "toml" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'nvim-treesitter', 'nvim-lsp-installer'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType tmux ++once lua require("packer.load")({'vim-tmux'}, { ft = "tmux" }, _G.packer_plugins)]]
vim.cmd [[au FileType json ++once lua require("packer.load")({'nvim-treesitter', 'nvim-lsp-installer'}, { ft = "json" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'nvim-treesitter', 'nvim-lsp-installer'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType sh ++once lua require("packer.load")({'nvim-lsp-installer'}, { ft = "sh" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-treesitter', 'nvim-lsp-installer'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType fish ++once lua require("packer.load")({'nvim-treesitter'}, { ft = "fish" }, _G.packer_plugins)]]
vim.cmd [[au FileType hpp ++once lua require("packer.load")({'vim-clang-format'}, { ft = "hpp" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { event = "FileType qf" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'delimitMate', 'vim-visual-multi'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au User InGitRepo ++once lua require("packer.load")({'vim-fugitive'}, { event = "User InGitRepo" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'unicode.vim', 'vim-cool', 'open-browser.vim', 'packer.nvim', 'vim-indent-object', 'vim-matchup', 'which-key.nvim', 'hop.nvim', 'vim-gutentags', 'targets.vim', 'nvim-hlslens'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'nvim-notify'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'wildfire.vim', 'indent-blankline.nvim', 'nvim-web-devicons', 'nvim-bufferline.lua'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fusion.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fusion.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fusion.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glimmer.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glimmer.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glimmer.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glsl.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glsl.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glsl.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gowork.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gowork.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gowork.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hack.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hack.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hack.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hjson.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hjson.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hjson.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/prisma.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/prisma.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/prisma.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/pug.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/pug.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/pug.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/vim-tmux/ftdetect/tmux.vim]], true)
vim.cmd [[source /home/randyt/.local/share/nvim/site/pack/packer/opt/vim-tmux/ftdetect/tmux.vim]]
time([[Sourcing ftdetect script at: /home/randyt/.local/share/nvim/site/pack/packer/opt/vim-tmux/ftdetect/tmux.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
