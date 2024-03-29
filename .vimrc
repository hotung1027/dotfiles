
" Leader
let g:mapleader=";"


filetype on

filetype plugin indent on
set encoding=UTF-8
" <<

" >>
" VIM Configuration

"
nmap LB 0
nmap LE $

" Copy
vnoremap <Leader>y "+y
" Paste
nmap <Leader>p "+p

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>

" 设置快捷键遍历子窗口
" 依次遍历
nnoremap nw <C-W><C-W>
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <Leader>v :vsplit<CR>
nnoremap <leader>h  :split<CR>
" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" <<

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" >>
" 其他

" 开启实时搜索功能
set incsearch

" 搜索时大小写不敏感
set ignorecase

" 关闭兼容模式
set nocompatible
set hidden
" vim 自身命令行模式智能补全
set wildmenu

" <<

" >>>>
" 插件安装

" vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/repos/github.com/Shougo/dein.vim
call dein#begin('~/.vim/bundle')
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
"""""""""""""""""""""""
" Package Manager
""""""""""""""""""""""
call dein#add('Shougo/dein.vim')
call dein#add('wsdjeg/dein-ui.vim')

call dein#add('vim-denops/denops.vim')

""""""""""""""""""""""""""
" Neovim 2 Vim Support
"""""""""""""""""
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif


""""""""""""""""""""""""""""""""
" COLORSCHEME
"""""""""""""""""""""""""""""
call dein#add( 'altercation/vim-colors-solarized')
call dein#add( 'rakr/vim-one')
call dein#add( 'vim-airline/vim-airline')
call dein#add( 'vim-airline/vim-airline-themes')
call dein#add( 'nathanaelkane/vim-indent-guides')


call dein#add( 'derekwyatt/vim-fswitch')

""""""""""""""""""""""""""""""""""""""""""""
" NCM2
""""""""""""""""""""""""""""""""""""""""""""
call dein#add('ncm2/ncm2')

call dein#add( 'Shougo/pum.vim')

"""""""""""""""""""""""""""""""""""""""""""
" DOCUMENTATION
"""""""""""""""""""""""""""""""""""""""""""
" call dein#add('Shougo/echodoc.vim')
call dein#add( 'matsui54/denops-popup-preview.vim')


"""""""""""""""
" SOURCE
"""""""""""""""
call dein#add('ncm2/ncm2-vim-lsp')
call dein#add( 'ncm2/ncm2-bufword')
call dein#add('ncm2/ncm2-path')
call dein#add('ncm2/ncm2-gtags')
call dein#add('ncm2/ncm2-syntax')
call dein#add('Shougo/neco-syntax')
call dein#add('yuki-yano/ncm2-dictionary')
cal dein#add( 'ncm2/ncm2-tagprefix')
call dein#add('ncm2/ncm2-neosnippet')
call dein#add('ncm2/ncm2-match-highlight')

""""""""""""""
" FILTER
""""""""""""""


"""""""""""""
" FILTER
"""""""""""""


"""""""""""""""""""""

"""""""""""""""""""""
" VIM LSP CONFIG
"""""""""""""""""""""
call dein#add( 'prabirshrestha/vim-lsp')
call dein#add( 'mattn/vim-lsp-settings')
call dein#add('hrsh7th/vim-vital-vs')
""""""""""""""""""""
" Snippet
""""""""""""""""""""
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')



call dein#add( 'thomasfaingnaert/vim-lsp-snippets')
call dein#add( 'thomasfaingnaert/vim-lsp-neosnippet')

"""""""""""""""""""""
" Or build from source code by using yarn: https://yarnpkg.com
call dein#add('junegunn/fzf',{'path':'~/.fzf','build':'./install --all'})
call dein#add('junegunn/fzf.vim')

""""""""""""""""""""
" Diagnostic
""""""""""""""""""""
call dein#add( 'dense-analysis/ale')
call dein#add( 'rhysd/vim-lsp-ale')
" call dein#add( 'neomake/neomake')


""""""""""""""""""""
" GOOGLE Quality Of Life
""""""""""""""""""""


""""""""""""""""""""""""""""""""
" TAGS
"""""""""""""""""""""""""""""""
call dein#add( 'liuchengxu/vista.vim')
call dein#add( 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines')

call dein#add( 'vim-ctrlspace/vim-ctrlspace')

call dein#add( 'terryma/vim-multiple-cursors')

call dein#add( 'derekwyatt/vim-protodef')

""""""""""""""""""
" NERDTREE
""""""""""""""""""
call dein#add( 'preservim/nerdtree')
call dein#add( 'scrooloose/nerdcommenter')
call dein#add( 'Xuyuanp/nerdtree-git-plugin')
call dein#add( 'tiagofumo/vim-nerdtree-syntax-highlight')
call dein#add( 'scrooloose/nerdtree-project-plugin')
call dein#add( 'PhilRunninger/nerdtree-visual-selection')
call dein#add( 'ryanoasis/vim-devicons')

