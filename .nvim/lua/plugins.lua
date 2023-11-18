-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local utils = require("utils")

local fn = vim.fn

local map = require('utils').map

-- Only required if you have packer configured as `opt`


return require('lazy').setup(
  {
    --================ NVIM PACKAGE MANAGER ==================================
    -- Packer can manage itself
    { 'wbthomason/packer.nvim',      event = "VimEnter" },

    -- Plugin management
    { 'folke/neodev.nvim' },
    --=================== EDITOR SETUP ================================
    -- More Icons
    { 'nvim-tree/nvim-web-devicons', event = "BufRead" },
    --  specific branch, dependency and build lua file after load

    -- Status line
    {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      after = "nvim-web-devicons",
      config = function() require("config.statusline") end
    },
    -- Add indent object for vim (ful for languages like Python)
    { "michaeljsmith/vim-indent-object", event = "VimEnter" },


    -- nvim-bufferline: better buffer line--
    {
      'akinsho/nvim-bufferline.lua',
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function() require("config.bufferline") end,
      event = "BufRead"
    },
    -- more symbols
    {
      'simrat39/symbols-outline.nvim',
      config = function() require("config.symbols") end,
      cmd = "SymbolsOutline"
    },
    { "chrisbra/unicode.vim",            event = "VimEnter" },
    -- show color at words
    {
      'RRethy/vim-hexokinase',
      build = 'make',
      cmd = "HexokinaseToggle",
      init = function()
        vim.g.Hexokinase_highlighters = { 'foregroundfull' }
        vim.g.Hexokinase_optInPatterns = {
          'full_hex', 'rgb', 'rgba', 'hsl', 'hsla'
        }
      end
    },
    {
      'vimlab/split-term.vim'
    },
    -- Document Explorer
    {
      'kyazdani42/nvim-tree.lua',
      config = function() require("config.nvimtree") end,
      cmd = { "NvimTreeRefresh", "NvimTreeToggle" },
    },
    -- Dependency: tmux, nnn
    -- This is heavily based on my configured nnn
    {
      "luukvbaal/nnn.nvim",
      config = function()
        require("nnn").setup({
          picker = {
            cmd = [[NNN_PLUG="p:preview-tui" ICONLOOKUP=1 tmux new-session nnn -a -Pp]],
            style = { border = "shadow" },
            session = "shared"
          },
        })
      end,
      cmd = { 'NnnPicker', 'NnnExplorer' },
    },
    {
      'VonHeikemen/searchbox.nvim',
      dependencies = { 'MunifTanjim/nui.nvim' },
    },
    {
      'alexghergh/nvim-tmux-navigation'
    },
    -- Visual Guide
    --
    {
      'HiPhish/rainbow-delimiters.nvim'
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function() require("config.indent") end,
      event = 'BufRead'
    },

    -- Comment plugin
    {
      "numToStr/Comment.nvim",
      config = function() require("config.comment") end,
    },
    -- Float Terminal
    { 'voldikss/vim-floaterm' },
    ---- === Searching =======
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
      config = function() require("config.telescope") end,
      module = 'telescope'
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function() require('telescope').load_extension('fzf') end,
    },
    {
      'tzachar/fuzzy.nvim', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' }
    },
    {
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      config = function() require('telescope').load_extension('lsp_handlers') end

    },
    {
      'cljoly/telescope-repo.nvim'
    },
    {
      'nvim-telescope/telescope-project.nvim'
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      config = function() require('telescope').load_extension('frecency') end,
      dependencies = { 'tami5/sqlite.lua' },
    },
    -- search emoji and other symbols
    { 'nvim-telescope/telescope-symbols.nvim' },
    {
      'luc-tielen/telescope_hoogle',
      config = function() require('telescope').load_extension('hoogle') end

    },
    {
      'crispgm/telescope-heading.nvim',
      config = function() require('telescope').load_extension('heading') end,
    },
    {
      'nvim-telescope/telescope-hop.nvim',
      config = function() require('telescope').load_extension('hop') end
    },
    {
      'camgraff/telescope-tmux.nvim',
      dependencies = { 'norcalli/nvim-terminal.lua' },
      config = function() require('telescope').load_extension('tmux') end
    },
    {
      'benfowler/telescope-luasnip.nvim',
      config = function() require('telescope').load_extension('luasnip') end
    },
    -- Fuzzy Finder
    --         { 'amirrezaask/fuzzy.nvim', requires={'nvim-lua/plenary.nvim'}, , module = 'fuzzy_nvim'},
    {
      'junegunn/fzf',
      build = function()
        vim.fn['fzf#install']()
      end
    },

    -- File search, tag search and more

    { "Yggdroot/LeaderF",                     cmd = "Leaderf",   build = ":LeaderfInstallCExtension" },

    -- Clear highlight search automatically for you
    { "romainl/vim-cool",                     event = "VimEnter" },

    -- Show match number for search
    {
      'kevinhwang91/nvim-hlslens',
      config = function() require('hlslens').setup() end,
      branch = 'dev',
      event = "VimEnter"
    },
    -- Super fast buffer jump
    {
      'phaazon/hop.nvim',
      event = "VimEnter",
      config = function() require('config.hop') end
    },
    {
      "mfussenegger/nvim-treehopper",
    },
    { 'ripxorip/aerojump.nvim' },
    -- Better Escape
    {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup {
          mapping = { "jj" },         -- a table with mappings to
          timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms.  option timeoutlen by default
          clear_empty_lines = true,   -- clear line after escaping if there is only whitespace
          keys = "<Esc>",             -- keys d for escaping, if it is a function will  the result everytime
        }
      end
    },

    -- mulit cursor
    { 'mg979/vim-visual-multi', event = "InsertEnter", branch = 'master' },

    {
      'famiu/nvim-reload',
      cmd = { "Reload", "Restart" },
      dependencies = "nvim-lua/plenary.nvim"
    },
    -- align
    {
      'junegunn/vim-easy-align',
      cmd = 'EasyAlign',
      config = function() require('config.align') end,
    },

    -- speed up neovim!
    {
      'nathom/filetype.nvim',
      config = function()
        require("filetype").setup({
          -- overrides the filetype or function for filetype
          -- See https://github.com/nathom/filetype.nvim#customization
          overrides = {
            extensions = {
              h = "c",
              hpp = "cpp",
            },
          },
        })
      end
    },

    { "ggandor/lightspeed.nvim" },

    {
      'airblade/vim-rooter',
      cmd = "Rooter",
      init = function()
        vim.g.rooter_manual_only = 1
        vim.g.rooter_change_directory_for_non_project_files = 'current'
        vim.g.rooter_patterns = { '.git', 'Cargo.toml' }
      end
    },



    -- Undo Histroy
    { "mbbill/undotree",        cmd = "UndotreeToggle" },

    -- Session management plugin

    -- Session management
    {
      "rmagatti/auto-session",
      config = function()
        require('auto-session').setup {
          log_level = 'info',
          auto_session_enabled = true,
        }
      end
    },
    {
      'rmagatti/session-lens',
      dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
      config = function()
        require('session-lens').setup({
          previewer = true,
        })
        require("telescope").load_extension("session-lens")
      end
    },


    -- notification plugin
    { 'nvim-lua/popup.nvim' },
    { 'anuvyklack/hydra.nvim' },
    {
      "rcarriga/nvim-notify",
      event = "BufEnter",
      require = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary' },
      config = function()
        require('config.notify')
        require('telescope').load_extension("notify")
      end
    },

    -- showing keybindings
    {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function() require('config.which-key') end
    },

    { "tyru/open-browser.vim",       event = "VimEnter" },


    -- Neovim Color Theme
    { 'lifepillar/vim-gruvbox8' },
    { 'lifepillar/vim-colortemplate' },
    { 'sainnhe/gruvbox-material' },
    { 'rebelot/kanagawa.nvim' },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },



    -- Load on an autocommand event
    {
      'andymass/vim-matchup',
      init = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
      event = 'VimEnter'
    },

    -- ====================== Completion =================================================================


    -- completeion source
    { "hrsh7th/cmp-nvim-lua",                 dependencies = { "hrsh7th/nvim-cmp" }, },
    { "hrsh7th/cmp-path",                     dependencies = { "hrsh7th/nvim-cmp" }, },
    { "hrsh7th/cmp-buffer",                   dependencies = { "hrsh7th/nvim-cmp" }, },
    { "tzachar/cmp-fuzzy-buffer",             dependencies = { "hrsh7th/nvim-cmp", 'tzachar/fuzzy.nvim' }, },
    { "lukas-reineke/cmp-rg",                 dependencies = { "hrsh7th/nvim-cmp" }, },
    { "tzachar/cmp-tabnine",                  install = { "./install.sh" },                                dependencies = { "hrsh7th/nvim-cmp" }, },
    { "lukas-reineke/cmp-under-comparator",   dependencies = { "hrsh7th/nvim-cmp" }, },
    { "ray-x/cmp-treesitter",                 dependencies = { "hrsh7th/nvim-cmp" }, },
    { "hrsh7th/cmp-nvim-lsp-document-symbol", dependencies = { "hrsh7th/nvim-cmp" }, },
    { "hrsh7th/cmp-nvim-lsp-signature-help",  dependencies = { "hrsh7th/nvim-cmp" }, },
    { "f3fora/cmp-spell",                     dependencies = { "hrsh7th/nvim-cmp" }, },
    { "andersevenrud/cmp-tmux",               dependencies = { "hrsh7th/nvim-cmp" }, },
    { "hrsh7th/cmp-cmdline",                  dependencies = { "hrsh7th/nvim-cmp" }, },
    { "quangnguyen30192/cmp-nvim-tags",       dependencies = { "hrsh7th/nvim-cmp" },                       ft = { 'haskell', 'c', 'cpp', 'h', 'hpp' }, },
    { "kdheepak/cmp-latex-symbols",           dependencies = { "hrsh7th/nvim-cmp", }, },
    { 'onsails/lspkind-nvim' },
    {
      "hrsh7th/nvim-cmp",
      after = "lspkind-nvim",
      config = function() require('config.nvim-cmp') end
    },


    -- lsp completion sources
    --     {'prabirshrestha/vim-lsp'},
    --    {'mattn/vim-lsp-settings'},
    --    {'dmitmel/cmp-vim-lsp'},
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    --[[   {
    'williamboman/nvim-lsp-installer',
    ft = {
      "bash", "sh", "rust", "haskell", "c", "cpp", "lua", "markdown", "go", "html",
      "toml", "json", "python", "dart","v","vhdl","verilog"
    },
  }, ]]
    {
      "williamboman/mason.nvim"
    },
    {
      "williamboman/mason-lspconfig.nvim"
    },
    {
      "neovim/nvim-lspconfig",
      after = { "cmp-nvim-lsp", "mason.nvim", "mason-lspconfig.nvim" },
      config = function() require('config.lsp') end
    },



    -- Gramma Check
    { 'rhysd/vim-grammarous' },

    -- syntax diagnostic
    --     {
    --       'dense-analysis/ale',
    --       ft = {'sh', 'zsh','haskell', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    --        config = function() require('config.ale') end,
    --       cmd = 'ALEEnable',
    --  },
    {
      'neomake/neomake',
      config = function() require('config.neomake') end
    },
    {
      'folke/trouble.nvim',
      config = function() require('config.trouble') end
    },

    { 'ray-x/lsp_signature.nvim' },
    { 'ray-x/guihua.lua',             build = 'cd lua/fzy && make' },
    { 'onsails/diaglist.nvim' },
    { 'RishabhRd/popfix' },
    { 'RishabhRD/nvim-lsputils' },
    { 'tami5/lspsaga.nvim' },
    -- Only install these plugins if ctags are installed on the system
    -- plugin to manage your tags
    { "ludovicchabant/vim-gutentags", event = "VimEnter" },
    -- show file tags in vim window
    {
      "liuchengxu/vista.vim",
      cmd = "Vista",
      config = function() require("config.tags") end
    },
    -- async tags generation
    --  { 'jsfaint/gen_tags.vim' },



    -- Quick Fix Preview
    {
      "kevinhwang91/nvim-bqf",
      event = "FileType qf",
      config = function() require('config.bqf') end
    },
    -- Autoformat tools
    --  { "sbdchd/neoformat", cmd = { "Neoformat" }, config = function() require('config.formatter') end },
    { 'mhartington/formatter.nvim' },
    -- Linter
    { 'mfussenegger/nvim-lint' },
    -- luasnip snippet
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },

    -- treesitter: support more colorful highlighting
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      ft = { "cpp", "toml", "rust", "go", "json", "lua", "fish", "c", 'h', 'hpp', 'haskell', 'python', 'dart' },
      config = function() require('config.treesitter') end,
      module = "nvim-treesitter",
    },
    {
      'nvim-treesitter/nvim-treesitter-refactor',
      require = { 'nvim-treesitter/nvim-treesitter-refractor' },
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    -- You can specify multiple plugins in a single call
    { 'tjdevries/colorbuddy.vim',                   after = 'nvim-treesitter' },


    -- auto pairs
    {
      'windwp/nvim-autopairs',
      config = function() require('config.autopairs') end
    },

    {
      "machakann/vim-sandwich"
    },
    -- Select text object
    { 'gcmt/wildfire.vim',    event = "BufRead" },

    -- surrounding select text with given text
    { "tpope/vim-surround",   after = "wildfire.vim" },

    -- Automatic insertion and deletion of a pair of characters
    { "Raimondi/delimitMate", event = "InsertEnter" },


    -- Additional powerful text object for vim, this plugin should be studied
    -- carefully to  its full power
    { "wellle/targets.vim",   event = "VimEnter" },
    --  {
    -- "nvim-neorg/neorg",
    -- config = function()
    -- require('neorg').setup {
    -- -- Tell Neorg what modules to load
    -- load = {
    -- ["core.defaults"] = {}, -- Load all the default modules
    -- ["core.norg.concealer"] = {}, -- Allows for  of icons
    -- ["core.norg.dirman"] = { -- Manage your directories with Neorg
    -- config = {
    -- workspaces = {
    -- my_workspace = "~/neorg"
    -- },
    -- },
    -- },
    -- },
    -- },
    -- end,
    -- requires = "nvim-lua/plenary.nvim"
    -- },
    -- ====================== Debuggers ======================
    {
      'mfussenegger/nvim-dap',
      module = 'dap',
      module_pattern = "dap_",
      config = function()
        require("config.dap_config.dap")
      end
    },
    {
      'nvim-telescope/telescope-dap.nvim',
      config = function() require('telescope').load_extension('dap') end
    },


    {
      'rcarriga/nvim-dap-ui',
      config = function() require('config.dap_config.dapui') end,
      module = "dapui",
    },
    { "sakhnik/nvim-gdb",           build = { "bash install.sh" },   opt = true, },

    -- ======================== buildner =====================
    { 'skywind3000/asynctasks.vim' },
    { 'skywind3000/asyncrun.vim' },


    -- ===================== Build Tools ==================================

    { 'tpope/vim-dispatch',         opt = true,                      cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }, },



    -- =================== Language Specific =============================

    -- C/CPP
    { 'rhysd/vim-clang-format',     ft = { 'cpp', 'c', 'h', 'hpp' }, },
    { 'p00f/clangd_extensions.nvim' },
    -- Haskell
    { 'neovimhaskell/nvim-hs.vim' },

    {
      'neovimhaskell/haskell-vim',
      config = function() require("config.lang.haskell") end
    },

    -- Julia
    {
      'JuliaEditorSupport/julia-vim',
      config = function() require("config.lang.julia") end
    },

    -- Flutter
    {
      'akinsho/flutter-tools.nvim',
      dependencies = 'nvim-lua/plenary.nvim',
      config = function() require("config.lang.flutter") end
    },
















    -- Since tmux is only available on Linux and Mac, we only enable these plugins
    -- for Linux and Mac
    -- .tmux.conf syntax highlighting and setting check
    { "tmux-plugins/vim-tmux", ft = { "tmux" }, },

    -- ======================= GIT ================================
    -- Better git commit experience
    { "rhysd/committia.vim",   opt = true },
    -- git information
    {
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function() require("config.gitsign") end
    },


    -- Git command inside vim
    -- { "tpope/vim-fugitive", event = "r InGitRepo" },

    -- Better git log display
    { "rbong/vim-flog",                   dependencies = "tpope/vim-fugitive", cmd = { "Flog" }, },

    {
      'TimUntersberger/neogit',
      dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
      config = function()
        require('neogit').setup {
          integrations = { diffview = true },
          -- Change the default way of opening neogit
          kind = "split_above",
          -- customize displayed signs
          signs = {
            -- { CLOSED, OPENED },
            section = { "", "" },
            item = { "", "" },
            hunk = { "", "" },
          },
        }
      end,
      cmd = "Neogit"
    },


    -- Mark Down Plugins
    -- Another markdown plugin
    { "plasticboy/vim-markdown",          ft = { "markdown" }, },

    -- Faster footnote generation
    { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" }, },
    -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    { "godlygeek/tabular",                cmd = { "Tabularize" }, },

  }
)
