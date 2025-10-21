-- Pull in the wezterm API
local wezterm = require 'wezterm'
local io = require 'io'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


config.color_schemes = {
  ['mybrewer light'] = mybrewerlight,
  ['mybrewer dark'] = mybrewerdark,
}

-- Catppuccin Latte
local lighttheme = 'Catppuccin Latte'

-- Catppuccin Mocha
-- Tokyo Night
local darktheme = 'Ayu Dark (Gogh)'

config.window_background_opacity = 1
config.color_scheme = darktheme

config.hide_tab_bar_if_only_one_tab = true
config.font_size = 18

local basefont = 'JetBrains Mono'
local regularfont = wezterm.font(basefont, { weight = 'Regular'})
local boldfont = wezterm.font(basefont, { weight = 'Bold'})
config.font = regularfont

config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
config.audible_bell = "Disabled"
config.window_close_confirmation = 'NeverPrompt'
config.canonicalize_pasted_newlines = 'CarriageReturn'
if (config.notification_handling ~= nil) then
  config.notification_handling = 'AlwaysShow'
end

-- os specifics
-- linux
if string.find(wezterm.target_triple, 'linux') ~= nil then
  myenv="linux"
end


-- function on event toggle-theme - see config.keys
wezterm.on('toggle-theme', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.color_scheme == lighttheme then
    overrides.color_scheme = darktheme
  else
    overrides.color_scheme = lighttheme
  end
  window:set_config_overrides(overrides)
end)

config.keys = {
  {
    key = 'w',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },

  {
    key = '1',
    mods = 'CTRL',
    action = wezterm.action.PaneSelect {
      alphabet = '1234567890',
    },
  },
  {
    key = '2',
    mods = 'CTRL',
    action = wezterm.action.PaneSelect {
      alphabet = '1234567890',
      mode = 'SwapWithActive',
    },
  },
  {
    key = '3',
    mods = 'CTRL',
    action = wezterm.action.EmitEvent 'toggle-theme',
  },
}

local mux = wezterm.mux

wezterm.on('gui-startup', function(window)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window();
  gui_window:maximize()
end)


config.window_padding = {
    left=0,
    right=0,
    top=0,
    bottom=0
}
config.window_decorations = "NONE"

config.use_resize_increments = false
config.adjust_window_size_when_changing_font_size = false

-- and finally, return the configuration to wezterm
return config

