--[[
-- Copy from https://github.com/siduck76/NvChad/blob/main/lua/plugins/telescope.lua
--]]
local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg", "--hidden", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case", "--trim", "--glob", "!**/.git/**"
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
    file_ignore_patterns = {},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "absolute" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    preview = {
      iletype_hook = function(filepath, bufnr, opts)
        -- you could analogously check opts.ft for filetypes
        local excluded = vim.tbl_filter(function(ending)
          return filepath:match(ending)
        end, {
          ".*%.csv",
          ".*%.toml",
        })
        if not vim.tbl_isempty(excluded) then
          putils.set_preview_message(
            bufnr,
            opts.winid,
            string.format("I don't like %s files!",
              excluded[1]:sub(5, -1))
          )
          return false
        end
        return true
      end,
      filesize_hook = function(filepath, bufnr, opts)
        local path = require("plenary.path"):new(filepath)
        -- opts exposes winid
        local height = vim.api.nvim_win_get_height(opts.winid)
        local lines = vim.split(path:head(height), "[\r]?\n")
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
      end,
      treesitter = {
        enable = {
          'c', 'cpp', 'rust', 'toml', 'haskel', 'go', 'python'
        }
      }
    },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    autocommands = {
      preview = false,
    },
    buffers = {
      preview = false,
    },
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
    },
    arecibo = {
      ["selected_engine"]   = 'google',
      ["url_open_command"]  = 'open',
      ["show_http_headers"] = false,
      ["show_domain_icons"] = true,
    },
    dash = {
      -- configure path to Dash.app if installed somewhere other than /Applications/Dash.app
      dash_app_path = '/Applications/Dash.app',
      -- search engine to fall back to when Dash has no results, must be one of: 'ddg', 'duckduckgo', 'startpage', 'google'
      search_engine = 'ddg',
      -- debounce while typing, in milliseconds
      debounce = 0,
      -- map filetype strings to the keywords you've configured for docsets in Dashwd
      -- setting to false will disable filtering by filetype for that filetype
      -- filetypes not included in this table will not filter the query by filetype
      -- check src/lua_bindings/dash_config_binding.rs to see all defaultsa
      -- the values you pass for file_type_keywords are merged with the defaults
      -- to disable filtering for all filetypes,
      -- set file_type_keywords = false
      file_type_keywords = {
        dashboard       = false,
        NvimTree        = false,
        TelescopePrompt = false,
        terminal        = false,
        packer          = false,
        fzf             = false,
        -- a table of strings will search on multiple keywords
        javascript      = { 'javascript', 'nodejs' },
        typescript      = { 'typescript', 'javascript', 'nodejs' },
        typescriptreact = { 'typescript', 'javascript', 'react' },
        javascriptreact = { 'javascript', 'react' },
        rust            = { 'rust', 'docs.rs' },
        cpp             = { 'c', 'cpp', 'opencv', 'eigen' },
        -- you can also do a string, for example,
        -- sh = 'bash'
      },
    },


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
local extensions = {
  'flutter',
  'fzf',
  'frecency',
  'macros',
  'arecibo',
  'dash',
}
for _, extension in pairs(extensions) do
  telescope.load_extension(extension)
end
