
-- =========== Indent Blank Line ========================
vim.opt.list = true

vim.opt.listchars:append("space:-")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
      filetype_exclude = {
      "help", "terminal", "dashboard", "packer", "lspinfo", "TelescopePrompt",
      "TelescopeResults", "startify", "dashboard", "dotooagenda", "log",
      "fugitive", "gitcommit", "packer", "vimwiki", "markdown", "txt",
      "vista", "help", "todoist", "NvimTree", "peekaboo", "git",
      "TelescopePrompt", "undotree", "flutterToolsOutline","lsp-installer", ""
    },
    buftype_exclude = {"terminal"},
}
