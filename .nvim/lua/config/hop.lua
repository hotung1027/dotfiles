vim.cmd [[ hi HopNextKey cterm=bold ctermfg=176 gui=bold guibg=#ff00ff guifg=#ffffff ]]
require('hop').setup({
  case_insensitive = true,
  char2_fallback_key = '<CR>',
})
