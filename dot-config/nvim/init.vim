" noah's $VIMINIT
" 

" get basic (set)tings
source $XDG_CONFIG_HOME/nvim/general/basic.vim
" get plugins
source $XDG_CONFIG_HOME/nvim/vim-plug/plugins.vim
" get plugin configs
source $XDG_CONFIG_HOME/nvim/plug-conf/fern.vim
" get keybinds
source $XDG_CONFIG_HOME/nvim/keys/bindings.vim
" get autocommands
source $XDG_CONFIG_HOME/nvim/general/auto.vim

colorscheme onedark
let g:airline_theme='onedark'
set background=dark

" make background transparent
"hi Normal ctermbg=none
"hi NonText ctermbg=none

" disalbe automatic identation (should be at the end???)
filetype indent off
