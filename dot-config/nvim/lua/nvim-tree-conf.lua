-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- nvim-tree setup
require("nvim-tree").setup({
  -- We don't disable netrw globally here so that spell-file downloads still work.
  -- nvim-tree will still hijack netrw when you open a directory.
  hijack_netrw = true,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 35,
    side = "left",
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    -- 'p' for preview (opens file but stays in tree)
    vim.keymap.set('n', 'p', api.node.open.preview, opts('Preview'))
  end,
  renderer = {
    group_empty = true,
    icons = {
        show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
        },
    },
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$" },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
})
