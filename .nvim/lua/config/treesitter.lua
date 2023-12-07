local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
local sts = require('syntax-tree-surfer')
require('nvim-treesitter.install').compilers = { "clang", "gcc" }
require('nvim-treesitter.install').prefer_git = true
parser_configs.norg = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main"
  },
}

parser_configs.norg_meta = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
    files = { "src/parser.c" },
    branch = "main"
  },
}

parser_configs.norg_table = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
    files = { "src/parser.c" },
    branch = "main"
  },
}
vim.cmd("packadd! matchit")
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "norg",
    "norg_meta",
    "norg_table",
    "c",
    "cpp",
    "haskell",
    "toml",
    "rust",
    "go",
    "json",
    "http",
    "lua",
    "vim",
    "vimdoc",
    "comment" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = false,
    disable = {},
    additional_vim_regex_hightlighting = false,
  },
  incremental_selection = {
    enable = true,

  },
  indent = {
    enable = true,

  },
  refractor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
    },
    navigation = {
      enable = true,
    }
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      -- keymaps = {
      --   -- You can use the capture groups defined in textobjects.scm
      --   ["af"] = "@function.outer",
      --   ["if"] = "@function.inner",
      --   ["ac"] = "@class.outer",
      --   ["ic"] = "@class.inner",
      --
      --   -- Or you can define your own textobjects like this
      --   ["iF"] = {
      --     python = "(function_definition) @function",
      --     cpp = "(function_definition) @function",
      --     c = "(function_definition) @function",
      --     java = "(method_declaration) @function",
      --   },
      -- },
    },
    swap = {
      enable = true,
      -- swap_next = {
      --   ["<leader>a"] = "@parameter.inner",
      -- },
      -- swap_previous = {
      --   ["<leader>A"] = "@parameter.inner",
      -- },
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      -- goto_next_start = {
      --   ["]m"] = "@function.outer",
      --   ["]]"] = "@class.outer",
      -- },
      -- goto_next_end = {
      --   ["]M"] = "@function.outer",
      --   ["]["] = "@class.outer",
      -- },
      -- goto_previous_start = {
      --   ["[m"] = "@function.outer",
      --   ["[["] = "@class.outer",
      -- },
      -- goto_previous_end = {
      --   ["[M"] = "@function.outer",
      --   ["[]"] = "@class.outer",
      -- },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      -- peek_definition_code = {
      --   ["<leader>df"] = "@function.outer",
      --   ["<leader>dF"] = "@class.outer",
      -- },
    },
  },
  autotag = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  pairs = {
    enable = true,
    disable = {},
    highlight_pair_events = { "CursorMoved" },                    -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
    highlight_self = true,                                        -- whether to highlight also the part of the pair under cursor (or only the partner)
    goto_right_end = false,                                       -- whether to go to the end of the right partner or the beginning
    fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
    keymaps = {
      goto_partner = "%",
      delete_balanced = "X",
    },
    delete_balanced = {
      only_on_first_char = false, -- whether to trigger balanced delete when on first character of a pair
      fallback_cmd_normal = nil,  -- fallback command when no pair found, can be nil
      longest_partner = false,    -- whether to delete the longest or the shortest pair when multiple found.
      -- E.g. whether to delete the angle bracket or whole tag in  <pair> </pair>
    }
  },
}
-- require('treesitter-context').setup(
--   {
--     enable = true,
--
--   }
-- )
sts.setup({
  highlight_group = "STS_highlight",
  disable_no_instance_found_report = false,
  default_desired_types = {
    "function",
    "arrow_function",
    "function_definition",
    "if_statement",
    "else_clause",
    "else_statement",
    "elseif_statement",
    "for_statement",
    "while_statement",
    "switch_statement",
  },
  left_hand_side = "fdsawervcxqtzb",
  right_hand_side = "jkl;oiu.,mpy/n",
  icon_dictionary = {
    ["if_statement"] = "",
    ["else_clause"] = "",
    ["else_statement"] = "",
    ["elseif_statement"] = "",
    ["for_statement"] = "ﭜ",
    ["while_statement"] = "ﯩ",
    ["switch_statement"] = "ﳟ",
    ["function"] = "",
    ["function_definition"] = "",
    ["variable_declaration"] = "",
  },
})
require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
