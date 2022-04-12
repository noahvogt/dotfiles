" Run PlugInstall if there are missing plugins
"autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"  \| PlugInstall --sync | source $VIMINIT
"\| endif


call plug#begin('~/.cache/vim/plugged')

" colorshemes
"Plug 'morhetz/gruvbox'
"Plug 'itchyny/landscape.vim'
"Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'

" better syntax support
Plug 'sheerun/vim-polyglot'

" fuzzy find files
Plug 'ctrlpvim/ctrlp.vim'

" faster nerdtree
Plug 'lambdalisue/fern.vim'
" with git status integration
Plug 'lambdalisue/fern-git-status.vim'

" asynchronous lint engine
"Plug 'dense-analysis/ale'

" nice statusline for vim
Plug 'vim-airline/vim-airline'
" plus themes
Plug 'vim-airline/vim-airline-themes'

" some git integration
Plug 'tpope/vim-fugitive'

" preview colours
Plug 'ap/vim-css-color'

" intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" auto disable search highlighting
Plug 'romainl/vim-cool'

" graphical debugger
"Plug 'puremourning/vimspector'

Plug 'kien/rainbow_parentheses.vim'

call plug#end()