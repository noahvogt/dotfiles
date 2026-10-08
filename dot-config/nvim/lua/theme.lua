local M = {}

-- Highlight overrides on top of onedark, reapplied whenever the colorscheme
-- is (re)loaded
local function overrides()
    if vim.o.background == "light" then
        vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#2c7a36', bg = '#d9f2da' })
        vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#a68a0d', bg = '#fbf0c9' })
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#a62621', bg = '#f9dada' })
    else
        vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#98c379', bg = '#2e3f34' })
        vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#e5c07b', bg = '#3e3d32' })
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#e06c75', bg = '#3f2e2e' })
    end

    -- Force colors for diagnostics and spell check underlines
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff0000' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn',  { undercurl = true, sp = '#ff8800' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint',  { undercurl = true, sp = '#ffff00' })
    vim.api.nvim_set_hl(0, 'SpellBad',   { undercurl = true, sp = '#ffff00' })
    vim.api.nvim_set_hl(0, 'SpellCap',   { undercurl = true, sp = '#ffff00' })
    vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#ffff00' })
    vim.api.nvim_set_hl(0, 'SpellRare',  { undercurl = true, sp = '#ffff00' })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("theme_overrides", { clear = true }),
    callback = overrides,
})

function M.sync_theme()
    -- Use vim.fn.system for more reliable command execution in Neovim
    local result = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")

    -- Check for 'light' anywhere in the output
    local background = result:match("light") and "light" or "dark"

    -- Nothing to do if the theme is already loaded (e.g. on FocusGained)
    if vim.g.colors_name == "onedark" and vim.o.background == background then
        return
    end

    vim.o.background = background
    require('onedark').setup {
        style = background == "light" and "light" or "cool",
        transparent = false,
        term_colors = true,
        code_style = { comments = 'italic' },
    }
    require('onedark').load()

    -- Refresh lualine theme
    local has_lualine, lualine = pcall(require, 'lualine')
    if has_lualine then
        lualine.setup({ options = { theme = 'auto' } })
    end

    -- Force a full redraw to fix background issues in some terminals
    vim.cmd('redraw!')
end

-- Initial sync on load
M.sync_theme()

-- Set up signal handler for SIGUSR1 to trigger a theme sync
local signal = vim.uv.new_signal()
if signal then
    signal:start("sigusr1", function()
        vim.schedule(function()
            M.sync_theme()
        end)
    end)
end

return M
