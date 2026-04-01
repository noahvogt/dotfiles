local keymap = vim.keymap.set
local opts = { silent = true }

-- Move text buffer in visual mode
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("v", "J", ":m '>+1<CR>gv=gv")

-- Write and quit easier
keymap("n", "<Leader>w", ":w<CR>")
keymap("n", "<Leader>z", ":wq<CR>")
keymap("n", "<Leader>q", ":qa<CR>")
keymap("n", "<Leader>e", ":q<CR>")

-- Windows commands
keymap("n", "<leader>pv", ":wincmd v | :Ex | :vertical resize 30<CR>")
keymap("n", "<leader>ps", ":Rg<CR>")
keymap("n", "<leader>rh", ":vertical resize +5<CR>")
keymap("n", "<leader>rl", ":vertical resize -5<CR>")

-- General compile buttons
keymap("", "<F3>", ":w<CR>:!compile \"%\" && pkill -HUP mupdf<CR>")
keymap("", "<F2>", ":w<CR>:!latexmk -pdf \"%\" && pkill -HUP mupdf<CR>")
keymap("", "<F4>", ":noh<CR>")
keymap("", "<F5>", ":set spell!<CR>")
keymap("", "<F6>", ":w<CR>:!glosscompile \"%\" && pkill -HUP mupdf<CR>")

-- Jumper
keymap("v", "<Space><Space>", "<Esc>/<++><Enter>\"_c4l")
keymap("", "<Space><Space>", "<Esc>/<++><Enter>\"_c4l")

-- Copy from / to clipboard
keymap("v", "<leader>y", "\"+y")
keymap("v", "<leader>Y", "\"+Y")
keymap("n", "<leader>p", "\"+p")
keymap("n", "<leader>P", "\"+P")

-- Diagnostic navigation
keymap("n", "[g", vim.diagnostic.goto_prev, opts)
keymap("n", "]g", vim.diagnostic.goto_next, opts)
keymap("n", "gl", vim.diagnostic.open_float, opts)

-- LSP gotos
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gy", vim.lsp.buf.type_definition, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

-- LSP code actions
keymap({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)

-- LSP CodeLens
keymap("n", "<leader>cl", vim.lsp.codelens.run, opts)

-- Switch to last opened file
keymap("n", "<leader>b", "<c-^><cr>")

-- NvimTree Toggle
keymap("n", "<Leader>f", ":NvimTreeToggle<CR>", opts)

-- Tab navigation
for i = 1, 9 do
  keymap("", "<leader>" .. i, i .. "gt")
end
keymap("", "<leader>0", ":tablast<cr>")

-- Auto center searches
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Tagbar
keymap("n", "<leader>g", ":TagbarToggle<CR>")

-- Source vim config
keymap("n", "<Leader>sv", ":source $XDG_CONFIG_HOME/nvim/init.lua<CR>")

-- Telescope
keymap("n", "<leader>l", ":Telescope live_grep<CR>")
keymap("n", "<leader>t", ":Telescope git_files<CR>")
keymap("n", "<leader>z", ":Telescope find_files<CR>")
keymap("n", "<C-s>", ":Telescope grep_string<CR>")

-- Markdown preview
keymap("n", "<leader>mg", "<Plug>MarkdownPreview")
keymap("n", "<leader>ms", "<Plug>MarkdownPreviewStop")
keymap("n", "<leader>mt", "<Plug>MarkdownPreviewToggle")

-- WhiteSpace
keymap("n", "<leader>cw", ":StripWhitespace<CR>")
keymap("n", "]w", ":NextTrailingWhitespace<CR>")
keymap("n", "[w", ":PrevTrailingWhitespace<CR>")

-- Smart window movement
local utils = require("utils")
keymap("n", "<C-h>", function() utils.win_move('h') end, opts)
keymap("n", "<C-j>", function() utils.win_move('j') end, opts)
keymap("n", "<C-k>", function() utils.win_move('k') end, opts)
keymap("n", "<C-l>", function() utils.win_move('l') end, opts)
