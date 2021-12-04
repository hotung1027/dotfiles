
-- theme
vim.opt.termguicolors=true
vim.opt.background="dark"
local theme = "gruvbox8"

local function gruvbox_setup()
end



local theme_opt = {
  ["gruvbox8"] = gruvbox_setup,
}

theme_opt[theme]()

vim.cmd("colorscheme "..theme)
