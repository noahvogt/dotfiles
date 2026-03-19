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
Plug 'navarasu/onedark.nvim'
Plug 'itchyny/landscape.vim'

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

" nice statusline for vim
Plug 'vim-airline/vim-airline'
" plus themes
Plug 'vim-airline/vim-airline-themes'

" some git integration
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" native LSP support
Plug 'neovim/nvim-lspconfig'
Plug 'ThePrimeagen/refactoring.nvim'
" modern completion engine
Plug 'Saghen/blink.cmp'
" snippet support
Plug 'L3MON4D3/LuaSnip'

" formatting and linting
Plug 'stevearc/conform.nvim'
Plug 'mfussenegger/nvim-lint'

" auto disable search highlighting
Plug 'romainl/vim-cool'

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
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }

" adds indentation guides to all lines
Plug 'lukas-reineke/indent-blankline.nvim'

" highly extensible fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
" w/ media preview
Plug 'nvim-telescope/telescope-media-files.nvim'
" w/ dependencies
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

" easier buffer resizing
Plug 'ahonn/resize.vim'

" fast colorizer
Plug 'NvChad/nvim-colorizer.lua'

" for android dev
Plug 'hsanson/vim-android'

call plug#end()
