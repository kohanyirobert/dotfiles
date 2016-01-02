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

filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
call vundle#end()
syntax on
filetype plugin indent on

nnoremap <C-L> :nohlsearch<CR>
vnoremap . :normal .<CR>
