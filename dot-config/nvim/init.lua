-- Noah's Neovim Configuration (init.lua)

-- 1. Essential Neovim 0.11+ fixes and environment setup
-- Disable built-in LSP mappings
local builtins = { 'grn', 'gra', 'grr', 'gri', 'grt' }
for _, k in ipairs(builtins) do
  pcall(vim.keymap.del, 'n', k, { builtin = true })
end

-- Disable built-in commentary
vim.g.loaded_commentary = 1

-- 2. Load basic settings
require('options')

-- 3. Load plugins (lazy.nvim)
require('plugins')

-- 4. Load Theme (Important for Treesitter highlight groups)
require('theme')

-- 5. Load Plugin configurations (some are still in vimscript)
local plug_confs = {
  'emmet', 'ctrlp', 'sneak', 'airline',
  'startify', 'wilder', 'vcoolor', 'better-whitespace', 'vimspector'
}
for _, conf in ipairs(plug_confs) do
  vim.cmd('source $XDG_CONFIG_HOME/nvim/plug-conf/' .. conf .. '.vim')
end

-- 6. Load Lua-specific configurations
require('treesitter')
require('lsp')
require('nvim-tree-conf')
require('telescope-conf')
require('refactoring-conf')
require('gitsigns-conf')
require('indent-blankline')
require('whichkey')
require('colorizer').setup()

-- 7. Load keybinds and autocommands
require('keymaps')
require('autocmds')

-- Enable intelligent indentation
vim.cmd('filetype plugin indent on')
