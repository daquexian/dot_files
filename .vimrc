set encoding=utf-8

set cmdheight=2

cmap w!! w !sudo tee > /dev/null %
cmap vsb vertical sb

let mapleader=","
map <leader>tl :TlistToggle<CR>

set autoindent

set expandtab
set tabstop=4 shiftwidth=4

set ignorecase
set smartcase

set noincsearch
set backspace=indent,eol,start
set wildmenu
highlight clear SignColumn
set hidden
set laststatus=2
set ruler
set cursorline
set cursorcolumn
" set hlsearch
set number
set nocompatible              " be iMproved, required
set foldmethod=syntax
set foldlevel=99
filetype off                  " required

highlight Pmenu ctermbg=gray guibg=gray     " set pmenu color to gray

nnoremap <leader>, :b#<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plug 'tenfyzhong/CompleteParameter.vim'
" inoremap <silent><expr> ( complete_parameter#pre_complete("()")
" smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

Plug 'drmikehenry/vim-headerguard'

Plug 'ludovicchabant/vim-gutentags'
" Thanks to https://zhuanlan.zhihu.com/p/36279445
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/share/gtags/gtags.conf'

Plug 'skywind3000/gutentags_plus'

Plug 'tenfyzhong/vim-gencode-cpp'

" Plug 'skywind3000/asyncrun.vim'

Plug 'vim-scripts/a.vim'

set noshowmode
Plug 'mhinz/vim-signify'

" Plug 'Shougo/echodoc.vim'
" let g:echodoc_enable_at_startup = 1

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

Plug 'justinmk/vim-dirvish'

Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_experimental_template_highlight = 1

Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'daquexian/project_manager.vim'

nmap <C-k> <Plug>(qf_qf_previous)
nmap <C-j> <Plug>(qf_qf_next)
nmap <Home> <Plug>(qf_qf_previous)
nmap <End>  <Plug>(qf_qf_next)
nmap <C-Home> <Plug>(qf_loc_previous)
nmap <C-End>  <Plug>(qf_loc_next)
"
"""""""""""""" vim-qf
Plug 'romainl/vim-qf'

Plug 'jiangmiao/auto-pairs'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>jj <Plug>(coc-rename)
nmap <silent> <leader>ji <Plug>(coc-diagnostic-info)
nmap <silent> <leader>jf <Plug>(coc-references)
nnoremap <silent> K :call CocActionAsync('doHover')<cr>
set updatetime=300
au CursorMoved * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
let g:coc_snippet_next = '<enter>'
" let g:coc_snippet_prev = '<S-TAB>'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_layout = {'down': '30%'}

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

Plug 'SirVer/ultisnips'

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <cr> ncm2_ultisnips#expand_or("\<cr>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
" let g:UltiSnipsRemoveSelectModeMappings = 0

" UltiSnips+NCM function parameter expansion

" We don't really want UltiSnips to map these two, but there's no option for
" that so just make it map them to a <Plug> key.
let g:UltiSnipsExpandTrigger       = "<Plug>(ultisnips_expand_or_jump)"
let g:UltiSnipsJumpForwardTrigger  = "<Plug>(ultisnips_expand_or_jump)"

" Try expanding snippet or jumping with UltiSnips and return <cr> if nothing
" worked.
function! UltiSnipsExpandOrJumpOrCr()
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return ""
  else
    return "\<cr>"
  endif
endfunction

" If that failed, try the UltiSnips expand or jump function. This handles
" short snippets when the completion popup isn't visible yet as well as
" jumping forward from the insert mode. Writes <CR> if there is no special
" action taken.
" inoremap <silent> <Plug>(ultisnips_try_expand) <C-R>=UltiSnipsExpandOrJumpOrCr()<CR>

" Select mode mapping for jumping forward with <CR>.
" snoremap <silent> <cr> <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>

"""""""""""""" ctrlp
Plug 'kien/ctrlp.vim'

