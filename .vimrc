set encoding=utf-8

cmap w!! w !sudo tee > /dev/null %
map <C-h> :bp<CR>
map <C-l> :bn<CR>
let mapleader=","
map <leader>tl :TlistToggle<CR>
" 开启实时搜索功能
" set incsearch
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

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'w0rp/ale'
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1

Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#exclude_preview = 1
let airline#extensions#tabline#disable_refresh = 0
let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#show_tabs = 0
Plugin 'scrooloose/nerdtree'
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

Bundle 'taglist.vim'
let Tlist_Ctags_Cmd='ctags'
let Tlist_Show_One_File=1               "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt =28                   "设置taglist的宽度
let Tlist_Exit_OnlyWindow=1             "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window=1           "在右侧窗口中显示taglist窗口
"let Tlist_Use_Left_Windo =1             "在左侧窗口中显示taglist窗口 

"""""""""""""
call vundle#end()            " required
filetype plugin indent on    " required
syntax on
