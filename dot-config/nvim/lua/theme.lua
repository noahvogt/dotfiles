require('onedark').setup {
    style = 'cool', -- 'cool' or 'vibrant' are usually better for TS
    transparent = false,
    term_colors = true,
    -- Remove overrides to use theme defaults
    code_style = {
        comments = 'italic',
    },
}
require('onedark').load()

-- Force colors for diagnostics and spell check underlines ONLY
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff0000' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn',  { undercurl = true, sp = '#ff8800' })
vim.api.nvim_set_hl(0, 'SpellBad',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellCap',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellRare',  { undercurl = true, sp = '#ffff00' })

-- GitSigns
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#98c379', bg = '#2e3f34' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#e5c07b', bg = '#3e3d32' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#e06c75', bg = '#3f2e2e' })

vim.g.airline_theme = 'onedark'
vim.opt.background = 'dark'
