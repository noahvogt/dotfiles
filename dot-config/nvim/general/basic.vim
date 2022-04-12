set nocompatible

" set vim paths
set undodir="~/.cache/vim/undo"
set viminfo="~/.cache/vim/viminfo"
set runtimepath+="~/.config/vim"

" make :find recursive
set path+=**

" display all files for tab completion
set wildmenu

" making me comfortable
set nu
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nosmartindent
set nocindent
set smartcase
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
