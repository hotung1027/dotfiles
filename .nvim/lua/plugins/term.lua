return {
  {
    "alexghergh/nvim-tmux-navigation",
    config = true,
    keys = {
      {
        "<C-h>",
        mode = { "n" },
        "<cmd>NvimTmuxNavigateLeft<cr>",
      },
      {
        "<C-j>",
        mode = { "n" },
        "<cmd>NvimTmuxNavigateDown<cr>",
      },
      {
        "<C-k>",
        mode = { "n" },
        "<cmd>NvimTmuxNavigateUp<cr>",
      },
      {
        "<C-l>",
        mode = { "n" },
        "<cmd>NvimTmuxNavigateRight<cr>",
      },
    },
  },
  {
    "tmux-plugins/vim-tmux",
    ft = { "tmux" },
  },
}
