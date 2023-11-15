vim.cmd([[
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
]])
vim.g.vista_default_executive = "ctags"
vim.g.vista_ctags_executable = "ctags"


vim.cmd([[
let g:vista_executive_for = {
\ 'cpp' : ['nvim_lsp','ctags'],
\ 'c' : ['nvim_lsp','ctags'],
\ }
]])

vim.cmd([[
let g:vista_ctags_cmd = {
\ 'haskell' : 'hasktags -x -o - -c',
\ }
]])

vim.cmd([[let g:vista#renderer#enable_icon = 1]])
vim.cmd([[let g:vista#renderer#enable_kind = 1]])

vim.g.vista_update_on_text_changed = 1
vim.cmd([[
  let g:vista#renderer#icons ={
  \ "function" : "",
  \ "variable" : "",
  \ }
]])

