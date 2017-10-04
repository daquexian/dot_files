set encoding=utf-8

cmap w!! w !sudo tee > /dev/null %
cmap vsb vertical sb

map <C-h> :bp<CR>
map <C-l> :bn<CR>
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
set hidden
set laststatus=2
set ruler
set cursorline
set cursorcolumn
" set hlsearch
set number
set nocompatible              " be iMproved, required
filetype off                  " required


call plug#begin()

"""""""""""""" YCM
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_python_binary_path = '/usr/local/bin/python3'
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_global_ycm_extra_conf = '~/vimrc/.ycm_extra_conf.py'

"""""""""""""" ctrlp
Plug 'kien/ctrlp.vim'

"""""""""""""" ale
Plug 'w0rp/ale'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=White
" let g:ale_linters = { 'cpp': [] }

"""""""""""""" rainbow
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

"""""""""""""" vim-airline
Plug 'vim-airline/vim-airline'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#exclude_preview = 1
let airline#extensions#tabline#disable_refresh = 0
let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#show_tabs = 0

"""""""""""""" nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let g:NERDTreeDirAllows=0
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
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
"""""""""""""
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
