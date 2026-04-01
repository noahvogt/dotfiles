local lualine = require('lualine')

-- Custom component for Wordcount (only text and markdown)
local function wordcount()
  if vim.bo.filetype == "markdown" or vim.bo.filetype == "text" then
    return tostring(vim.fn.wordcount().words) .. " words"
  else
    return ""
  end
end

-- Custom component for Gradle build status (vim-android)
local function gradle_status()
  if vim.fn.exists('*lightline#gradle#running') == 1 then
    local status = vim.fn['lightline#gradle#running']()
    if status and status ~= '' then
      return status
    end
  end
  return ""
end

lualine.setup({
  options = {
    theme = 'auto',
    globalstatus = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {gradle_status, 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress', wordcount},
    lualine_z = {'location'}
  },
})
