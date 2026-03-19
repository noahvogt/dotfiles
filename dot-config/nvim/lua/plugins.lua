local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorschemes
  { 'navarasu/onedark.nvim', priority = 1000 },
  'itchyny/landscape.vim',

  -- Fuzzy find files
  'ctrlpvim/ctrlp.vim',

  -- Fern
  { 
    'lambdalisue/fern.vim', 
    branch = 'main',
    priority = 100, -- Load it early
  },
  'lambdalisue/nerdfont.vim',
  { 
    'lambdalisue/fern-renderer-nerdfont.vim',
    dependencies = { 'lambdalisue/fern.vim', 'lambdalisue/nerdfont.vim' }
  },
  { 'lambdalisue/fern-git-status.vim', dependencies = { 'lambdalisue/fern.vim' } },
  { 'lambdalisue/glyph-palette.vim', dependencies = { 'lambdalisue/fern.vim' } },
  { 'yuki-yano/fern-preview.vim', dependencies = { 'lambdalisue/fern.vim' } },

  -- Airline
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',

  -- Git
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',

  -- LSP & Completion
  'neovim/nvim-lspconfig',
  'ThePrimeagen/refactoring.nvim',
  {
    'Saghen/blink.cmp',
    build = 'cargo build --release',
  },
  'L3MON4D3/LuaSnip',

  -- Formatting & Linting
  'stevearc/conform.nvim',
  'mfussenegger/nvim-lint',

  -- Search & Edit utilities
  'romainl/vim-cool',
  'tpope/vim-commentary',
  'preservim/tagbar',
  'mattn/emmet-vim',
  'justinmk/vim-sneak',
  'mhinz/vim-startify',
  'csch0/vim-startify-renderer-nerdfont',
  'tpope/vim-surround',

  -- Treesitter
  { 
    'nvim-treesitter/nvim-treesitter', 
    branch = 'main', 
    build = ':TSUpdate' 
  },

  -- Indentation
  'lukas-reineke/indent-blankline.nvim',

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-media-files.nvim' }
  },

  -- Wilder
  { 
    'gelguy/wilder.nvim', 
    build = ':UpdateRemotePlugins' 
  },

  -- Markdown Preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Which-Key
  'folke/which-key.nvim',

  -- Whitespace
  'ntpeters/vim-better-whitespace',

  -- Colorpicker
  'KabbAmine/vCoolor.vim',

  -- Buffer resizing
  'ahonn/resize.vim',

  -- Colorizer
  'NvChad/nvim-colorizer.lua',

  -- Android
  'hsanson/vim-android'
})
