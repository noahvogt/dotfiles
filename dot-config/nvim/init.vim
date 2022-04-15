" noah's $VIMINIT
" 

" get basic (set)tings
source $XDG_CONFIG_HOME/nvim/general/basic.vim
" get plugins
source $XDG_CONFIG_HOME/nvim/vim-plug/plugins.vim
" get plugin configs
source $XDG_CONFIG_HOME/nvim/plug-conf/fern.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/emmet.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/ctrlp.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/sneak.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/airline.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/startify.vim
lua require('treesitter')
" get theme
source $XDG_CONFIG_HOME/nvim/theme/theme.vim
" get keybinds
source $XDG_CONFIG_HOME/nvim/keys/bindings.vim
source $XDG_CONFIG_HOME/nvim/keys/tex-macros.vim
" get autocommands
source $XDG_CONFIG_HOME/nvim/general/auto.vim

" disalbe automatic identation (should be at the end???)
filetype indent off
