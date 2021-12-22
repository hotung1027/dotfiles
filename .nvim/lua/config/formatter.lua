vim.cmd([[
  function! neoformat#formatters#haskell() abort() 
  return {
    \ 'exe' : 'pointfree',
    \ 'args' : [''],
  }
end
]])

vim.ormolu_ghc_opt = {'TypeApplications','RankNTypes'}
vim.g.neoformat_enabled_haskell = {'sortimports','brittany','pointfree'}
vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])
