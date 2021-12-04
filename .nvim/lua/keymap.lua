
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
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n","<leader>Q",":qa<CR>")


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
-- bufferline
map("n","<leader>b]",":BufferLineCycleNext<CR>")
map("n","<leader>b[",":BufferLineCyclePrev<CR>")
-- Vista
map("n","<leader>tl",":Vista!!<CR>")
-- lua require('telescope.builtin').
map("n","<leader>ff","<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n","<leader>fg","<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n","<leader>fb","<cmd>lua require('telescope.builtin').buffers()<CR>")
map("n","<leader>fh","<cmd>lua require('telescope.builtin').help_tags()<CR>")

map("t", "<C-n>", [[<C-\><C-n>]])

map("n", "<LEADER>tf", [[:lua require('telescope.builtin').find_files{}<CR>]])
map("n", "<LEADER>tg", [[:lua require('telescope.builtin').live_grep{}<CR>]])

map("n", "<LEADER>ng", [[<CMD>Neogit<CR>]])
map("n", "<LEADER>lg", [[<CMD>LazygitToggle<CR>]])
