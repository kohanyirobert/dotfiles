set nocompatible
set backspace=eol,start,indent
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set showcmd
set number
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=utf8
set fileencoding=utf-8
set fileformat=unix
set laststatus=2
set list
set listchars=eol:$,tab:>-,trail:-
set history=100
set wildmode=longest,full
set wildmenu
set autoindent
set iminsert=0
set imsearch=-1
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mbbill/undotree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'leafgarland/typescript-vim'
Plugin 'posva/vim-vue'
call vundle#end()
syntax on
filetype plugin indent on

let g:ctrlp_custom_ignore={'dir': 'node_modules'}

let g:syntastic_mode_map={"mode": "passive"}
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_javascript_checkers=['eslint']

let g:session_autosave='yes'
let g:session_autosave_periodic='yes'
let g:session_persist_font=0
let g:session_persist_colors=0
