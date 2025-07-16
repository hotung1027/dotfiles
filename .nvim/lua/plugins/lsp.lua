return {
  {
    "onsails/lspkind-nvim",
  },
  {
    "hinell/lsp-timeout.nvim",
  },
  {
    "aznhe21/actions-preview.nvim",
    config = true,
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymaps = {
        preset = "tab",
        ["<C-k>"] = "blink#cmp#select_prev_item()",
        ["<C-j>"] = "blink#cmp#select_next_item()",
      },
    },
  },
}
