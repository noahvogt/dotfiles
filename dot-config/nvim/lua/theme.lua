local M = {}

function M.sync_theme()
    -- Use vim.fn.system for more reliable command execution in Neovim
    local result = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")

    -- Check for 'light' anywhere in the output
    if result:match("light") then
        vim.o.background = "light"
        require('onedark').setup {
            style = 'light',
            transparent = false,
            term_colors = true,
            code_style = { comments = 'italic' },
        }
        require('onedark').load()

        -- Override GitSigns for light mode
        vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#2c7a36', bg = '#d9f2da' })
        vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#a68a0d', bg = '#fbf0c9' })
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#a62621', bg = '#f9dada' })
    else
        vim.o.background = "dark"
        require('onedark').setup {
            style = 'cool',
            transparent = false,
            term_colors = true,
            code_style = { comments = 'italic' },
        }
        require('onedark').load()

        -- Override GitSigns for dark mode
        vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#98c379', bg = '#2e3f34' })
        vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#e5c07b', bg = '#3e3d32' })
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#e06c75', bg = '#3f2e2e' })
    end

    -- Force colors for diagnostics and spell check underlines
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff0000' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn',  { undercurl = true, sp = '#ff8800' })
    vim.api.nvim_set_hl(0, 'SpellBad',   { undercurl = true, sp = '#ffff00' })
    vim.api.nvim_set_hl(0, 'SpellCap',   { undercurl = true, sp = '#ffff00' })
    vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#ffff00' })
    vim.api.nvim_set_hl(0, 'SpellRare',  { undercurl = true, sp = '#ffff00' })

    -- Force airline to refresh
    vim.g.airline_theme = 'onedark'
    if vim.fn.exists(':AirlineTheme') == 2 then
        vim.cmd('AirlineTheme onedark')
    end

    -- Force a full redraw to fix background issues in some terminals
    vim.cmd('redraw!')
end

-- Initial sync on load
M.sync_theme()

-- Set up signal handler for SIGUSR1 to trigger a theme sync
local signal = vim.loop.new_signal()
if signal then
    signal:start("sigusr1", function()
        vim.schedule(function()
            M.sync_theme()
        end)
    end)
end

return M
