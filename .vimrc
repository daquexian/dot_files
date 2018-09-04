set encoding=utf-8

set cmdheight=2

cmap w!! w !sudo tee > /dev/null %
cmap vsb vertical sb

let mapleader=","
map <leader>tl :TlistToggle<CR>

set autoindent

set expandtab
set tabstop=4 shiftwidth=4

" 开启实时搜索功能
" set incsearch
set backspace=indent,eol,start
set wildmenu
set background=dark
" colorscheme molokai
" let g:molokai_original=1
" let g:rehash256=1
highlight clear SignColumn
set hidden
set laststatus=2
set ruler
set cursorline
set cursorcolumn
" set hlsearch
set number
set nocompatible              " be iMproved, required
filetype off                  " required

highlight Pmenu ctermbg=gray guibg=gray     " set pmenu color to gray

nnoremap <leader>, :b#<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tenfyzhong/CompleteParameter.vim'
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <A-j> <Plug>(complete_parameter#goto_next_parameter)
imap <A-j> <Plug>(complete_parameter#goto_next_parameter)
smap <A-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <A-k> <Plug>(complete_parameter#goto_previous_parameter)

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

Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup = 1

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

Plug 'justinmk/vim-dirvish'

Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_experimental_template_highlight = 1

Plug 'tpope/vim-unimpaired'

"""""""""""""" async.vim
" Plug 'prabirshrestha/async.vim'
"""""""""""""" vim-lsp
" Plug 'prabirshrestha/vim-lsp'
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" nnoremap <leader>jd :LspDefinition<CR>
" nnoremap <leader>jf :LspReferences<CR>
" nnoremap <leader>jj :LspRename<CR>
nmap <C-k> <Plug>(qf_qf_previous)
nmap <C-j> <Plug>(qf_qf_next)
nmap <Home> <Plug>(qf_qf_previous)
nmap <End>  <Plug>(qf_qf_next)
nmap <C-Home> <Plug>(qf_loc_previous)
nmap <C-End>  <Plug>(qf_loc_next)
" if executable('cquery')
   " au User lsp_setup call lsp#register_server({
      " \ 'name': 'cquery',
      " \ 'cmd': {server_info->['cquery']},
      " \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      " \ 'initialization_options': { 'cacheDirectory': '/home/daquexian/tmp' },
      " \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      " \ })
" endif
" if executable('pyls')
    " au User lsp_setup call lsp#register_server({
        " \ 'name': 'pyls',
        " \ 'cmd': {server_info->['pyls']},
        " \ 'whitelist': ['python'],
        " \ })
" endif

"""""""""""""" asynccomplete.vim
" Plug 'prabirshrestha/asyncomplete.vim'
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
"""""""""""""" asynccomplete-lsp.vim
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
"""""""""""""" vim-qf
Plug 'romainl/vim-qf'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>jd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>jj :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>jf :call LanguageClient#textDocument_references()<CR>

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'cpp': ['ccls'],
    \ 'c': ['ccls'],
    \ }

"""""""""""""" YCM
" function! BuildYCM(info)
  " if a:info.status == 'installed' || a:info.force
    " !./install.py --clang-completer --system-libclang
  " endif
" endfunction
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" let g:ycm_python_binary_path = '/usr/bin/python3'
" " let g:ycm_python_binary_path = '/usr/local/bin/python3'
" " nnoremap <leader>jd :YcmCompleter GoTo<CR>
" let g:ycm_global_ycm_extra_conf = '/home/daquexian/dot_files/.ycm_extra_conf.py'
" let g:ycm_show_diagnostics_ui = 0
" let g:ycm_semantic_triggers =  {
            " \ 'c,cpp,python,java,go,erlang,perl': ['re!\w'],
            " \ 'cs,lua,javascript': ['re!\w'],
            " \ }
"""""""""""""" ctrlp
Plug 'kien/ctrlp.vim'

"""""""""""""" ale
Plug 'w0rp/ale'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=White
let g:ale_linters = { 'cpp': ['cquery', 'clang-format', 'cppcheck', 'flawfinder'], 'c': ['cquery', 'clang-format', 'cppcheck', 'flawfinder'] }
" let g:ale_linters = { 'cpp': ['cquery', 'clang-format'], 'c': ['cquery', 'clang-format', 'cppcheck', 'flawfinder'] }

"""""""""""""" rainbow
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

"""""""""""""" vim-airline
Plug 'vim-airline/vim-airline'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#exclude_preview = 1
" let airline#extensions#tabline#disable_refresh = 1
" let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1

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
""""""""""""""
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
