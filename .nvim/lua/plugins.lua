-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local utils = require("utils")

local fn = vim.fn

local map = require('utils').map

-- Only required if you have packer configured as `opt`


return require('packer').startup(function(use)

--================ NVIM PACKAGE MANAGER ==================================
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', event = "VimEnter"}


--=================== EDITOR SETUP ================================
    -- More Icons
    use {'kyazdani42/nvim-web-devicons', event = "BufRead"}
      -- Use specific branch, dependency and run lua file after load

    -- Status line
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        after = "nvim-web-devicons",
        config = function() require("config.statusline") end
    }
    -- Add indent object for vim (useful for languages like Python)
    use {"michaeljsmith/vim-indent-object", event = "VimEnter"}


    -- nvim-bufferline: better buffer line--
    use {
        'akinsho/nvim-bufferline.lua',
        config = function() require("config.bufferline") end,
        event = "BufRead"
    }
    -- more symbols
    use {
        'simrat39/symbols-outline.nvim',
        config = function() require("config.symbols") end,
        cmd = "SymbolsOutline"
    }
    use {"chrisbra/unicode.vim", event = "VimEnter"}
     -- show color at words
    use {
        'RRethy/vim-hexokinase',
        run = 'make',
        cmd = "HexokinaseToggle",
        setup = function()
            vim.g.Hexokinase_highlighters = {'foregroundfull'}
            vim.g.Hexokinase_optInPatterns = {
                'full_hex', 'rgb', 'rgba', 'hsl', 'hsla'
            }
        end
    }
      use {
       'vimlab/split-term.vim' 
      }
    -- Document Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require("config.nvimtree") end,
        cmd = {"NvimTreeRefresh", "NvimTreeToggle"}
    }
    -- Dependency: tmux, nnn
    -- This is heavily based on my configured nnn
    use {
        "luukvbaal/nnn.nvim",
        config = function()
            require("nnn").setup({
                picker = {
                    cmd = [[NNN_PLUG="p:preview-tui" ICONLOOKUP=1 tmux new-session nnn -a -Pp]],
                    style = {border = "shadow"},
                    session = "shared"
                }
            })
        end,
        cmd = {'NnnPicker', 'NnnExplorer'}
    }
    use {
      'alexghergh/nvim-tmux-navigation' 
    }
    -- Visual Guide
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require("config.indent") end,
        event = 'BufRead'
    }

    -- Comment plugin
    use {"preservim/nerdcommenter",
        config = function() require("config.comment") end,
        event = "VimEnter"
    }

    ---- === Searching =======
        use { 'nvim-lua/plenary.nvim' }
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
            config = function() require("config.telescope") end,
            module = 'telescope'
        }
        use {
          'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            config = function() require('telescope').load_extension('fzf') end,
        }
        use {
            'gbrlsnchs/telescope-lsp-handlers.nvim',
            config = function () require('telescope').load_extension('lsp_handlers') end

        }
        use {
            'cljoly/telescope-repo.nvim'
        }
        use {
            'nvim-telescope/telescope-project.nvim'
        }
        use {
            'nvim-telescope/telescope-frecency.nvim',
            config = function() require('telescope').load_extension('frecency') end,
            requires = {'tami5/sqlite.lua'}
        }
        -- search emoji and other symbols
        use {'nvim-telescope/telescope-symbols.nvim'}
        use {'nvim-telescope/telescope-dap.nvim',
          config = function() require('telescope').load_extension('dap') end
        }
        -- Fuzzy Finder
