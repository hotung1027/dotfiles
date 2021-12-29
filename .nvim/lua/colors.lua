
-- theme
vim.opt.termguicolors=true
vim.opt.background="dark"

local theme = "kanagawa"

local function gruvbox_setup()
end
local default_colors = require('kanagawa.colors')
local overrides = {
    -- create a new hl-group using default palette colors and/or new ones
    MyHlGroup1 = { fg = default_colors.waveRed, bg = "#AAAAAA", style="underline,bold", guisp="blue" },
    -- override existing hl-groups, the new keywords are merged with existing ones
    VertSplit  = { fg = default_colors.bg_dark, bg = "NONE" },
    TSError    = { link = "Error" },
    TSKeywordOperator = { style = 'bold'},
}
local function kanagawa_setup()
  require('kanagawa').setup({
      undercurl = true,           -- enable undercurls
      commentStyle = "italic",
      functionStyle = "NONE",
      keywordStyle = "italic",
      statementStyle = "bold",
      typeStyle = "NONE",
      variablebuiltinStyle = "italic",
      specialReturn = true,       -- special highlight for the return keyword
      specialException = true,    -- special highlight for exception handling keywords 
      transparent = false,        -- do not set background color
      colors = default_colors,
      overrides = overrides,
  })
end

local theme_opt = {
  ["gruvbox8"] = gruvbox_setup,
  ["kanagawa"] = kanagawa_setup,
}

theme_opt[theme]()

-- vim.cmd("colorscheme kanagawa")
vim.cmd("colorscheme "..theme)
