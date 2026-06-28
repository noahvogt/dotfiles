local blink = require('blink.cmp')
local lspconfig = require('lspconfig')

-- 0. Setup Mason
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "php-cs-fixer",
  },
})

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
  fuzzy = {
    implementation = "prefer_rust",
  },
  signature = { enabled = true }
})

-- Load custom snippets from ~/.config/nvim/snips
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snips" } })
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snips" } })

-- 2. Define on_attach
local on_attach = function(client, bufnr)
  -- Keymaps are handled globally in keymaps.lua (formerly bindings.vim)

  -- Enable CodeLens if supported
  if client.supports_method("textDocument/codeLens") then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh({ bufnr = bufnr })
      end,
    })
  end

  -- Enable Document Highlight if supported
  if client.supports_method("textDocument/documentHighlight") then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end

  -- Format on Type (Commented out - prefer Format on Save in conform.nvim)
  -- if client.supports_method("textDocument/onTypeFormatting") then
  --   vim.api.nvim_create_autocmd("InsertLeave", {
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format({ bufnr = bufnr, async = true })
  --     end,
  --   })
  -- end
end

-- 3. Configure Servers using Neovim 0.11 API where possible
local capabilities = blink.get_lsp_capabilities()

-- Basic servers
local servers = { 'pyright', 'ruff', 'bashls', 'html', 'cssls', 'jdtls', 'rust_analyzer', 'clangd' }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
    on_attach = on_attach,
  })
  vim.lsp.enable(server)
end

-- cspell integration using none-ls and cspell.nvim
local null_ls = require("null-ls")
local cspell = require("cspell")

local filetypes = {
  "python", "sh", "rust", "kotlin", "java", "c", "cpp", "cmake",
  "markdown", "text", "gitcommit", "lua", "json", "yaml"
}

local cspell_config = {
  config = {
    on_add_to_json = function(payload)
      -- Format with jq and sort the words array alphabetically
      os.execute(
        string.format(
          "jq '.words |= sort' %s > %s.tmp && mv %s.tmp %s",
          payload.cspell_config_path,
          payload.cspell_config_path,
          payload.cspell_config_path,
          payload.cspell_config_path
        )
      )
    end,
  },
}

null_ls.setup({
  sources = {
    cspell.diagnostics.with({
      condition = function(utils)
        return utils.root_has_file({ "cspell.json" })
      end,
      config = cspell_config.config,
      filetypes = filetypes,
      env = vim.tbl_extend("force", vim.fn.environ(), { NODE_PATH = vim.fn.expand('~/.local/share/npm/lib/node_modules') }),
      extra_args = function(params)
        local args = {}
        local cspell_json_path = require("cspell.helpers").get_config_path(params, params.cwd)
        if cspell_json_path then
          local ok, content = pcall(vim.fn.readfile, cspell_json_path)
          if ok then
            local ok_json, json = pcall(vim.fn.json_decode, table.concat(content, "\n"))
            if ok_json and json.language then
              table.insert(args, "--locale")
              table.insert(args, json.language)
            end
          end
        end
        return args
      end,
      -- Set diagnostic level to HINT so it matches your previous setup
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.HINT
      end,
    }),
    cspell.code_actions.with({
      condition = function(utils)
        return utils.root_has_file({ "cspell.json" })
      end,
      config = cspell_config.config,
      filetypes = filetypes,
      env = vim.tbl_extend("force", vim.fn.environ(), { NODE_PATH = vim.fn.expand('~/.local/share/npm/lib/node_modules') }),
      extra_args = function(params)
        local args = {}
        local cspell_json_path = require("cspell.helpers").get_config_path(params, params.cwd)
        if cspell_json_path then
          local ok, content = pcall(vim.fn.readfile, cspell_json_path)
          if ok then
            local ok_json, json = pcall(vim.fn.json_decode, table.concat(content, "\n"))
            if ok_json and json.language then
              table.insert(args, "--locale")
              table.insert(args, json.language)
            end
          end
        end
        return args
      end,
    }),
  },
})

-- Custom Veridian setup (Verilog)
vim.lsp.config('veridian', {
  cmd = { 'veridian' },
  filetypes = { 'systemverilog', 'verilog' },
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('veridian')

-- Official JetBrains Kotlin LSP
vim.lsp.config('kotlin_lsp', {
  cmd = { 'kotlin-lsp' },
  filetypes = { 'kotlin' },
  -- Tell the LSP to attach at the root of your Android Gradle project
  root_markers = { 'settings.gradle.kts', 'settings.gradle', 'build.gradle.kts', 'build.gradle' },
  capabilities = capabilities,
  on_attach = on_attach,

  -- Note: We drop the old fwcd/kotlin-language-server 'settings' block.
  -- The JetBrains server is much smarter and infers JVM targets, hints,
  -- and completions directly from IntelliJ's internal engine and your Gradle model.
})
vim.lsp.enable('kotlin_lsp')

-- 4. Formatting
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    kotlin = { "ktlint" },
    python = { "black" },
    php = { "php_cs_fixer" },
    java = { "lsp" },
    sh = { "shfmt" },
    rust = { "rustfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    cmake = { "cmake_format" },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
})

-- 5. Linting
local lint = require("lint")
lint.linters_by_ft = {
  python = { "pylint" },
  php = { "psalm" },
  sh = { "shellcheck" },
  rust = { "clippy" },
}

lint.linters.psalm.ignore_exitcode = true

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
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
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint',  { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellBad',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellCap',   { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#ffff00' })
vim.api.nvim_set_hl(0, 'SpellRare',  { undercurl = true, sp = '#ffff00' })
