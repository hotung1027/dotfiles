local map = require('utils').map
vim.g.mapleader = ";"


map('n', 'J', '5j')
map('x', 'J', '5j')
map('n', 'K', '5k')
map('x', 'K', '5k')

map("n", "L", "g_")
map("n", "H", "^")
map("x", "L", "g_")
map("x", "H", "^")

map("n", "W", "5w")
map("n", "B", "5b")

map("n", "<C-z>", "u")

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
map("n", "<leader>w", ":wa<CR>")
map("n", "<leader>q", ":q<CR>")
map("n","<leader>Q",":qa!<CR>")


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
--aerojump to
vim.cmd([[
nmap <Leader>as <Plug>(AerojumpSpace)
nmap <Leader>ab <Plug>(AerojumpBolt)
nmap <Leader>aa <Plug>(AerojumpFromCursorBolt)
nmap <Leader>ad <Plug>(AerojumpDefault)
]])
-- searchbox 
map('n', '<leader>s',":lua require('searchbox').incsearch()<CR>")
map('x', '<Leader>s', "<ESC>:lua require('searchbox').insearch({visual_mode = true})<CR>")
-- EasyAlign
map("v", "<leader>e", ":EasyAlign<CR>")

-- vim-go
map('n', 'got', ':GoTestFunc<CR>')
map('n', 'gor', ':GoRun<CR>')

-- nvim-tree
map("n", "<leader>fl", ":NvimTreeToggle<CR>")
map("n", "<leader>fr", ":NvimTreeRefresh<CR>")

-- FloatTerm
map("n","<A-d>`","<cmd>:FloatermNew --cwd=<root> --wintype=split --height=0.3 --position=botright<CR>")
map("n","<A-d>t","<cmd>:FloatermNew --cwd=<root> --position=bottom<CR>")
map("n","<A-d>g","<cmd>:FloatermNew --cwd=<root> --height=0.8 --width=0.8 --position=center --autoclose=0 lazygit<CR>")

map("t","<A-d>","<C-\\><C-n>:FloatermKill<CR>")


  -- UndoTree
map("n", "<C-z>",":UndotreeToggle<CR>")
--- Debuggert
map("n","<leader>dl",":DapUIToggle<CR>")
-- bufferline
map("n","<leader>b]",":BufferLineCycleNext<CR>")
map("n","<leader>b[",":BufferLineCyclePrev<CR>")
-- Vista
map("n","<leader>tl",":Vista!!<CR>")
-- lua require('telescope.builtin').
map("n","<leader>tt",":Telescope<CR>")
map("n","<leader>ff","<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n","<leader>fg","<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n","<leader>fb","<cmd>lua require('telescope.builtin').buffers()<CR>")
map("n","<leader>fh","<cmd>lua require('telescope.builtin').help_tags{}<CR>")
map("n","<leader>ft","<cmd>lua require('trouble.providers.telescope').open_with_trouble<CR>")
map("n","<leader>fs","<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols<CR>")


-- Git 
map("n","]c",   "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'")
map("n","[c",   "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'")

map("n","<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
map("n","<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
map("n","<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
map("n","<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
map("n","<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
map("n","<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
map("n","<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
map("n","<leader>hb", "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>")
map("n","<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
map("n","<leader>hU", "<cmd>Gitsigns reset_buffer_index<CR>")
map("n", "<LEADER>ng", [[<CMD>Neogit<CR>]])
map("n", "<LEADER>lg", [[<CMD>LazygitToggle<CR>]])
