
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
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
      }
}
