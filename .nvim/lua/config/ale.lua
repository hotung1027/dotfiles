vim.g.ale_floating_preview = 1
vim.cmd([[
let g:ale_fixers = {
\ '*' : ['remove_trailing_lines','trim_whitespace'],
\   'haskell' : ['brittany'],
\ }
]])
vim.cmd([[
  let g:ale_fix_on_save = 1
]])
vim.cmd([[
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
]])
vim.cmd([[
  let g:ale_linters = {
  \ 'haskell' : ['hls']
  \ }
]])
vim.cmd([[
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
]])


