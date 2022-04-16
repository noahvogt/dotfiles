set nocompatible

" set vim paths
set undodir="~/.cache/vim/undo"
set runtimepath+="~/.config/vim"

" make :find recursive
set path+=**
set wildignore+=*/node_modules/*
set wildignore+=*/__pycache__/*

" display all files for tab completion
set wildmenu

" making me comfortable
set number
set tabstop=4 softtabstop=4
set shiftwidth=4

"convert tabs to spaces
set expandtab
set nosmartindent
set nocindent
set smartcase

" disable swapfiles (mostly to avoid problems)
set noswapfile
set nobackup

set incsearch
set spelllang=de_ch,en
set noshowmode

" if hidden is not set, TextEdit might fail.
set hidden

" set height below statusline
set cmdheight=1

" faster update time for diagnostic messages (default is 4000)
set updatetime=300

" always show signcolumns
set signcolumn=yes

set colorcolumn=80

" set encoding
set encoding=utf-8

" enable mouse
set mouse=a

" horizontal splits will automatically be below
set splitbelow

" vertical splits will automatically be to the right
set splitright

" so that I can see `` in markdown files
set conceallevel=0

" make sure to enable syntax highlighting
syntax enable

" always show tabs
"set showtabline=2

" don't redraw while executing macros (good performance config)
set lazyredraw

" ignore case when searching
set ignorecase

" Show next 3 lines while scrolling.
if !&scrolloff
    set scrolloff=3       
endif

" Show next 5 columns while side-scrolling.
if !&sidescrolloff
    set sidescrolloff=5   
endif
