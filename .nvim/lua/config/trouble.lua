local trouble = require('trouble')
trouble.setup {
  position     = "bottom", -- position of the list can be: bottom, top, left, right
  height       = 10, -- height of the trouble list when position is top or bottom
  width        = 50, -- width of the list when position is left or right
  fold_open    = "", -- icon used for open folds
  fold_closed  = "", -- icon used for closed folds
  group        = true, -- group results by file
  padding      = true, -- add an extra new line on top of the list
  keys         = { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    ["<cr>"]  = "jump",
    ["<tab>"] = "jump",     -- jump to the diagnostic or open / close folds
    ["<c-t>"] = "open_tab", -- open buffer in new tab
    k         = "previous", -- preview item
    j         = "next"      -- next item
  },
  --
  -- -- icons = {}, -- use default icons sets
  modes        = {
    cascade = {
      mode       = "diagnostics", -- inherit from diagnostics mode

      auto_open  = true,          -- automatically open the list when you have diagnostics
      auto_close = true,          -- automatically close the list when you have no diagnostics
      filter     = function(items)
        local severity = vim.diagnostic.severity.HINT
        for _, item in ipairs(items) do
          severity = math.min(severity, item.severity)
        end
        return vim.tbl_filter(function(item)
          return item.severity == severity
        end, items)
      end,
    },
    --
  },
  preview      = {

    type     = "split",
    relative = "win",
    position = "right",
    -- position = { 20, 50 },
    border   = "rounded",
    size     = { width = 0.5, height = 1 },
  },
  -- restore       = true,                  -- restores the last location in the list when opening
  -- follow        = true,                  -- Follow the current item
  -- indent_guides = true,                  -- show indent guides true,               -- add an indent guide below the fold icons
  auto_preview = true,  -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  -- auto_fold     = true,                  -- automatically fold a file trouble list at creation
  -- auto_jump     = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
  --
  pinned       = true,
  auto_open    = true, -- automatically open the list when you have diagnostics
  auto_close   = true, -- automatically close the list when you have no diagnostics
}
