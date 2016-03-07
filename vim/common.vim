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

let mapleader=','

filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
call vundle#end()
syntax on
filetype plugin indent on

let g:syntastic_mode_map={"mode": "passive"}
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_javascript_checkers=['eslint']