"""""""""""""" ale
" Plug 'w0rp/ale'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=White
" let g:ale_linters = { 'cpp': ['clang-format', 'cppcheck', 'flawfinder'], 'c': ['clang-format', 'cppcheck', 'flawfinder'] }
" let g:ale_linters = { 'cpp': ['ccls', 'clang-format', 'cppcheck', 'flawfinder'], 'c': ['ccls', 'clang-format', 'cppcheck', 'flawfinder'] }
" let g:ale_c_ccls_init_options = {"clang":{"excludeArgs":["-save-temps", "-fopenmp"]}, "cacheDirectory":"/home/daquexian/.cache/ccls_for_ale"}
" let g:ale_cpp_ccls_init_options = {"clang":{"excludeArgs":["-save-temps", "-fopenmp"]}, "cacheDirectory":"/home/daquexian/.cache/ccls_for_ale"}
" let g:ale_linters = { 'cpp': ['cquery', 'clang-format', 'cppcheck', 'flawfinder'], 'c': ['cquery', 'clang-format', 'cppcheck', 'flawfinder'] }
" let g:ale_linters = { 'cpp': ['cquery', 'clang-format'], 'c': ['cquery', 'clang-format', 'cppcheck', 'flawfinder'] }

"""""""""""""" rainbow
Plug 'luochen1990/rainbow'
let g:rainbow_active = 0

"""""""""""""" vim-airline
Plug 'vim-airline/vim-airline'
let g:airline#extensions#languageclient#enabled = 1
let airline#extensions#languageclient#error_symbol = 'E:'
let airline#extensions#languageclient#warning_symbol = 'W:'
let airline#extensions#languageclient#show_line_numbers = 1
let airline#extensions#languageclient#open_lnum_symbol = '(L'
let airline#extensions#languageclient#close_lnum_symbol = ')'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#exclude_preview = 1
" let airline#extensions#tabline#disable_refresh = 1
" let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

"""""""""""""" nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let g:NERDTreeDirAllows=0
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>ll :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
let NERDTreeShowHidden=0
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

"""""""""""""" taglist
Plug 'vim-scripts/taglist.vim'
let Tlist_Ctags_Cmd='ctags'
let Tlist_Show_One_File=1               "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt =28                   "设置taglist的宽度
let Tlist_Exit_OnlyWindow=1             "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window=1           "在右侧窗口中显示taglist窗口
"let Tlist_Use_Left_Windo =1             "在左侧窗口中显示taglist窗口 

"""""""""""""" vim-prototxt
Plug 'chiphogg/vim-prototxt', { 'for': 'prototxt' }

"""""""""""""" vim-numbertoggle
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"""""""""""""" tcomment_vim
Plug 'tomtom/tcomment_vim'

"""""""""""""" vim-lldb
" Plug 'gilligan/vim-lldb'

Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }

""""""""""""""

Plug 'kassio/neoterm'

""""""""""""""


Plug 'ayu-theme/ayu-vim' " or other package manager
set termguicolors     " enable true colors support

call plug#end()            " required

filetype plugin indent on    " required
syntax on

" set fixed height of preview window
set previewheight=20
au BufEnter ?* call PreviewHeightWorkAround()
func PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc

" close preview window for completion
set completeopt-=preview

" For prototxt
au Filetype prototxt setl tabstop=2 shiftwidth=2

map <C-u> :py3f /usr/share/clang/clang-format.py<cr>
imap <C-u> <c-o>:py3f /usr/share/clang/clang-format.py<cr>
function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format.py
endfunction
" autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
" map <C-K> :pyf <path-to-this-file>/clang-format.py<cr>
" imap <C-K> <c-o>:pyf <path-to-this-file>/clang-format.py<cr>

autocmd VimEnter * call fzf#vim#with_preview('right:50%:hidden', '?')

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nmap <A-r> <Plug>BuildAndRun
nmap <A-u> <Plug>Run
nmap <A-s> <Plug>SelectConfig
nmap <A-e> <Plug>OpenConfig
nmap <A-c> :Tclose<cr>
nmap <A-o> :Topen<cr>

function! g:ConfigCallback()
    execute 'silent !ln -sf ' . g:cpp_project_props['build_dir'] . '/compile_commands.json'
    if exists(':CocRestart')
        execute 'CocRestart'
    endif
endfunction

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

source $HOME/.vimrc.local
