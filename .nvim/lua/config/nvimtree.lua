local ok, api = pcall(require, "nvim-tree.api")
if not ok then
  vim.notify(api, vim.log.levels.ERROR)
  return
end

-- vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_root_folder_modifier = ":t"
vim.g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names

vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  --    folder_arrows= 1
}
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "",
    unmerged = "",
    renamed = "凜",
    untracked = "",
    deleted = "",
    ignored = ""
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = ""
  }
}

local function edit_or_open()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

-- open as vsplit on current node
local function vsplit_preview()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file as vsplit
    api.node.open.vertical()
  end

  -- Finally refocus on tree if it was lost
  api.tree.focus()
end


--[[ local function change_on_attach(bufnr)
    api.config.mappings.default_on_attach(bufnr)
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
  local mappings = {
    -- BEGIN_DEFAULT_ON_ATTACH
    ["<C-]>"] = { api.tree.change_root_to_node, "CD" },
    ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
    ["<C-k>"] = { api.node.show_info_popup, "Info" },
    ["<C-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
    ["<C-t>"] = { api.node.open.tab, "Open: New Tab" },
    ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
    ["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
    ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },
    ["<CR>"] = { api.node.open.edit, "Open" },
    ["<Tab>"] = { api.node.open.preview, "Open Preview" },
    [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
    ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
    ["."] = { api.node.run.cmd, "Run Command" },
    ["-"] = { api.tree.change_root_to_parent, "Up" },
    ["a"] = { api.fs.create, "Create" },
    ["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
    ["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
    ["c"] = { api.fs.copy.node, "Copy" },
    ["C"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
    ["[c"] = { api.node.navigate.git.prev, "Prev Git" },
    ["]c"] = { api.node.navigate.git.next, "Next Git" },
    ["d"] = { api.fs.remove, "Delete" },
    ["D"] = { api.fs.trash, "Trash" },
    ["E"] = { api.tree.expand_all, "Expand All" },
    ["e"] = { api.fs.rename_basename, "Rename: Basename" },
    ["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
    ["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
    ["F"] = { api.live_filter.clear, "Clean Filter" },
    ["f"] = { api.live_filter.start, "Filter" },
    ["g?"] = { api.tree.toggle_help, "Help" },
    ["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
    ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
    ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
    ["J"] = { api.node.navigate.sibling.last, "Last Sibling" },
    ["K"] = { api.node.navigate.sibling.first, "First Sibling" },
    ["m"] = { api.marks.toggle, "Toggle Bookmark" },
    ["o"] = { api.node.open.edit, "Open" },
    ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
    ["p"] = { api.fs.paste, "Paste" },
    ["P"] = { api.node.navigate.parent, "Parent Directory" },
    ["q"] = { api.tree.close, "Close" },
    ["r"] = { api.fs.rename, "Rename" },
    ["R"] = { api.tree.reload, "Refresh" },
    ["s"] = { api.node.run.system, "Run System" },
    ["S"] = { api.tree.search_node, "Search" },
    ["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
    ["W"] = { api.tree.collapse_all, "Collapse" },
    ["x"] = { api.fs.cut, "Cut" },
    ["y"] = { api.fs.copy.filename, "Copy Name" },
    ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
    ["<2-LeftMouse>"] = { api.node.open.edit, "Open" },
    ["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },
    -- END_DEFAULT_ON_ATTACH

    -- Mappings migrated from view.mappings.list
    ["l"] = { edit_or_open, "Edit Or Open" },
    ["L"] = {vsplit_preview, "Vsplit Preview"},
    ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
    ["C"] = { api.tree.change_root_to_node, "CD" },
    ["<CR>"] = { api.node.open.tab_drop, "Open" },
  }

  for keys, mapping in pairs(mappings) do
    vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
  end
end ]]
-- following options are the default
require 'nvim-tree'.setup {
  auto_reload_on_write = true,
  reload_on_bufenter = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,

  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = false,
    icons = { hint = "", info = "", warning = "", error = "" }
  },
  update_focused_file = { enable = true, update_cwd = true, update_root = true, ignore_list = {} },
  system_open = { cmd = nil, args = {} },
  git = {
    ignore = false,
    enable = true,
  },
  filters = {
    dotfiles = true,
    custom = {
      '.git', 'node_modules', '.cache'
    }
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
    }
  },
  actions = {
    use_system_clipboard = true,

    open_file = {
      resize_window = true,
    }
  },

  view = {
    width = 25,
    side = 'left',
  },
  on_attach = change_on_attach,
}


-- auto show hydra on nvimtree focus
local function change_root_to_global_cwd()
  local global_cwd = vim.fn.getcwd()
  -- local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end






vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    -- Only 1 window with nvim-tree left: we probably closed a file buffer
    if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
      -- Required to let the close event complete. An error is thrown without this.
      vim.defer_fn(function()
        -- close nvim-tree: will go to the last hidden buffer used before closing
        api.tree.toggle({ find_file = true, focus = true })
        -- re-open nivm-tree
        api.tree.toggle({ find_file = true, focus = true })
        -- nvim-tree is still the active window. Go to the previous window.
        vim.cmd("wincmd p")
      end, 0)
    end
  end
})
