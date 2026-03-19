" noah's $VIMINIT

" 1. Essential Neovim 0.11+ fixes and environment setup
lua << EOF
-- Ensure site directory is in rtp for Treesitter
vim.opt.runtimepath:prepend(vim.fn.expand("~/.local/share/nvim/site"))
vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

-- Disable built-in LSP mappings (using native LSP in lsp.lua)
local builtins = { 'grn', 'gra', 'grr', 'gri', 'grt' }
for _, k in ipairs(builtins) do
  pcall(vim.keymap.del, 'n', k, { builtin = true })
end

-- Disable built-in commentary to favor tpope/vim-commentary
vim.g.loaded_commentary = 1
EOF

" 2. get basic (set)tings
source $XDG_CONFIG_HOME/nvim/general/basic.vim
" get plugins
source $XDG_CONFIG_HOME/nvim/vim-plug/plugins.vim

" 3. get plugin configs
source $XDG_CONFIG_HOME/nvim/plug-conf/fern.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/emmet.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/ctrlp.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/sneak.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/airline.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/startify.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/wilder.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/vcoolor.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/better-whitespace.vim
source $XDG_CONFIG_HOME/nvim/plug-conf/vimspector.vim

" 4. Lua configurations
lua require 'treesitter'
lua require 'lsp'
lua require 'gitsigns-conf'
lua require 'indent-blankline'
lua require 'telescope'
lua require 'whichkey'
lua require 'colorizer'.setup()

" 5. get theme, keybinds, and autocommands
source $XDG_CONFIG_HOME/nvim/theme/theme.vim
source $XDG_CONFIG_HOME/nvim/keys/bindings.vim
source $XDG_CONFIG_HOME/nvim/keys/tex-macros.vim
source $XDG_CONFIG_HOME/nvim/general/auto.vim

" enable intelligent indentation
filetype plugin indent on
