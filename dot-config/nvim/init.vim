" noah's $VIMINIT

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
source $XDG_CONFIG_HOME/nvim/plug-conf/editorconfig.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/wilder.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/vcoolor.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/better-whitespace.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/vimspector.vim
lua require 'treesitter'
lua require 'indent-blankline'
lua require 'telescope'
lua require 'whichkey'
lua require 'colorizer'.setup()
" get theme
source $XDG_CONFIG_HOME/nvim/theme/theme.vim
" get keybinds
source $XDG_CONFIG_HOME/nvim/keys/bindings.vim
source $XDG_CONFIG_HOME/nvim/keys/tex-macros.vim
" get autocommands
source $XDG_CONFIG_HOME/nvim/general/auto.vim

" disalbe automatic identation (should be at the end???)
filetype indent off
