return {

  {
    "nvim-pack/nvim-spectre",
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    version = "^1.0.0",
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },

  -- align
  {
    "junegunn/vim-easy-align",
  },
  -- filetype
  {
    "nathom/filetype.nvim",
    config = function()
      require("filetype").setup({
        overrides = {
          extensions = {
            h = "c",
            hpp = "cpp",
            c = "c",
          },
          complex = {
            ["Dockerfile.*"] = "dockerfile",
            [".*urdf.*"] = "xml",
          },
        },
      })
    end,
  },

  -- undo
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<C-u>", mode = { "n", "x", "o" }, "<cmd>UndotreeToggle<CR>", desc = "Open Undo Tree" },
    },
  },
}
