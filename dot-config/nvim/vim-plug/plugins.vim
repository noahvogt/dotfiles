" Run PlugInstall if there are missing plugins
"autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"  \| PlugInstall --sync | source $VIMINIT
"\| endif

function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

call plug#begin('~/.cache/vim/plugged')

" colorshemes
Plug 'morhetz/gruvbox'
Plug 'itchyny/landscape.vim'
Plug 'joshdick/onedark.vim'

" better syntax support
Plug 'sheerun/vim-polyglot'

" fuzzy find files
Plug 'ctrlpvim/ctrlp.vim'

" faster nerdtree
Plug 'lambdalisue/fern.vim', {'branch': 'main'}
" w/ git status integration
Plug 'lambdalisue/fern-git-status.vim'
" w/ colored nerdfont icons
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
" and a floating, scrollable preview window
Plug 'yuki-yano/fern-preview.vim'

" asynchronous lint engine
"Plug 'dense-analysis/ale'

" nice statusline for vim
Plug 'vim-airline/vim-airline'
" plus themes
Plug 'vim-airline/vim-airline-themes'

" some git integration
Plug 'tpope/vim-fugitive'

" intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" auto disable search highlighting
Plug 'romainl/vim-cool'

" graphical debugger
"Plug 'puremourning/vimspector'

" use when there are too many parentheses
"Plug 'kien/rainbow_parentheses.vim'

" auto close pairs, etc.
"Plug 'jiangmiao/auto-pairs'

" easy commenting
Plug 'tpope/vim-commentary'

" tag bar for easy navigation
Plug 'preservim/tagbar'

" better html / css handling
Plug 'mattn/emmet-vim'

" fast search 'n' jump
Plug 'justinmk/vim-sneak'

" fancy start screen
Plug 'mhinz/vim-startify'
" w/ nerdfont icons
Plug 'csch0/vim-startify-renderer-nerdfont'

" easily change surrounding elements
Plug 'tpope/vim-surround'

" use treesitter inside nvim
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" w/ refactoring capabilites
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" adds indentation guides to all lines
Plug 'lukas-reineke/indent-blankline.nvim'

" add editorconfig support
Plug 'editorconfig/editorconfig-vim'

" highly extensible fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
" w/ media preview
Plug 'nvim-telescope/telescope-media-files.nvim'
" w/ dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" a more adventurous wildmenu
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }

" markdown preview in browser tab and full sync
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" when you forget which key to press
Plug 'folke/which-key.nvim'

" general whitespace highlighter + remover
Plug 'ntpeters/vim-better-whitespace'

" access an external colorpicker directly from neovim
Plug 'KabbAmine/vCoolor.vim'

" repo for some code snippets
Plug 'honza/vim-snippets'

" easier buffer resizing
Plug 'ahonn/resize.vim'

" fast colorizer
Plug 'norcalli/nvim-colorizer.lua'

" for android dev
Plug 'hsanson/vim-android'

call plug#end()
