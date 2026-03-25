local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

require('nvim-dap-virtual-text').setup()

-- Automatically open/close dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Python configuration
require('dap-python').setup('python3') -- assumes python3 is in your path and has debugpy installed

-- Keymaps
local keymap = vim.keymap.set
local opts = { silent = true }

keymap('n', '<leader>dc', function() require('dap').continue() end, opts)
keymap('n', '<leader>dn', function() require('dap').step_over() end, opts)
keymap('n', '<leader>di', function() require('dap').step_into() end, opts)
keymap('n', '<leader>do', function() require('dap').step_out() end, opts)
keymap('n', '<leader>db', function() require('dap').toggle_breakpoint() end, opts)
keymap('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, opts)
keymap('n', '<leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, opts)
keymap('n', '<leader>dr', function() require('dap').repl.open() end, opts)
keymap('n', '<leader>dl', function() require('dap').run_last() end, opts)

-- Widgets
keymap({'n', 'v'}, '<leader>dh', function()
  require('dap.ui.widgets').hover()
end)
keymap({'n', 'v'}, '<leader>dp', function()
  require('dap.ui.widgets').preview()
end)
keymap('n', '<leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
keymap('n', '<leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- DAP UI keymaps
keymap('n', '<leader>du', function() dapui.toggle() end, opts)