"""""""""""""""""""""""
" DEFX
"""""""""""""""""""""""""
if has('nvim')

    call dein#add( 'kyazdani42/nvim-web-devicons') " for file icons
    call dein#add('kyazdani42/nvim-tree.lua')
endif







call dein#add( 'gcmt/wildfire.vim')
call dein#add( 'Lokaltog/vim-easymotion')
call dein#add( 'suan/vim-instant-markdown')
call dein#add( 'mbbill/undotree')


call dein#add('will133/vim-dirdiff')

"""""""""""""""""""""""""""""""""""""""""""
" TMUX
""""""""""""""""""""""""""""""""""""""""""""
call dein#add( 'christoomey/vim-tmux-navigator')
call dein#add( 'wellle/tmux-complete.vim')


"""""""""""""""""""
" LAUNGUAGE SPECIFIC
"""""""""""""""""""
" RUST
call dein#add( 'rust-lang/rust.vim')
" HASKELL
call dein#add( 'hasufell/ghcup.vim')
" 插件列表结束
call dein#end()


function DeinCleanInstallAndUpdate()
    call map(dein#check_clean(),{_, val -> delete(val, 'rf')})
    let g:dein#install_progress_type = 'echo'
    if !dein#check_install()
        call dein#install()
    endif
    call dein#recache_runtimepath()
    DeinUpdate
endfunction

filetype plugin indent on
" <<<<

" 配色方案
let g:solarized_termcolor=256
let g:airline_theme='one'
set encoding=UTF-8
if has("gui_running")
    set background=light " for the light version
    colorscheme solarized
    let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
else
    colorscheme one
    set background=dark " for the dark version
endif
if executable('rg')
    let g:CtrlSpaceGlobCommand = 'rg --color=never --files'
elseif executable('fd')
    let g:CtrlSpaceGlobCommand = 'fd --type=file --color=never'
elseif executable('ag')
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
"colorscheme solarized
"colorscheme molokai
"colorscheme phd

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (&term == "screen")
    set t_Co=256
endif
if (has('termguicolors'))
  set termguicolors
endif
" >>
" 营造专注气氛

" 禁止光标闪烁
set gcr=a:block-blinkon0

" 禁止显示滚动条
set guioptions-=l
set guioptions-=l
set guioptions-=r
set guioptions-=r
set guifont="DroidSansMono Nerd Font Mono "
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFuxlscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
"" 启动 vim 时自动全屏
"autocmd VimEnter * call ToggleFullscreen()
" <<

" >>
" 辅助信息

" 总是显示状态栏
set laststatus=2

" 显示光标当前位置
set ruler

" 开启行号显示
set number

" 高亮显示当前行/列
set cursorline
set cursorcolumn

" 高亮显示搜索结果
set hlsearch

" <<

" >>
" 其他美化

" 设置 gvim 显示字体
let g:one_allow_italics = 1






" 禁止折行
set nowrap

" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'

"
" air-line
"
let g:airline_powerline_fonts = 1

" <<
" powerline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

let g:airline_filetype_overrides = {
  \ 'coc-explorer':  [ 'CoC Explorer', '' ],
  \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
  \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
  \ 'floggraph':  [ 'Flog', '%{get(b:, "flog_status_summary", "")}' ],
  \ 'gundo': [ 'Gundo', '' ],
  \ 'help':  [ 'Help', '%f' ],
  \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
  \ 'startify': [ 'startify', '' ],
  \ 'vim-plug': [ 'Plugins', '' ],
  \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
  \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
  \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
  \ }

" eanble tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 0


"* enable/disable coc integration >
let g:airline#extensions#coc#enabled = 1

"* change error symbol: >
let airline#extensions#coc#error_symbol = 'E:'

"* change warning symbol: >
let airline#extensions#coc#warning_symbol = 'W:'

"* enable/disable coc status display >
let g:airline#extensions#coc#show_coc_status = 1
" >>
" 语法分析

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" <<

" >>
" 缩进

" 自适应不同语言的智能缩进
filetype indent on

" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

set backspace=indent,eol,start
" 缩进可视化插件 Indent Guides
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" <<

" >>
" 代码折叠

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" <<

" >>
" 接口与实现快速切换

" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>

" <<

" >>
" 代码收藏

" 自定义 vim-signature 快捷键
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

" <<

" >>
" 标签列表
"""""""""""""""""""""""""
" VISTA
"""""""""""""""""""""""""
" Require universal-ctags

nnoremap <leader>tl  :Vista!!<CR>

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && index(['vista','vista_kind'],&filetype) >= 0 | quit | endif
" If another buffer tries to replace NERDTree, put in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ '__vista__\d\+' && bufname('%') !~'__vista__\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
    \ 'c' : 'vim_lsp',
    \ 'cpp': 'vim_lsp',
    \ 'python' : 'vim_lsp',
    \ 'haskell' : 'vim_lsp',
    \ 'julia' : 'vim_lsp'
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_executable='ctags'
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }


function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_king = 1
let g:vista#renderer#enable_icon = 1
autocmd FileType vista,__vista__,vista_kind nnoremap <buffer><silent>/ :<c-u>call vista#finder#fzf#Run()<CR>

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" 设置 tagbar 子窗口的位置出现在主编辑区的左边
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
" 设置标签子窗口的宽度


" <<

" >>
" 代码导航

" 基于标签的代码导航

" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

" 基于语义的代码导航


" <<

" >>
" 查找

" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :CtrlSF<CR>


" <<

" >>
" 内容替换

" 快捷替换
let g:multi_cursor_next_key='<S-n>'
let g:multi_cursor_skip_key='<S-k>'

" 精准替换
" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" <<

" 模板补全
""""""""""""""""""""""""""""""""""""""""""""""
"
" NERDTreeAutoDeleteBuffermeplteiont
"
"
""""""""""""""""""""""""""""""""""""""""""""""""

