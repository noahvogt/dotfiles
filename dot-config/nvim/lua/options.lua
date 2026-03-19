local opt = vim.opt

-- Set vim paths
opt.undodir = vim.fn.expand("~/.cache/vim/undo")

-- Make :find recursive
opt.path:append("**")
opt.wildignore:append("*/node_modules/*")
opt.wildignore:append("*/__pycache__/*")

-- Display all files for tab completion
opt.wildmenu = true

-- Comfort
opt.number = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Convert tabs to spaces
opt.expandtab = true
opt.smartindent = false
opt.cindent = false
opt.smartcase = true

-- Disable swapfiles
opt.swapfile = false
opt.backup = false

opt.spelllang = "de_ch,en"
opt.showmode = false

-- Set height below statusline
opt.cmdheight = 1

-- Faster update time for diagnostic messages
opt.updatetime = 300

-- Always show signcolumns
opt.signcolumn = "yes"

opt.colorcolumn = "80"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Conceal level
opt.conceallevel = 0

-- Lazy redraw for performance
opt.lazyredraw = true

-- Ignore case when searching
opt.ignorecase = true

-- Scrolling context
opt.scrolloff = 3
opt.sidescrolloff = 5

-- Needed for colorizer plugin
opt.termguicolors = true
