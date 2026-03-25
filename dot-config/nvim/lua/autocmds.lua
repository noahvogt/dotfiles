local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Fix latex commenting
augroup("fixLatexComments", { clear = true })
autocmd("FileType", {
  group = "fixLatexComments",
  pattern = { "plaintex", "tex", "latex" },
  command = "syntax spell toplevel",
})

-- Wrap Java at 100 lines
augroup("wrapJavaAt100LinesException", { clear = true })
autocmd("FileType", {
  group = "wrapJavaAt100LinesException",
  pattern = "java",
  callback = function()
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Markdown Math and Liquid highlighting
local function math_and_liquid()
  vim.fn.matchadd("math", [[\$\$]])
  vim.fn.matchadd("math_block", [[\$[^$].\{-}\$]])
  vim.fn.matchadd("liquid", [[{%.*%}]])
  vim.fn.matchadd("highlight_block", [[{% highlight .*%}]])
  vim.fn.matchadd("highlight_block", [[```]])

  vim.cmd([[
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
  ]])
end

augroup("callMathFunction", { clear = true })
autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
  group = "callMathFunction",
  pattern = { "*.md", "*.markdown" },
  callback = math_and_liquid,
})

-- Disable automatic comment
augroup("disableAutoComment", { clear = true })
autocmd("FileType", {
  group = "disableAutoComment",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Clear TeX build after exiting
augroup("texclear", { clear = true })
autocmd("VimLeavePre", {
  group = "texclear",
  pattern = { "*.tex", "*.md" },
  callback = function()
    vim.fn.system('texclear "' .. vim.fn.expand("%") .. '"')
  end,
})

-- TI-Basic filetype
augroup("tibasic", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = "tibasic",
  pattern = { "*.tibasic", "*.tib" },
  callback = function()
    vim.bo.filetype = "python"
  end,
})

-- Emmet Enabler
augroup("EmmetEnabler", { clear = true })
autocmd("FileType", {
  group = "EmmetEnabler",
  pattern = { "html", "css" },
  command = "EmmetInstall",
})

-- Relative line numbers
augroup("numbertoggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = "numbertoggle",
  pattern = "*",
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = true
    end
  end,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = "numbertoggle",
  pattern = "*",
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
})


-- LSP Highlight
augroup("LspHighlight", { clear = true })
autocmd("CursorHold", {
  group = "LspHighlight",
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
})
autocmd("CursorMoved", {
  group = "LspHighlight",
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- TeX Macros
augroup("texMacros", { clear = true })
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

autocmd("FileType", {
  group = "texMacros",
  pattern = "tex",
  callback = function()
    map("i", ";beg", "\\begin{<Esc>yypkI\\begin{<Esc>A}<Esc>o<Esc>0i<Esc>jI\\end{<Esc>A}<CR><Esc>0i<CR><Esc>0i<++><Esc>3ki")
    map("i", ";ig", "\\includegraphics[]{<++>}<Esc>6hi")
    map("i", ";tw", "width=\\textwidth<Esc>9hi")
    map("i", ";th", "height=\\textheight<Esc>10hi")
    map("i", ";ni", "\\setlength{\\parindent}{0em}<Esc>")
    map("i", ";ger", "\\usepackage[ngerman]{babel}<Esc>")
    map("i", ";bf", "\\textbf{}<++><Esc>T{i")
    map("i", ";it", "\\textit{}<++><Esc>T{i")
    map("i", ";tt", "\\texttt{}<++><Esc>T{i")
    map("i", ";fr", "\\begin{frame}<CR>\\frametitle{}<CR><++><CR>\\end{frame}<Esc>kklli")
    map("i", ";sw", "\\switchcolumn[]<++><Esc>4hi")
    map("i", ";up", "\\usepackage{}<Esc>i")
    map("i", ";hy", "\\hyphenation{}<Esc>i")
    map("i", ";s1", "\\section{}<Esc>i")
    map("i", ";s2", "\\subsection{}<Esc>i")
    map("i", ";s3", "\\subsubsection{}<Esc>i")
    map("i", ";ap", "\\bibliographystyle{apacite}<CR>\\bibliography{}<Esc>i")
  end,
})

-- Sync theme on focus
augroup("theme_sync", { clear = true })
autocmd("FocusGained", {
  group = "theme_sync",
  callback = function()
    require('theme').sync_theme()
  end,
})

