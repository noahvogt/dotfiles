local refactoring = require('refactoring')
refactoring.setup({})

-- Use which-key to register the mapping explicitly
local wk = require("which-key")

-- We use Ex commands (e.g., ":Refactor extract ") because they provide a live preview
-- and automatically handle visual mode bounds without needing expr=true hacks.
wk.add({
  { "<leader>r", group = "refactor" },
  {
    mode = { "x", "n" },
    { "<leader>rm", function() require('refactoring').select_refactor() end, desc = "Refactor Menu" },
    { "<leader>re", ":Refactor extract ", desc = "Extract Function" },
    { "<leader>rf", ":Refactor extract_to_file ", desc = "Extract Function To File" },
    { "<leader>rv", ":Refactor extract_var ", desc = "Extract Variable" },
    { "<leader>ri", ":Refactor inline_var", desc = "Inline Variable" },
    { "<leader>rI", ":Refactor inline_func", desc = "Inline Function" },
    { "<leader>rb", ":Refactor extract_block", desc = "Extract Block" },
    { "<leader>rbf", ":Refactor extract_block_to_file", desc = "Extract Block To File" },
  },
})
