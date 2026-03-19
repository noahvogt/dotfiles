local wk = require("which-key")

wk.setup({
  preset = "classic",
  win = {
    no_overlap = true,
    padding = { 1, 2 }, -- top, right, bottom, left
    title = true,
    title_pos = "center",
    zindex = 1000,
  },
  layout = {
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  show_help = true,
})
