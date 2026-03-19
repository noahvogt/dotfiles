-- Minimal setup (optional but recommended)
require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}

-- Ensure that Treesitter starts on every buffer
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  callback = function()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if lang and vim.api.nvim_buf_is_valid(0) then
      vim.schedule(function()
        pcall(vim.treesitter.start, 0, lang)
      end)
    end
  end,
  desc = "Auto-start Treesitter (current main branch)",
})

-- Manual command to force it if it fails
vim.api.nvim_create_user_command("TSToggle", function()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if lang then
        pcall(vim.treesitter.start, 0, lang)
        print("Treesitter forced start for " .. lang)
    else
        print("No Treesitter parser found for this filetype.")
    end
end, {})

-- NOTE: To install parsers you previously had in ensure_installed, run:
-- :TSInstall c lua java python bash html css javascript bibtex cmake cpp latex perl regex toml yaml
