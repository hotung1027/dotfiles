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
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require("cmp_tabnine.config")

      tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = false,
        min_percent = 0,
      })
    end,
  },
  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    opts = {},
  },

  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot", "Kaiser-Yang/blink-cmp-avante" },

    opts = {
      keymaps = {
        preset = "super-tab",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },

        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      },
      sources = {

        default = { "avante", "copilot", "lsp", "path", "snippets", "buffer", "tabnine" },

        providers = {
          copilot = {
            module = "blink-copilot",
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
          tabnine = {

            name = "tabnine",
            module = "blink.compat.source",
            cmp_name = "cmp_tabnine",
          },
        },
      },
    },
  },
}
