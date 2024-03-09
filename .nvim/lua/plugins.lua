-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local utils = require("utils")
local fn = vim.fn
local map = require('utils').map
vim.cmd([[packadd termdebug]])
-- Only required if you have packer configured as `opt`
local function tabnine_build_path()
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return "pwsh.exe -file .\\dl_binaries.ps1"
  else
    return "./dl_binaries.sh"
  end
end

return require('lazy').setup(
  {
    --================ NVIM PACKAGE MANAGER ==================================
    -- Packer can manage itself
    { 'wbthomason/packer.nvim',  event = "VimEnter" },
    { 'lewis6991/impatient.nvim' },
    {
      "camspiers/luarocks",
      dependencies = {
        "rcarriga/nvim-notify", -- Optional dependency
      },
      opts = {
        rocks = { "openssl", "lua-http-parser" } -- Specify LuaRocks packages to install
      },
    },
    -- { 'nvim-neorocks/rocks.nvim' },
    -- ============  Mini Nvim ==============================
    -- Modules with default settings
    {
      'echasnovski/mini.nvim',
      version = 'false',
      config = function()
        local modules = {
          'mini.starter',
          'mini.bufremove',

        }
        for _, module in ipairs(modules) do
          require(module).setup()
        end
      end
    },

    { 'echasnovski/mini.surround',   version = '*',    opts = { search_method = 'cover_or_nearest' } },

    -- Plugin management
    { 'folke/neodev.nvim' },
    --=================== EDITOR SETUP ================================
    -- More Icons
    { 'nvim-tree/nvim-web-devicons', event = "BufRead" },
    {
      "ahmedkhalf/project.nvim",
      config = function() require('project_nvim').setup() end
    },
    --  specific branch, dependency and build lua file after load

    -- Status line
    {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      dependencies = "nvim-web-devicons",
      config = function() require("config.statusline") end
    },
    -- Add indent object for vim (ful for languages like Python)
    { "michaeljsmith/vim-indent-object", event = "BufEnter" },


    -- nvim-bufferline: better buffer line--
    {
      'akinsho/nvim-bufferline.lua',
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function() require("config.bufferline") end,
      event = "BufEnter"
    },
    { 'ThePrimeagen/harpoon' },
    -- more symbols
    {
      'simrat39/symbols-outline.nvim',
      config = function() require("config.symbols") end,
      cmd = "SymbolsOutline"
    },
    --[[ { "chrisbra/unicode.vim",            event = "BufEnter" }, ]]
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
    -- File Explorer
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
    -- {
    --   'VonHeikemen/searchbox.nvim',
    --   dependencies = { 'MunifTanjim/nui.nvim' },
    -- },
    {
      'alexghergh/nvim-tmux-navigation'
    },
    -- { 'otavioschwanck/tmux-awesome-manager.nvim',   config = function() require("config.term") end },
    -- Visual Guide
    --
    {
      'HiPhish/rainbow-delimiters.nvim'
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function() require("config.indent") end,
      event = 'BufEnter'
    },

    -- Comment plugin
    {
      "numToStr/Comment.nvim",
      config = function() require("config.comment") end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    -- Float Terminal
    {
      'akinsho/toggleterm.nvim',
      version = "*",
      config = true,
      opts = {
        open_mapping = [[c-\]],
        hide_numbers = true,
        autochdir = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'horizontal',
        lose_on_exit = true,
        auto_scroll = true,
        float_opts = {
          border = 'double'

        },
        winbar = {
          enabled = true,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end
        },
      }
    },
    ---- === Searching =======
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-pack/nvim-spectre' },
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
      config = function() require("config.telescope") end,
      module = 'telescope'
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',

      dependencies = { 'nvim-telescope/telescope.nvim' },
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',

    },
    {
      'tzachar/fuzzy.nvim', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', 'nvim-telescope/telescope.nvim' }
    },
    {
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      dependencies = { 'nvim-telescope/telescope.nvim' },
      config = function() require("telescope").load_extension('lsp_handlers') end,
    },
    {
      'cljoly/telescope-repo.nvim',

      dependencies = { 'nvim-telescope/telescope.nvim' },
      config = function() require("telescope").load_extension('repo') end,
    },
    {
      'nvim-telescope/telescope-project.nvim',
      config = function() require("telescope").load_extension('project') end,

      dependencies = { 'nvim-telescope/telescope.nvim' },
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      dependencies = { 'tami5/sqlite.lua', 'nvim-telescope/telescope.nvim' },
      config = function() require("telescope").load_extension('frecency') end,

    },
    -- search emoji and other symbols
    {
      'nvim-telescope/telescope-symbols.nvim',

      dependencies = { 'nvim-telescope/telescope.nvim' },
    },
    {
      'luc-tielen/telescope_hoogle',

      dependencies = { 'nvim-telescope/telescope.nvim' },

      config = function() require('telescope').load_extension('hoogle') end,
    },
    {
      'nvim-telescope/telescope-arecibo.nvim',
      opts = { rocks = { 'openssl', 'lua-http-parser' } },
      -- rocks = { 'openssl', 'lua-http-parser' }
    },
    {
      'crispgm/telescope-heading.nvim',

      config = function() require('telescope').load_extension('heading') end,
      dependencies = { 'nvim-telescope/telescope.nvim' },
    },
    {
      'nvim-telescope/telescope-hop.nvim',

      config = function() require('telescope').load_extension('hop') end,
      dependencies = { 'nvim-telescope/telescope.nvim' },
    },
    {
      'camgraff/telescope-tmux.nvim',
      dependencies = { 'norcalli/nvim-terminal.lua', 'nvim-telescope/telescope.nvim' },

      config = function() require('telescope').load_extension('tmux') end,
    },
    {
      'benfowler/telescope-luasnip.nvim',

      dependencies = { 'nvim-telescope/telescope.nvim' },
      config = function() require('telescope').load_extension('luasnip') end,

    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
      config = function()
        require("telescope").load_extension("live_grep_args")
      end
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

    -- { "Yggdroot/LeaderF", cmd = "Leaderf",   build = ":LeaderfInstallCExtension" },

    -- Clear highlight search automatically for you
    { "romainl/vim-cool",       event = "VimEnter" },
    {
      "m-demare/hlargs.nvim",
      opts = {
        extras = {
          named_parameters = true,
        }
      },
      config = function()
        require('hlargs').setup()
      end
    },
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
    -- {
    --   "smoka7/multicursors.nvim",
    --   config = function()
    --     require('multicursors').setup {
    --       hint_config = {
    --         border = 'rounded',
    --         position = 'bottom',
    --       },
    --       generate_hints = {
    --         normal = true,
    --         insert = true,
    --         extend = true,
    --         config = {
    --           column_count = 1,
    --         },
    --       },
    --       -- normal_keys = {
    --       --   ['<C-I>'] = {
    --       --     method = require('multicursors').new_under_cursor,
    --       --   }
    --       -- }
    --     }
    --   end
    -- },
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
    -- {
    --   "rmagatti/auto-session",
    --   config = function()
    --     require('auto-session').setup {
    --       log_level = 'info',
    --       auto_session_enabled = true,
    --     }
    --   end
    -- },
    {
      "Shatur/neovim-session-manager",
      config = function()
        local config = require('session_manager.config')
        require('session_manager').setup({
          autoload_mode = config.AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
          autosave_last_session = true,                    -- Automatically save last session on exit and on session switch.
          autosave_ignore_not_normal = true,               -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
          autosave_ignore_dirs = {},                       -- A list of directories where the session will not be autosaved.
          autosave_ignore_filetypes = {                    -- All buffers of these file types will be closed before the session is saved.
            'gitcommit',
            'gitrebase',
            'TOGGLETERM',
            'term',
            'trouble'

          },
        })
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
    { 'doums/suit.nvim',      config = true },
    {
      "rcarriga/nvim-notify",
      event = "BufEnter",
      dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
      config = function()
        require('config.notify')
      end
    },

    -- showing keybindings
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
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
    {
      'folke/twilight.nvim',
    },


    -- Load on an autocommand event

    -- ====================== Completion =================================================================


    -- completeion source
    { "hrsh7th/cmp-nvim-lua",                 dependencies = { "hrsh7th/nvim-cmp" }, },
    { "hrsh7th/cmp-path",                     dependencies = { "hrsh7th/nvim-cmp" }, },
    { "hrsh7th/cmp-buffer",                   dependencies = { "hrsh7th/nvim-cmp" }, },
    { "tzachar/cmp-fuzzy-buffer",             dependencies = { "hrsh7th/nvim-cmp", 'tzachar/fuzzy.nvim' }, },
    { "lukas-reineke/cmp-rg",                 dependencies = { "hrsh7th/nvim-cmp" }, },
    { "tzachar/cmp-tabnine",                  build = { "./install.sh" },                                  dependencies = { "hrsh7th/nvim-cmp" }, },
    { 'codota/tabnine-nvim',                  build = tabnine_build_path },
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
      dependencies = "lspkind-nvim",
      config = function() require('config.nvim-cmp') end
    },
    -- doc string generation

    {
      "danymat/neogen",
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = true,
      -- Uncomment next line if you want to follow only stable versions
      version = "*"
    },
    -- lsp completion sources
    --     {'prabirshrestha/vim-lsp'},
    --    {'mattn/vim-lsp-settings'},
    --    {'dmitmel/cmp-vim-lsp'},
    { "hrsh7th/cmp-nvim-lsp",         dependencies = "nvim-cmp" },

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    {
      'williamboman/nvim-lsp-installer',
      ft = {
        "bash", "sh", "rust", "haskell", "c", "cpp", "lua", "markdown", "go", "html",
        "toml", "json", "python", "dart", "v", "vhdl", "verilog", "mojo"
      },
    },
    {
      "williamboman/mason.nvim"
    },
    {
      "williamboman/mason-lspconfig.nvim"
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = { "cmp-nvim-lsp", "mason.nvim", "mason-lspconfig.nvim" },
      config = function() require('config.lsp') end
    },
    { "jay-babu/mason-nvim-dap.nvim", config = function() require('mason-nvim-dap').setup() end },


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
    -- {
    --   'simrat39/symbols-outline.nvim',
    --   config = function()
    --     require('symbols-outline').setup()
    --   end,
    --
    -- },
    -- async tags generation
    --  { 'jsfaint/gen_tags.vim' },



    -- Quick Fix Preview
    {
      "kevinhwang91/nvim-bqf",
      event = "FileType qf",
      config = function() require('config.bqf') end
    },
    { 'gabrielpoca/replacer.nvim' },
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
      ft = { "cpp", "toml", "rust", "go", "json", "lua", "fish", "c", 'h', 'hpp', 'haskell', 'python', 'dart', 'pkl' },
      config = function() require('config.treesitter') end,
    },
    {
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        vim.cmd("TSContextEnable")
      end,
      event = "VimEnter",
    },
    { 'theHamsta/nvim-treesitter-pairs' },
    { 'RRethy/nvim-treesitter-endwise' },
    -- { 'ziontee113/syntax-tree-surfer' },
    { "theHamsta/crazy-node-movement" },
    { 'apple/pkl-neovim' },
    -- You can specify multiple plugins in a single call
    { 'tjdevries/colorbuddy.vim',                   dependencies = 'nvim-treesitter' },


    -- auto pairs
    {
      'windwp/nvim-autopairs',
      config = function() require('config.autopairs') end
    },

    -- Select text object
    { 'gcmt/wildfire.vim',    event = "BufRead" },

    -- surrounding select text with given text
    -- { "tpope/vim-surround",   dependencies = "wildfire.vim" },
    -- {      "machakann/vim-sandwich"    },

    -- Automatic insertion and deletion of a pair of characters
    { "Raimondi/delimitMate", event = "InsertEnter" },

    {
      'andymass/vim-matchup',
      init = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
    },

    -- Additional powerful text object for vim, this plugin should be studied
    -- carefully to  its full power
    { "wellle/targets.vim",             event = "VimEnter" },
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
      main = 'dap',
      module_pattern = "dap_",
      config = function()
        require("config.dap_config.dap")
      end
    },
    {
      'nvim-telescope/telescope-dap.nvim',
      dependencies = { 'nvim-telescope/telescope.nvim' },
    },


    {
      'rcarriga/nvim-dap-ui',
      config = function() require('config.dap_config.dapui') end,
      dependencies = { 'nvim-telescope/telescope.nvim' },

      main = "dapui",
    },
    { "sakhnik/nvim-gdb",               build = { "bash install.sh" }, lazy = true, },
    { "theHamsta/nvim-dap-virtual-text" },

    -- ======================== buildner =====================
    { 'skywind3000/asynctasks.vim' },
    { 'skywind3000/asyncrun.vim' },
    { 'stevearc/overseer.nvim',         opts = {},                     config = function() require("config.task") end },

    -- ===================== Build Tools ==================================

    { 'tpope/vim-dispatch',             lazy = true,                   cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }, },



    -- =================== Language Specific =============================

    -- C/CPP
    {
      'Civitasv/cmake-tools.nvim',
      dependencies = { 'stevearc/overseer.nvim' },
      opts = {},
      commit = 'aba5b805082b3c1027ac4f5051b84c61989c34c8'
    },
    { 'rhysd/vim-clang-format',     ft = { 'cpp', 'c', 'h', 'hpp' }, },
    { 'p00f/clangd_extensions.nvim' },
    -- Rust
    { "rust-lang/rust.vim",         ft = { 'rust' },                 config = function() vim.g.rustfmt_autorsave = 1 end },
    {
      'simrat39/rust-tools.nvim',
      version = '*', -- Recommended
      ft = { 'rust' },
    },
    {
      'saecki/crates.nvim',
      ft = { "rust", "toml" },
      config = function(_, opts)
        local crates = require('crates')
        crates.setup(opts)
        crates.show()
      end
    },
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

    ------ Mojo
    {
      'czheo/mojo.vim',
      ft = { "mojo" },
      init = function()
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
          pattern = { "*.🔥" },
          callback = function()
            if vim.bo.filetype ~= "mojo" then
              vim.bo.filetype = "mojo"
            end
          end,
        })
      end,

    },


    ---- === Macro =======
    { 'ecthelionvi/NeoComposer.nvim' },

    -- ===== Docker =================================================================
    { "kkvh/vim-docker-tools" },
    { "jamestthompson3/nvim-remote-containers" },
    { 'jamestthompson3/nvim-remote-containers' },







    -- Since tmux is only available on Linux and Mac, we only enable these plugins
    -- for Linux and Mac
    -- .tmux.conf syntax highlighting and setting check
    { "tmux-plugins/vim-tmux",                 ft = { "tmux" }, },

    -- ======================= GIT ================================
    -- Better git commit experience
    { "rhysd/committia.vim",                   lazy = true },
    { 'akinsho/git-conflict.nvim',             version = "*",   config = true },
    -- git information
    {
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function() require("config.gitsign") end
    },
    {
      "wintermute-cell/gitignore.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim" -- optional: for multi-select
      }
    },


    -- Git command inside vim
    { "tpope/vim-fugitive",          ft = "Git" },

    -- Better git log display
    {
      "rbong/vim-flog",
      lazy = true,
      cmd = { "Flog", "Flogsplit", "Floggit" },
      dependencies = {
        "tpope/vim-fugitive",
      },
    },
    {
      'tanvirtin/vgit.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim'
      },
      config = function() require("vgit").setup() end
    },


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

    -- Document Searching
    {
      "luckasRanarison/nvim-devdocs",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require('nvim-devdocs').setup({
          filetypes = {
            cpp = { "eigen3", "cpp", "point_cloud_library" },
            rust = "rust",
            lua = "lua",
            python = { "python-3.11", "pytorch", "numpy-1.23", "scikit-image", "scikit-learn" }
          },
          previewer_cmd = "glow",
          cmd_args = { "-s", "dracula", "-w", "50" },
          picker_cmd = true,
          picker_cmd_args = { "-s", "dracula", "-w", "50" },

        })
      end,

    },
    -- { 'KabbAmine/zeavim.vim' },
    {
      'mrjones2014/dash.nvim',
      build = 'make install',
    },
    -- Mark Down Plugins
    -- Another markdown plugin
    { "plasticboy/vim-markdown",     ft = { "markdown" }, },
    { 'vim-pandoc/vim-pandoc' },
    { 'vim-pandoc/vim-pandoc-syntax' },
    {
      "jalvesaq/cmp-zotcite",
      config = function()
        require 'cmp_zotcite'.setup({
          filetypes = { "pandoc", "markdown", "rmd", "quarto", "tex" }
        })
      end
    },
    {
      "micangl/cmp-vimtex",
    },
    -- Faster footnote generation
    { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" }, },
    -- Quick notes
    {
      "RutaTang/quicknote.nvim",
      config = function()
        -- you must call setup to let quicknote.nvim works correctly
        require("quicknote").setup({})
      end
      ,
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
      "epwalsh/obsidian.nvim",
      version = "*", -- recommended, use latest release instead of latest commit
      lazy = true,
      -- ft = "markdown",
      -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
      event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        "BufReadPre " .. vim.fn.expand "~" .. "/knowledgebase/**.md",
        "BufNewFile " .. vim.fn.expand "~" .. "/knowledgebase/**.md",
      },
      dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

      },
      opts = {
        workspaces = {
          {
            name = "knowledgebase",
            path = "~/knowledgebase",
          },

        },

      },
    },
    -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    { "godlygeek/tabular",                cmd = { "Tabularize" }, },

  }
)
