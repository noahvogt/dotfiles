lua << EOF
require('onedark').setup {
    style = 'darker',
    transparent = false,
    term_colors = true,
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
}
require('onedark').load()

-- Force colors for diagnostics and spell check underlines
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff0000' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn',  { undercurl = true, sp = '#ff8800' })
vim.api.nvim_set_hl(0, 'SpellBad',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellCap',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellRare',  { undercurl = true, sp = '#ffff00' })

-- GitSigns with background colors for better visibility
-- (Colors adjusted for onedark darker palette)
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#98c379', bg = '#2e3f34' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#e5c07b', bg = '#3e3d32' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#e06c75', bg = '#3f2e2e' })

-- Also color the line numbers for git changes (numhl)
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { fg = '#98c379', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { fg = '#e5c07b', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { fg = '#e06c75', bold = true })
EOF

let g:airline_theme='onedark'
set background=dark
