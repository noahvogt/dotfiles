local refactoring = require('refactoring')
refactoring.setup({})

-- Use which-key to register the mapping explicitly
local wk = require("which-key")
wk.add({
  { "<leader>r", group = "refactor" },
  {
    mode = { "x" },
    { "<leader>re", function() require('refactoring').select_refactor() end, desc = "Refactor Menu" },
    { "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, desc = "Extract Variable" },
    { "<leader>rf", function() require('refactoring').refactor('Extract Function') end, desc = "Extract Function" },
    { "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, desc = "Inline Variable" },
  },
})
