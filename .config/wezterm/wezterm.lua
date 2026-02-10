local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- FONT
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 18.0

-- STYLING
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}
config.window_close_confirmation = "NeverPrompt"

-- THEME
--local lighttheme = "Ayu Light (Gogh)"
-- local darktheme = "Catch Me If You Can (terminal.sexy)"
local lighttheme = require("light")
local darktheme = require("dark")
-- config.color_scheme = darktheme
config.colors = require("active_theme")

-- KEYBINDINGS
config.keys = {
	{
		key = "3",
		mods = "CTRL",
		action = wezterm.action.EmitEvent("toggle-theme"),
	},
}

-- wezterm.on("toggle-theme", function(window, pane)
-- 	local overrides = window:get_config_overrides() or {}
-- 	if overrides.color_scheme == lighttheme then
-- 		overrides.color_scheme = darktheme
-- 	else
-- 		overrides.color_scheme = lighttheme
-- 	end
-- 	window:set_config_overrides(overrides)
-- end)
wezterm.on("toggle-theme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.colors then
		overrides.colors = nil
	else
		overrides.colors = lighttheme
	end
	window:set_config_overrides(overrides)
end)

return config