--        use { 'amirrezaask/fuzzy.nvim', requires={'nvim-lua/plenary.nvim'} , module = 'fuzzy_nvim'}
        use {'junegunn/fzf', run = function()
          vim.fn['fzf#install']()
        end
        }

        -- File search, tag search and more

        if vim.g.is_win then
          use {"Yggdroot/LeaderF", cmd = "Leaderf"}
        else
          use { "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" }
        end

        -- Clear highlight search automatically for you
        use({"romainl/vim-cool", event = "VimEnter"})

        -- Show match number for search
        use {'kevinhwang91/nvim-hlslens', branch = 'dev', event = "VimEnter"}
        -- Super fast buffer jump
        use { 'phaazon/hop.nvim',
            event = "VimEnter",
            config = function() require('config.hop') end
        }

    -- Better Escape
    use {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup {
            mapping = {"jj"}, -- a table with mappings to use
            timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
            clear_empty_lines = true, -- clear line after escaping if there is only whitespace
            keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
        }
      end
    }

    -- mulit cursor
    use {'mg979/vim-visual-multi', event = "InsertEnter", branch = 'master'}

    use {
        'famiu/nvim-reload',
        cmd = {"Reload", "Restart"},
        requires = "nvim-lua/plenary.nvim"
    }
        -- align
    use {'junegunn/vim-easy-align', cmd = 'EasyAlign'}

    -- speed up neovim!
    use {
        'nathom/filetype.nvim',
        config = function()
          require("filetype").setup({
            -- overrides the filetype or function for filetype
            -- See https://github.com/nathom/filetype.nvim#customization
            overrides = {}
          })
        end
    }

    use { "ggandor/lightspeed.nvim"  }

    use {
        'airblade/vim-rooter',
        cmd = "Rooter",
        setup = function()
            vim.g.rooter_manual_only = 1
            vim.g.rooter_change_directory_for_non_project_files = 'current'
            vim.g.rooter_patterns = {'.git', 'Cargo.toml'}
        end
    }



    -- Undo Histroy
    use {"mbbill/undotree", cmd ="UndotreeToggle"}

    -- Session management plugin

    -- Session management
    use {"rmagatti/auto-session",
      config = function() require('auto-session').setup {
      log_level = 'info' ,
      auto_session_enabled = true,
        
      }
    end
    }


    -- notification plugin
    use {'nvim-lua/popup.nvim'}

    use { "rcarriga/nvim-notify",
        event = "BufEnter",
        require = {'nvim-telescope/telescope.nvim','nvim-lua/plenary'},
        config = function() 
          require('config.notify')
          require('telescope').load_extension("notify")
        end 
    }

    -- showing keybindings
    use {"folke/which-key.nvim",
        event = "VimEnter",
        config = function() require('config.which-key') end}

    use {"tyru/open-browser.vim", event = "VimEnter"}


    -- Neovim Color Theme
    use { 'lifepillar/vim-gruvbox8' }
    use { 'lifepillar/vim-colortemplate' }
    use { 'sainnhe/gruvbox-material' }





  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

