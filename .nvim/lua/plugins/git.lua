return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
  {
    "rhysd/committia.vim",
    layz = true,
  },
  {
    "NeogitOrg/neogit",
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
      kind = "tab",
      commit_editor = {
        kind = "tab",
      },
      -- customize displayed signs
      signs = {
        -- { CLOSED, OPENED },
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gn", mode = { "n" }, "<cmd>Neogit<cr>", desc = "Neogit Toggle" },
    },
  },
}
