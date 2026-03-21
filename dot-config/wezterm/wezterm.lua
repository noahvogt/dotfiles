local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.enable_tab_bar = false

-- Function to determine if the system is in dark mode
local function is_dark()
  if wezterm.gui then
    return wezterm.gui.get_appearance():find 'Dark'
  end
  return true
end

-- Define color schemes
local dark_colors = {
  foreground = '#e4e1e6',
  background = '#1b1b1f',
  cursor_bg = '#add8e6',
  cursor_fg = 'black',
  cursor_border = '#add8e6',
  selection_fg = 'black',
  selection_bg = '#fffacd',
  scrollbar_thumb = '#222222',
  split = '#444444',
  ansi = {
    '#3b4252', '#bf616a', '#a3be8c', '#ebcb8b',
    '#81a1c1', '#b48ead', '#88c0d0', '#e5e9f0',
  },
  brights = {
    '#4c566a', '#bf616a', '#a3be8c', '#ebcb8b',
    '#81a1c1', '#b48ead', '#8fbcbb', '#eceff4',
  },
  indexed = { [136] = '#af8700' },
}

local light_colors = {
  foreground = '#2e3440',
  background = '#eceff4',
  cursor_bg = '#5e81ac',
  cursor_fg = 'white',
  cursor_border = '#5e81ac',
  selection_fg = '#eceff4',
  selection_bg = '#4c566a',
  scrollbar_thumb = '#d8dee9',
  split = '#d8dee9',
  ansi = {
    '#3b4252', '#bf616a', '#a3be8c', '#ebcb8b',
    '#81a1c1', '#b48ead', '#88c0d0', '#e5e9f0',
  },
  brights = {
    '#4c566a', '#bf616a', '#a3be8c', '#ebcb8b',
    '#81a1c1', '#b48ead', '#8fbcbb', '#eceff4',
  },
  indexed = { [136] = '#af8700' },
}

-- Apply colors based on appearance
if is_dark() then
  config.colors = dark_colors
else
  config.colors = light_colors
end

config.cursor_blink_rate = 0
config.disable_default_key_bindings = true
config.keys = {
  {
    key = 'c',
    mods = 'ALT',
    action = wezterm.action.CopyTo('Clipboard'),
  },
  {
    key = 'v',
    mods ='ALT',
    action = wezterm.action.PasteFrom('Clipboard')
  },
  {
    key = 'k',
    mods = 'ALT|SHIFT',
    action = wezterm.action.IncreaseFontSize
  },
  {
    key = 'j',
    mods = 'ALT|SHIFT',
    action = wezterm.action.DecreaseFontSize
  },
  {
    key = '0',
    mods = 'ALT',
    action = wezterm.action.ResetFontSize
  },
  {
    key = 'u',
    mods = 'ALT',
    action = wezterm.action.ScrollByPage(-1)
  },
  {
    key = 'd',
    mods = 'ALT',
    action = wezterm.action.ScrollByPage(1)
  },
  {
    key = 'k',
    mods = 'ALT',
    action = wezterm.action.ScrollByLine(-1)
  },
  {
    key = 'j',
    mods = 'ALT',
    action = wezterm.action.ScrollByLine(1)
  },
  {
    key = 'f',
    mods = 'ALT',
    action = wezterm.action.Search { CaseInSensitiveString = '' },
  },
}

return config