set shortmess+=c

au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
au User Ncm2PopupClose set completeopt=menuone
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd CompleteDone * silent! pclose!
autocmd InsertLeave * silent! pclose!
autocmd TextChangedI * call ncm2#auto_trigger()

""""""
" Matcher
""""""
let g:ncm2#matcher={'name' : 'combine',
                    \ 'matchers' : [
                    \ {'name' : 'abbrfuzzy' , 'key' : 'menu'},
                    \ {'name' : 'prefix', 'key' : 'word'},
                \   ]}

""""""
" Filter
""""""
let g:ncm2#filter = [
            \   {
                \   'name' : 'dedup',
            \   },
            \   {
                \   'name' : 'substitute',
                \   'pattern' : '[\s(\s].*$',
                \   'replace' : '',
                \   'key' : 'word'
            \   },
            \   {
                \   'name' : 'abbr_ellipsis',
                \   'ellipsis' : '..',
                \   'limit' : 25,
            \   },
            \ ]

""""""
" Sorter
"""""
" let g:ncm2#sorter = {}
let g:ncm2#complete_length = [[1,4],[4,3],[7,2]]
let g:ncm2#total_popup_limit = 20


""""""""""""""
" PUM.VIM
"""""""""""""


" <S-TAB>: completion back.
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' :  ncm2#manual_trigger()
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<S-Tab>'

""""""""
" VIM LSP
"""""""
let g:lsp_semantic_enabled = 1
let g:lsp_completion_documentation_enabled=1
let g:lsp_preview_float = 1
let g:lsp_documentation_float = 1
let g:lsp_hover_ui='float'
let g:lsp_signature_help_enabled=0
" Close preview window with <esc>
autocmd User lsp_float_opened nmap <buffer> <silent> <esc>
          \ <Plug>(lsp-preview-close)
autocmd User lsp_float_closed call lsp#ui#vim#output#closepreview()
augroup lsp_float_colours
    autocmd!
    if !has('nvim')
    autocmd User lsp_float_opened
        \ call setwinvar(lsp#ui#vim#output#getpreviewwinid(),
        \		       '&wincolor', 'PopupWindow')
    else
    autocmd User lsp_float_opened
        \ call nvim_win_set_option(
        \   lsp#ui#vim#output#getpreviewwinid(),
        \   'winhighlight', 'Normal:PopupWindow')
    endif
augroup end
let g:lsp_settings = {
    \  'haskell-language-server': {
        \   'cmd' : ['haskell-language-server-wrapper','--lsp'],
        \   'allowlist' : ['haskell','lhaskell'],
        \   'root_uri_patterns' : ['*.cabal', 'stack.yaml', 'cabal.project','package.yaml','hie.yaml'],
    \ },
    \  'efm-langserver': {
        \   'disabled': v:false
        \ },
\ }
let g:lsp_settings_filetype_haskell = ['haskell-language-server']

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    noremap <buffer> gd <plug>(lsp-definition)
    noremap <buffer> <f2> <plug>(lsp-rename)
    noremap <buffer> gs <plug>(lsp-document-symbol-search)
    noremap <buffer> gS <plug>(lsp-workspace-symbol-search)
    noremap <buffer> gr <plug>(lsp-references)
    noremap <buffer> gi <plug>(lsp-implementation)
    noremap <buffer> gt <plug>(lsp-type-definition)
    noremap <buffer> g[ <plug>(lsp-previous-diagnostic)
    noremap <buffer> g] <plug>(lsp-next-diagnostic)
    noremap <buffer> gk <plug>(lsp-hover)
    noremap <buffer> <F5> <plug>(lsp-code-lite_minlines)
    autocmd! BufWritePre call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    let g:lsp_signs_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_signs_error = {'text': '✗'}
    let g:lsp_signs_warning = {'text': '‼'}
    let g:lsp_highlight_references_enabled = 1
    let g:lsp_diagnostics_enabled = 1
    let g:lsp_document_highlight_enabled=1
    call popup_preview#enable()
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

""""""""
" ALE
""""""""
" Write this in your vimrc file
let g:ale_lint_on_insert_leave = 1
let g:ale_set_highlights = 0
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 0
let g:ale_linters = {
\   'haskell': ['ormolu'],
\}
let g:ale_fixers = {
            \    '*' : ['remove_trailing_lines','trim_whitespace'],
            \    'haskell' : ['ormolu'],
            \    }
let g:ale_hover_to_preview=1
let g:ale_cursor_detail=1
let g:ale_detail_to_floating_preview=1
let g:ale_floating_preview=1
let g:ale_lsp_suggestions=1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Use DDC completion
" Set this. disable airline use LSP instead.
let g:airline#extensions#ale#enabled = 0

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}

""""""""""""""""""""""""""
" CTRL SPACE
"""""""""""""""""""""""""
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
map <C-@> :CtrlSpace<CR>
let g:CtrlSpaceDefaultMappingKey = "<C-space> "


"""
" ECHO DOC
"""
if !has('nvim')
" Or, you could use vim's popup window feature.
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'popup'
" To use a custom highlight for the popup window,
" change Pmenu to your highlight group
    highlight link EchoDocPopup Pmenu
else
    " Or, you could use neovim's floating text feature.
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
    highlight link EchoDocFloat Pmenu
endif

" >>
" YCM 补全

" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1

" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0

" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=0
"" 引入 C++ 标准库 tags
"set tags+=/data/misc/software/app/vim/stdcpp.tags
"set tags+=/data/misc/software/app/vim/sys.tags

" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
"inoremap <leader> <C-x><C-o>

" 补全内容不以分割子窗口形式出现，只显示补全列表

" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1

" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0

" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_echo_current_diagnostic = 1
" <<

" <<
" DDC Configuration
" >>
" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
" >>
" 由接口快速生成实现框架

" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

" <<

" >>
" 库信息参考

" 启用:Man命令查看各类man信息
source $VIMRUNTIME/ftplugin/man.vim

" 定义:Man命令查看各类man信息的快捷键
nmap <Leader>man :Man 3 <cword><CR>

" <<

" >>
" 工程文件浏览

" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
"if has('nvim')
"    nmap <Leader>fl :Defx<CR>
"else
    nmap <Leader>fl :NERDTreeToggle<CR>
"endif
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize=22
" 设置 NERDTree 子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" If another buffer tries to replace NERDTree, put in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

""""""""""""""
" DEFX
""""""""""""


" >>
" 多文档编辑

" 显示/隐藏 MiniBufExplorer 窗口

" buffer 切换快捷键

" <<


" >>
" 环境恢复

" 设置环境保存项
set sessionoptions="blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"

" 保存 undo 历史。必须先行创建 .undo_history/
set undodir=~/.undo_history/
set undofile

" 保存快捷键
"map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
map <leader>ss :mksession! my.vim<cr>

"sasd 恢复快捷键
"map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>
map <leader>rs :source my.vim<cr>

" <<

" 设置快捷键实现一键编译及运行
nmap <Leader>m :wa<CR> :cd build/<CR> :!rm -rf main<CR> :!cmake CMakeLists.txt<CR>:make<CR><CR> :cw<CR> :cd ..<CR>
nmap <Leader>g :wa<CR>:cd build/<CR>:!rm -rf main<CR>:!cmake CMakeLists.txt<CR>:make<CR><CR>:cw<CR>:cd ..<CR>:!build/main<CR>

" >>
" 快速选中结对符内的文本

" 快捷键
map <SPACE> <Plug>(wildfire-fuel)
vmap <S-SPACE> <Plug>(wildfire-water)

" 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" <<

" 调用 gundo 树
nnoremap <C-Z> :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir="$HOME/.undo_history"
    set undofile
endif

" TMUX Configuration
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-k> :TmuxNavigateDown<cr>
nnoremap <silent> <c-j> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 1
" If the tmux window is zoomed, keep it zoomed when moving from Vim to another pane
let g:tmux_navigator_preserve_zoom = 1

"
" FZF
"

let g:fzf_layout = {'up': '20%', 'window' : {'width' : 1, 'height' : 0.3 , 'yoffset' : 0.05 , 'relative' : v:true , 'border' : 'rounded' } }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
