local map = require('utils').map
local wk = require("which-key")
local term = require("term")
local conf = {
  window = {
    border = "single",   -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
wk.setup(conf)

local opts = {
  mode = "n",     -- Normal mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v",     -- Visual mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

vim.g.mapleader = ";"
-- map('n', 'J', '5j')
-- map('x', 'J', '5j')
-- map('n', 'K', '5k')
-- map('x', 'K', '5k')

-- map("n", "L", "g_")
-- map("n", "H", "^")
-- map("x", "L", "g_")
-- map("x", "H", "^")

map("n", "W", "5w")
map("n", "B", "5b")


map("n", "<", "<<")
map("n", ">", ">>")
map("x", "<", "<gv")
map("x", ">", ">gv")

map("n", "-", "N")
map("n", "=", "n")

map("n", "<C-T>h", ":tabprevious<CR>")
map("n", "<C-T>l", ":tabnext<CR>")
map("n", "<C-T>n", ":tabnew<CR>")

-- tmux navigator
map('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>")
map('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>")
map('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>")
map('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>")




-- buffer writing
map("n", "<leader>w", ":wa!<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>Q", ":qa!<CR>")
map("n", "<leader>db", require('mini.bufremove').delete)

map("x", "<C-y>", [["+y]])

map("n", "<C-p>", [["+p]])
map("i", "<C-p>", [[<ESC>"+pi]])

map("n", "<ESC>", ":nohlsearch<CR>")

map("n", "<up>", ":res +5<CR>")
map("n", "<down>", ":res -5<CR>")
map("n", "<left>", ":vertical resize-5<CR>")
map("n", "<right>", ":vertical resize+5<CR>")

-- center line
map("i", "<C-c>", "<ESC>zzi")

-- nnn
map('n', '<Leader>o', ':NnnPicker %:p:h<CR>')
-- EasyAlign
map("v", "<leader>e", ":EasyAlign<CR>")

-- vim-go
map('n', 'got', ':GoTestFunc<CR>')
map('n', 'gor', ':GoRun<CR>')

-- nvim-tree
map("n", "<leader>fl", ":NvimTreeToggle<CR>")
map("n", "<leader>fr", ":NvimTreeRefresh<CR>")

-- Terminal
local Terminal = require('toggleterm.terminal').Terminal
local add_term = function(args)
  local tabinfo = vim.fn.tabpagebuflist()
  local termbuf_cnt = 0
  for _, id in pairs(tabinfo) do
    local i, _ = string.find(vim.fn.bufname(id), "term://")
    if i ~= nil then
      termbuf_cnt = termbuf_cnt + 1
    end
  end
  vim.cmd("ToggleTerm" .. termbuf_cnt + 1)
end
local cycle_term = function(step)
  local terms        = require('toggleterm.terminal').get_all()
  local current_term = require('toggleterm.terminal').get_focused_id()
  local index        = 0
  if current_term == nil or terms == nil then
    return
  else
    for i, v in ipairs(terms) do
      if v.id == current_term then
        index = i
        break
      end
    end
  end
  local next_index = (index + step - 1) % (#terms) + 1
  terms[next_index]:focus()
end

-- local git_tui = "lazygit"
-- local git_client = Terminal:new({
--   direction = "float",
--   float_opts = {
--     border = "double",
--   },
--   -- on_open = function(term)
--   --   vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
--   -- end,
--   cmd = git_tui,
--   hidden = true,
-- })
--
-- local function gitclient_toggle()
--   git_client:toggle()
-- end
--
-- local docker_tui = "lazydocker"
--
-- local docker_client = Terminal:new {
--   cmd = docker_tui,
--   dir = "git_dir",
--   hidden = true,
--   direction = "float",
--   float_opts = {
--     border = "double",
--   },
-- }
--
-- function docker_client_toggle()
--   docker_client:toggle()
-- end

map("n", "<leader>tn", add_term)
-- map("n", "<leader>t]", function() cycle_term(1) end)
-- map("n", "<leader>t[", function() cycle_term(-1) end)

-- map("n", "<leader>lg", gitclient_toggle, { noremap = true, silent = true })
map("n", "<leader>ng", [[<CMD>Neogit<CR>]])

-- Tabnine
map("n", "<leader>tc", ":TabnineChat<CR>")
map("n", "<leader>ts", ":TabnineFix<CR>")
map("n", "<leader>tx", ":TabnineExplain<CR>")


-- UndoTree
map("n", "<C-z>", ":UndotreeToggle<CR>")
--- Debuggert
map("n", "<leader>dl", ":DapUIToggle<CR>")
-- bufferline
map("n", "]b", ":BufferLineCycleNext<CR>")
map("n", "[b", ":BufferLineCyclePrev<CR>")
-- Vista
map("n", "<leader>tl", ":SymbolsOutline<CR>")
-- lua require('telescope.builtin')
--
--
local function find_files_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  require("telescope.builtin").find_files(opts)
end


-- map("n", ":", function() require("telescope.builtin").commands({}) end, {})
map("n", "<leader>tt",
  function()
    require("telescope.builtin").builtin({
      preview = { timeout = 10, hide_on_startup = true,
      }
    })
  end, {})
map("n", "<leader><space>m", require('harpoon.mark').add_file, {})
map("n", "<leader><leader>", require('harpoon.ui').toggle_quick_menu, {})

map("n", "<leader>e", "<cmd>lua require('replacer').run({ save_on_write = false, rename_files = false })<CR>", {})
local quit_quick_fix_window_or_exit = function()
  if vim.bo.filetype == "qf" then
    vim.cmd([[<cmd>lua require("replacer").save({ save_on_write = false, rename_files = false })<CR>]])
  else
    vim.cmd([[<cmd>q<CR>]])
  end
end
-- map("n", "<leader>q", require("replacer").save({ save_on_write = false, rename_files = false }), {})

-- Treesitter External Plugins
map("n", "[c", "<cmd>lua require('treesitter-context').go_to_context()<CR>")


-- Treesitter Hop
local function hop_pattern_with_call_back()
  local search_text = vim.fn['getreg']('/')
  local hop = require('hop')
  if search_text ~= nil then
    hop.hint_patterns({}, search_text)
  else
    hop.hint_char2()
  end
end

map('n', '<C-f>', hop_pattern_with_call_back, {})

map("n", "m", "<cmd>HopWord<CR>")
-- Git
--[[ map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'")
map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns mrev_hunk<CR>'") ]]

map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
map("n", "<leader>hb", "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>")
map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
map("n", "<leader>hU", "<cmd>Gitsigns reset_buffer_index<CR>")

local function normal_keymap()
  local keymap_f = nil -- File search
  local keymap_p = nil -- Project search

  keymap_f = {
    name = "Pickers",
    f = { find_files_from_project_git_root, "Find Files" },
    g = { require('telescope').extensions.live_grep_args.live_grep_args, "Live Grep" },
    c = { "<Cmd>Telescope frecency workspace=CWD<CR>", "Frecency" },
    b = {
      function()
        require('telescope.builtin').buffers({
          preview = { timeout = 10, hide_on_startup = true,
          }
        })
      end, "Tabs" },
    h = { require('telescope.builtin').help_tags, "Help" },
    t = { require('telescope.builtin').lsp_document_symbols, "Document Symbols" },
    s = { require('telescope.builtin').lsp_dynamic_workspace_symbols, "Worksapce Symbols" },
    w = { require('telescope.builtin').grep_string, "Grep String" },
    j = { require('telescope.builtin').current_buffer_fuzzy_find, "buffer" },
    q = { require('telescope.builtin').quickfixhistory, "Quick Fix" },
    r = { "<cmd>OverseerRun<CR>", "Task Runner" },

  }


  keymap_p = {
    name = "Project",
    p = { "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>", "List" },
    s = { "<cmd>lua require'telescope'.extensions.repo.list{}<cr>", "Search" },
    -- P = { "<cmd>TermExec cmd='BROWSER=brave yarn dev'<cr>", "Slidev" },
  }

  local keymap = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
    -- ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },


    -- b = {
    --   name = "Buffer",
    --   c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
    --   f = { "<Cmd>bdelete!<Cr>", "Force Close Buffer" },
    --   D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
    --   b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
    --   p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
    --   m = { "<Cmd>JABSOpen<Cr>", "Menu" },
    -- },

    c = {
      name = "Code",
      g = { "<cmd>Neogen func<Cr>", "Func Doc" },
      G = { "<cmd>Neogen class<Cr>", "Class Doc" },
      d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
      o = { "<cmd>Telescope aerial<Cr>", "Outline" },
      T = { "<cmd>TodoTelescope<Cr>", "TODO" },
      x = {
        name = "Swap Next",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
      X = {
        name = "Swap Previous",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
      -- f = "Select Outer Function",
      -- F = "Select Outer Class",
    },

    d = {
      name = "Debug",
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },

    -- Database
    -- D = {
    --   name = "Database",
    --   u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
    --   f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
    --   r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
    --   q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    -- },

    f = keymap_f,
    p = keymap_p,




    o = {
      name = "Overseer",
      C = { "<cmd>OverseerClose<cr>", "OverseerClose" },
      a = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
      b = { "<cmd>OverseerBuild<cr>", "OverseerBuild" },
      c = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
      d = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
      l = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
      o = { "<cmd>OverseerOpen!<cr>", "OverseerOpen" },
      q = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
      r = { "<cmd>OverseerRun<cr>", "OverseerRun" },
      s = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
      t = { "<cmd>OverseerToggle!<cr>", "OverseerToggle" },
    },



    r = {
      name = "Refactor",
      i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
      b = { [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]], "Extract Block" },
      B = { [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]], "Extract Block to File" },
      P = {
        [[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
        "Debug Print",
      },
      p = {
        [[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
        "Debug Print Variable",
      },
      c = { [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]], "Debug Cleanup" },
    },

    s = {
      name = "Search",
      s = { [[ <Esc><Cmd>lua require('spectre').open()<CR>]], "Open" },
      c = { [[ <Esc><Cmd>lua require('term').cht_input()<CR>]], "cht.sh" },
      r = { [[ <Esc><Cmd>lua require('term').rust_book()<CR>]], "Rust Book" },
      o = { [[ <Esc><Cmd>lua require('term').so()<CR>]], "Stack Overflow" },
      w = { [[ <Esc><Cmd>lua require("telescope").extensions.arecibo.websearch()<CR>]], "Web" },
      d = { "<cmd>DevdocsOpenFloat<CR>", "Development Documents" },
      f = { "<cmd>lua require('dash.providers.telescope').dash({ bang = false, initial_text = '' })<CR>", "Dash Search" },

    },


    x = {
      name = "External",
      d = { "<cmd>lua require('term').docker_client_toggle()<CR>", "Docker" },
      t = { "<cmd>lua require('term').docker_ctop_toggle()<CR>", "Docker - ctop" },
      y = { "<cmd>lua require('term').docker_dckly_toggle()<CR>", "Docker - dockly" },
      p = { "<cmd>lua require('term').project_info_toggle()<CR>", "Project Info" },
      g = { "<cmd>lua require('term').git_client_toggle()<CR>", "Git TUI" },
      s = { "<cmd>lua require('term').system_info_toggle()<CR>", "System Info" },
      c = { "<cmd>lua require('term').cht()<CR>", "Cheatsheet" },
      i = { "<cmd>lua require('term').interactive_cheatsheet_toggle()<CR>", "Interactive Cheatsheet" },
    },

    z = {
      name = "System",
      -- c = { "<cmd>PackerCompile<cr>", "Compile" },
      c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
      e = { "!!$SHELL<CR>", "Execute line" },
      z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
    },

    g = {
      name = "Git",
      b = { "<cmd>GitBlameToggle<CR>", "Blame" },
      c = { "<cmd>lua require('term').git_commit_toggle()<CR>", "Conventional Commits" },
      -- p = { "<cmd>Git push<CR>", "Push" },
      s = { "<cmd>lua require('neogit').open()<CR>", "Status - Neogit" },
      S = { "<cmd>Git<CR>", "Status - Fugitive" },
      -- y = {
      --   "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
      --   "Link",
      -- },
      g = { "<cmd>lua require('telescope').extensions.gh.gist()<CR>", "Gist" },
      z = { "<cmd>lua require('term').git_client_toggle()<CR>", "Git TUI" },
      h = { name = "Hunk" },
      t = { name = "Toggle" },
      x = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Switch Branch" },
    },
  }
  wk.register(keymap, opts)
  -- legendary.bind_whichkey(keymap, opts, false)
end

local function visual_keymap()
  local keymap = {

    r = {
      name = "Refactor",
      e = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
      f = {
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function to File')<CR>]],
        "Extract Function to File",
      },
      v = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
      i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
      r = { [[ <Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
      V = { [[ <Esc><Cmd>lua require('refactoring').debug.print_var({})<CR>]], "Debug Print Var" },
    },
  }

  wk.register(keymap, v_opts)
end

local function setup_keymaps()
  normal_keymap()
  visual_keymap()
end

setup_keymaps()
