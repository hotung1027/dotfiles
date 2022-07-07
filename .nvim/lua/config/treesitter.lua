local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
require('nvim-treesitter.install').compilers = {"gcc-11"}
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
require'nvim-treesitter.configs'.setup {
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
        "lua",
        "comment"},
        sync_install = true,
        ignore_install = {},
    highlight = {
        enable = false,
        disable = {},
        additional_vim_regex_hightlighting = true,
    },
    incremental_selection = {
      enable = true,

    },
    indent = {
      enable = true,

    },
    refractor={
      highlight_definitions = {enable = true},
      highlight_current_scope = {enable = true},
      smart_rename = {
        enable = true,
        },
      navigation = {
        enable =true,
        }
      },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          -- Or you can define your own textobjects like this
          ["iF"] = {
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function",
          },
        },
      },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
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
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
        },
      },

    },
}
