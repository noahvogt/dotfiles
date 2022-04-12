" noah's $VIMINIT
" 

" get basic (set)tings
source $XDG_CONFIG_HOME/nvim/general/basic.vim
" get plugins
source $XDG_CONFIG_HOME/nvim/vim-plug/plugins.vim
" get plugin configs
source $XDG_CONFIG_HOME/nvim/plug-conf/fern.vim
" get theme
source $XDG_CONFIG_HOME/nvim/theme/theme.vim
" get keybinds
source $XDG_CONFIG_HOME/nvim/keys/bindings.vim
source $XDG_CONFIG_HOME/nvim/keys/tex-macros.vim
" get autocommands
source $XDG_CONFIG_HOME/nvim/general/auto.vim

" disalbe automatic identation (should be at the end???)
filetype indent off
