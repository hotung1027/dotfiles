--[[
-- Copy from https://github.com/siduck76/NvChad/blob/main/lua/plugins/telescope.lua
--]]
local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg", "--hidden", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case", "--trim", "--glob", "!**/.git/*"
    },
    prompt_prefix = "  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { '^./.git/', '^node_modules/' },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "absolute" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
  },
  pickers = {
    find_files = {
      hidden = true,
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case"        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    lsp_handlers = {
      code_action = {
        telescope = require('telescope.themes').get_dropdown({})
      }
    }
  },
  heading = {
    treesitter = true,
  },
  hop = {
    -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
    keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
      "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
      "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
      "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", },
    -- Highlight groups to link to signs and lines; the below configuration refers to demo
    -- sign_hl typically only defines foreground to possibly be combined with line_hl
    sign_hl = { "WarningMsg", "Title" },
    -- optional, typically a table of two highlight groups that are alternated between
    line_hl = { "CursorLine", "Normal" },
    -- options specific to `hop_loop`
    -- true temporarily disables Telescope selection highlighting
    clear_selection_hl = false,
    -- highlight hopped to entry with telescope selection highlight
    -- note: mutually exclusive with `clear_selection_hl`
    trace_entry = true,
    -- jump to entry where hoop loop was started from
    reset_selection = true,
  },
})

-- telescope.extensions.dap.configurations()
telescope.load_extension('flutter')
telescope.load_extension('fzf')
