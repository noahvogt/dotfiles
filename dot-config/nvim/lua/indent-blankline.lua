-- uncomment below to show whitespace characters

--vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    -- highlight the indentation guide of the current context
    show_current_context = true,
    -- underline the starting line of the block
    show_current_context_start = false,
}
