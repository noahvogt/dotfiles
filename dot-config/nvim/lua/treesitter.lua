local status, configs = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

require('nvim-treesitter.install').prefer_git = true

configs.setup {
    ensure_installed = {
        "c", "lua", "java", "python", "bash", "html", "css", "javascript",
        "bibtex", "cmake", "cpp", "latex", "perl", "regex", "toml", "yaml"
    },

    highlight = {
        enable = true,
        -- Merges Treesitter with Regex highlighting for maximum color richness
        additional_vim_regex_highlighting = { "python" },
    },

    indent = {
        enable = true
    },
}

-- Force Treesitter to start for major filetypes to bypass any legacy syntax overrides
vim.api.nvim_create_autocmd({ "FileType" }, {
    callback = function()
        local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
        if lang then
            pcall(vim.treesitter.start)
        end
    end,
})
