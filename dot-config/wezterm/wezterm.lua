local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'JetBrainsMono Nerd Font'

config.enable_tab_bar = false

config.colors = {
  foreground = '#e4e1e6',
  background = '#1b1b1f',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#add8e6',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = 'black',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#add8e6',

  -- the foreground color of selected text
  selection_fg = 'black',
  -- the background color of selected text
  selection_bg = '#fffacd',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#444444',

  ansi = {
    '#3b4252',
    '#bf616a',
    '#a3be8c',
    '#ebcb8b',
    '#81a1c1',
    '#b48ead',
    '#88c0d0',
    '#e5e9f0',
  },
  brights = {
    '#4c566a',
    '#bf616a',
    '#a3be8c',
    '#ebcb8b',
    '#81a1c1',
    '#b48ead',
    '#8fbcbb',
    '#eceff4',
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  indexed = { [136] = '#af8700' },
}
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
