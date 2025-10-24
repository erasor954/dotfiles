-- Pull in the wezterm API
local wezterm = require("wezterm")
local io = require("io")
local tabbar = require("tabbar")
local remap = require("remap")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Catppuccin Latte
--Tokyo Night Light (Gogh)
local lighttheme = "GruvboxLight"

-- Catppuccin Mocha
-- Tokyo Night
local darktheme = "Catppuccin Mocha"

local active_theme = darktheme
config.window_background_opacity = 1
config.color_scheme = active_theme

config.font_size = 18

local basefont = "JetBrains Mono"
local regularfont = wezterm.font(basefont, { weight = "Regular" })
local boldfont = wezterm.font(basefont, { weight = "Bold" })
config.font = regularfont

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.audible_bell = "Disabled"
config.window_close_confirmation = "NeverPrompt"
config.canonicalize_pasted_newlines = "CarriageReturn"
if config.notification_handling ~= nil then
	config.notification_handling = "AlwaysShow"
end

-- os specifics
-- linux
if string.find(wezterm.target_triple, "linux") ~= nil then
	myenv = "linux"
end

-- function on event toggle-theme - see config.keys
wezterm.on("toggle-theme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == lighttheme then
		active_theme = darktheme
	else
		active_theme = lighttheme
	end
	overrides.color_scheme = active_theme
	window:set_config_overrides(overrides)

	tabline.setup({
		options = {
			theme = active_theme,
		},
	})
end)

local mux = wezterm.mux

wezterm.on("gui-startup", function(window)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:maximize()
end)

config.use_resize_increments = false
config.adjust_window_size_when_changing_font_size = false

-- Keybindings
config.keys = remap.keys
table.insert(config.keys, {
	key = "#",
	mods = "CTRL|SHIFT",
	action = wezterm.action.EmitEvent("toggle-theme"),
})

-- Tabbar config
for k, v in pairs(tabbar.config) do
	config[k] = v
end

-- and finally, return the configuration to wezterm
return config
