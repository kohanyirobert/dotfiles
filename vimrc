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
call vundle#end()
syntax on
filetype plugin indent on

nnoremap <c-l> :nohlsearch<cr>
noremap . :normal .<cr>
noremap <leader>w :write<cr>
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap jk <esc>
inoremap <esc> <nop>
