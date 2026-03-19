local blink = require('blink.cmp')
local lspconfig = require('lspconfig')

-- 1. Setup blink.cmp
blink.setup({
  keymap = { 
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
  snippets = { preset = 'luasnip' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },
  sources = {
    default = { 'lsp', 'path', 'buffer', 'snippets' },
  },
  signature = { enabled = true }
})

-- Load custom snippets from ~/.config/nvim/snips
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snips" } })
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snips" } })

-- 2. Define on_attach
local on_attach = function(client, bufnr)
  -- Keymaps are handled globally in bindings.vim
end

-- 3. Configure Servers using Neovim 0.11 API where possible
local capabilities = blink.get_lsp_capabilities()

-- Basic servers
local servers = { 'pyright', 'bashls', 'html', 'cssls', 'jdtls' }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
    on_attach = on_attach,
  })
  vim.lsp.enable(server)
end

-- Custom Veridian setup (Verilog)
vim.lsp.config('veridian', {
  cmd = { 'veridian' },
  filetypes = { 'systemverilog', 'verilog' },
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('veridian')

-- Custom CCLS setup (C/C++)
vim.lsp.config('ccls', {
  init_options = {
    cache = { directory = "/tmp/ccls-cache" },
    client = { snippetSupport = true }
  },
  root_patterns = { ".ccls-root", "compile_commands.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('ccls')

-- 4. Formatting (Replaces coc's formatOnSave)
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    python = { "black" },
    java = { "google-java-format" },
    sh = { "shfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- 5. Linting (Replaces coc's pylint and shellcheck)
local lint = require("lint")
lint.linters_by_ft = {
  python = { "pylint" },
  sh = { "shellcheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})

-- 6. Diagnostics config
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = 'rounded' },
})

-- 7. Diagnostic & Spell Highlighting
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff0000' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn',  { undercurl = true, sp = '#ff8800' })
vim.api.nvim_set_hl(0, 'SpellBad',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellCap',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellRare',  { undercurl = true, sp = '#ffff00' })