-- ====================== Completion =================================================================

    
    -- completeion source
    use {"hrsh7th/cmp-nvim-lua", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-path", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-buffer", requires = {"hrsh7th/nvim-cmp"}}
    use {"tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp",'tzachar/fuzzy.nvim'}}
    use {"lukas-reineke/cmp-rg", requires = {"hrsh7th/nvim-cmp"}}
    use {"tzachar/cmp-tabnine", requires = {"hrsh7th/nvim-cmp", run = "./install.sh"}}
    use {"lukas-reineke/cmp-under-comparator", requires = {"hrsh7th/nvim-cmp"}}
    use {"ray-x/cmp-treesitter", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-nvim-lsp-document-symbol", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-nvim-lsp-signature-help", requires = {"hrsh7th/nvim-cmp"}}
    use {"f3fora/cmp-spell",requires = {"hrsh7th/nvim-cmp"}}
    use {"andersevenrud/cmp-tmux", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-cmdline", requires = {"hrsh7th/nvim-cmp"}}
    use {"quangnguyen30192/cmp-nvim-tags", requires = {"hrsh7th/nvim-cmp"}, ft ={'haskell','c','cpp'}}

    use { 'onsails/lspkind-nvim' }
    use {"hrsh7th/nvim-cmp",
        after = "lspkind-nvim",
        config = function() require('config.nvim-cmp') end}

    -- lsp completion sources
    use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
    use {"github/copilot.vim" , run = ":Copilot setup" }
    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use {
        'williamboman/nvim-lsp-installer',
        ft = {
            "bash", "sh", "rust", "haskell", "c", "cpp", "lua", "markdown", "go", "html",
            "toml", "json", "python"
        }
    }
    use { "neovim/nvim-lspconfig",
        after = {"cmp-nvim-lsp","nvim-lsp-installer"},
        config = function () require('config.lsp') end }



    -- Gramma Check
    use {'rhysd/vim-grammarous'}

    -- syntax diagnostic
    use {
        'dense-analysis/ale',
        ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    use {'ray-x/lsp_signature.nvim'}
    use {'ray-x/navigator.lua'}
    use {'onsails/diaglist.nvim'}
   
    -- Only install these plugins if ctags are installed on the system
    if utils.executable("ctags") then
      -- plugin to manage your tags
      use {"ludovicchabant/vim-gutentags", event = "VimEnter"}
      -- gen gtags 
      use {"jsfaint/gen_tags.vim"}
      -- show file tags in vim window
      use {"liuchengxu/vista.vim", cmd = "Vista"}
     
    end

    -- Quick Fix Preview
    use { "kevinhwang91/nvim-bqf",
        event = "FileType qf",
        config = function () require('config.bqf') end }
    -- Autoformat tools
    use({ "sbdchd/neoformat", cmd = { "Neoformat" } })

    -- luasnip snippet
    use {'rafamadriz/friendly-snippets', event = "InsertEnter"}
    use { 'L3MON4D3/LuaSnip'}
    use { 'saadparwaiz1/cmp_luasnip'} 

    -- treesitter: support more colorful highlighting
    use {
      'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        ft = {"cpp", "toml", "rust", "go", "json", "lua", "fish", "c", 'haskell', 'python'},
        config = function() require('config.treesitter') end,
        module = "nvim-treesitter",
    }
    use {'nvim-treesitter/nvim-treesitter-refactor',
      require = {'nvim-treesitter/nvim-treesitter'}
  }
    -- You can specify multiple plugins in a single call
    use {'tjdevries/colorbuddy.vim', after = 'nvim-treesitter'}


    -- auto pairs
    use {'windwp/nvim-autopairs',
    config = function() require('config.autopairs') end
  }

    -- Select text object
    use {'gcmt/wildfire.vim', event = "BufRead"}

    -- surrounding select text with given text
    use {"tpope/vim-surround", after = "wildfire.vim"}

    -- Automatic insertion and deletion of a pair of characters
    use({"Raimondi/delimitMate", event = "InsertEnter"})


    -- Additional powerful text object for vim, this plugin should be studied
    -- carefully to use its full power
    use {"wellle/targets.vim", event = "VimEnter"}

-- ====================== Debuggers ======================
    use {
      'mfussenegger/nvim-dap',
      module = "dap",
      config = function()
        require("config.dap_config")
      end
    }
    use {
      'rcarriga/nvim-dap-ui',
      config = function () require('config.dap_config.dapui') end,
      module = "dapui",
    }
    if vim.g.is_win or vim.g.is_linux then
      use { "sakhnik/nvim-gdb",
      run = { "bash install.sh" },
      opt = true,
      setup = [[vim.cmd('packadd nvim-gdb')]] }
    end

    -- ======================== Runner =====================
    use { 'skywind3000/asynctasks.vim'}
    use {'skywind3000/asyncrun.vim'} 


-- ===================== Build Tools ==================================

     use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}



-- =================== Language Specific =============================

    -- C/CPP
    use {'rhysd/vim-clang-format', ft = {'cpp', 'c', 'h', 'hpp'}}


-- Since tmux is only available on Linux and Mac, we only enable these plugins
    -- for Linux and Mac
    if utils.executable("tmux") then
      -- .tmux.conf syntax highlighting and setting check
      use { "tmux-plugins/vim-tmux", ft = { "tmux" } }
    end

-- ======================= GIT ================================
    -- Better git commit experience
    use {"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]}

    -- git information
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require("config.gitsign") end
    }


    -- Git command inside vim
    use { "tpope/vim-fugitive", event = "User InGitRepo" }

    -- Better git log display
    use { "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } }

    use {
        'TimUntersberger/neogit',
        requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
        config = function()
            require('neogit').setup {
                integrations = {diffview = true},
                -- Change the default way of opening neogit
                kind = "split_above",
                -- customize displayed signs
                signs = {
                    -- { CLOSED, OPENED }
                    section = {"", ""},
                    item = {"", ""},
                    hunk = {"", ""}
                }
            }
        end,
        cmd = "Neogit"
    }


-- Mark Down Plugins
    -- Another markdown plugin
    use { "plasticboy/vim-markdown", ft = { "markdown" } }

    -- Faster footnote generation
    use { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } }
    -- Vim tabular plugin for manipulate tabular, required by markdown plugins


  if packer_bootstrap then
      require('packer').sync()
  end


end)
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
