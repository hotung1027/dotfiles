local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
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
    "comment",
    "pkl",
  },
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
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = {},
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
  node_movement = { enable = true,
    keymaps = {
      move_up = "<a-k>",
      move_down = "<a-j>",
      move_left = "<a-h>",
      move_right = "<a-l>",
      swap_left = "<c-a-h>", -- will only swap when one of "swappable_textobjects" is selected
      swap_right = "<c-a-l>",
      select_current_node = "<leader><Cr>",
    },
    swappable_textobjects = { '@function.inner', '@function.outer', '@parameter.inner', '@statement.outer', '@statement.inner' },
    allow_switch_parents = true, -- more craziness by switching parents while staying on the same level, false prevents you from accidentally jumping out of a function
    allow_next_parent = true,    -- more craziness by going up one level if next node does not have children
  },

}
require('ts_context_commentstring').setup({
  eanble_autocmd = false,
})
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('treesitter-context').setup(
  {
    enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20,     -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching  }
  }
)
