-- 1. Use the configs module if it exists, otherwise use the new core
local ok, configs = pcall(require, "nvim-treesitter.configs")

if ok then
    -- If you are on a version that still has configs
    configs.setup({
        ensure_installed = {
        "c",
        "lua",
        "java",
        "python",
        "bash",
        "html",
        "css",
        "javascript",
        "bibtex",
        "cmake",
        "cpp",
        "latex",
        "perl",
        "regex",
        "toml",
        "yaml"
        },
        highlight = { enable = true },
    })
else
    -- THE NEW WAY: If configs is missing, use the internal install module
    local install = require('nvim-treesitter.install')
    
    -- This replaces ensure_installed
    install.prefer_git = true
    -- To install specific parsers via code:
    -- require('nvim-treesitter.command').smart_install({ "lua", "python" })
    
    -- Enable highlighting globally the new Neovim way
    vim.api.nvim_create_autocmd('FileType', {
        callback = function()
            local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
            if lang then
                pcall(vim.treesitter.start)
            end
        end,
    })
end
-- local ts = require('nvim-treesitter')

-- -- 1. Manually install parsers (replaces ensure_installed)
-- ts.install({
--         "c",
--         "lua",
--         "java",
--         "python",
--         "bash",
--         "html",
--         "css",
--         "javascript",
--         "bibtex",
--         "cmake",
--         "cpp",
--         "latex",
--         "perl",
--         "regex",
--         "toml",
--         "yaml"
-- })

-- -- 2. Enable Highlighting (Now done via Neovim API, not Treesitter setup)
-- vim.api.nvim_create_autocmd('FileType', {
--   callback = function()
--     pcall(vim.treesitter.start)
--   end,
-- })
-- require'nvim-treesitter.configs'.setup {
--     ensure_installed = {
--         "c",
--         "lua",
--         "java",
--         "python",
--         "bash",
--         "html",
--         "css",
--         "javascript",
--         "bibtex",
--         "cmake",
--         "cpp",
--         "latex",
--         "perl",
--         "regex",
--         "toml",
--         "yaml"
--     },

--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,

--   highlight = {
--     enable = true,

--     disable = {"rust"},

--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     additional_vim_regex_highlighting = false,
--     },

--     refactor = {
--         highlight_definitions = {
--             enable = true,
--             -- Set to false if you have an `updatetime` of ~100.
--             clear_on_cursor_move = false,
--         },

--         highlight_current_scope = { 
--             -- very annonying per default, maybe has its use when its unclear
--             enable = false
--         },

--         smart_rename = {
--             enable = true,
--             keymaps = {
--                 smart_rename = "grr",
--             },
--         },

--         navigation = {
--             enable = true,
--             keymaps = {
--                 goto_definition = "gnd",
--                 list_definitions = "gnD",
--                 list_definitions_toc = "gO",
--                 goto_next_usage = "<A-n>",
--                 goto_previous_usage = "<A-p>",
--             },
--         },
--     },
-- }
