require'nvim-treesitter.configs'.setup {
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

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    enable = true,

    disable = {"rust"},

    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    additional_vim_regex_highlighting = false,
    },

    refactor = {
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = false,
        },

        highlight_current_scope = { 
            -- very annonying per default, maybe has its use when its unclear
            enable = false
        },

        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },

        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<A-n>",
                goto_previous_usage = "<A-p>",
            },
        },
    },
}
