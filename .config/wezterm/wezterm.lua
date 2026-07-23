local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

---------------------------------------------------------------
--- OS Detection & Modifier Keys
---------------------------------------------------------------
local is_mac = wezterm.target_triple:find("apple") ~= nil
local mod = {}

if is_mac then
	mod.SUPER = "CMD"
	mod.SUPER_REV = "CMD|SHIFT"
	mod.HYPER = "CMD|CTRL|OPT|SHIFT" -- Karabiner Hyper key
else
	mod.SUPER = "CTRL" -- Prevents Windows key conflicts
	mod.SUPER_REV = "ALT|CTRL"
	mod.HYPER = "CTRL|SHIFT" -- Fallback for non-Mac
end

---------------------------------------------------------------
--- Status Bar Indicators (Leader, Copy Mode, Key Tables)
---------------------------------------------------------------
wezterm.on("update-status", function(window, pane)
	local cells = {}

	-- 1. Leader Key Indicator (HYPER + Space)
	if window:leader_is_active() then
		table.insert(cells, { Background = { Color = "#e0af68" } }) -- Amber/Yellow
		table.insert(cells, { Foreground = { Color = "#11111b" } })
		table.insert(cells, { Text = " 󰠠 LEADER " })
	end

	-- 2. Copy Mode Indicator (Checks active pane user vars or title patterns)
	local info = pane:get_metadata()
	-- WezTerm sets is_mouse_grab_active or we can check if title indicates copy mode
	if info and info.is_copy_mode then
		table.insert(cells, { Background = { Color = "#bb9af7" } }) -- Purple
		table.insert(cells, { Foreground = { Color = "#11111b" } })
		table.insert(cells, { Text = "COPY MODE " })
	end

	-- 3. Active Key Table Indicator (resize_pane, resize_font)
	local stat = window:active_key_table()
	if stat then
		table.insert(cells, { Background = { Color = "#7aa2f7" } }) -- Blue
		table.insert(cells, { Foreground = { Color = "#11111b" } })
		table.insert(cells, { Text = " MODE: " .. stat:upper() .. " " })
	end

	-- Render status cells on the right side
	if #cells > 0 then
		window:set_right_status(wezterm.format(cells))
	else
		window:set_right_status("")
	end
end)

---------------------------------------------------------------
--- Custom Tab Bar Formatting
---------------------------------------------------------------
wezterm.on("format-tab-title", function(tab, tabs, panes, _config, hover, max_width)
	local index = tab.tab_index + 1
	local process_name = tab.active_pane.foreground_process_name

	-- Extract just the executable name (e.g., 'zsh' instead of '/bin/zsh')
	if process_name and #process_name > 0 then
		process_name = process_name:match("([^/\\]+)$")
	else
		process_name = tab.active_pane.title
	end

	local active_title = "[" .. index .. "]" .. ": " .. process_name
	local title = index .. ": " .. process_name

	if tab.is_active then
		return {
			-- { Foreground = { Color = "#DCD7BA" } }, -- Kanagawa Dragon text color
			{ Text = " " .. active_title .. " " },
		}
	else
		return {
			-- { Foreground = { Color = "#727169" } }, -- Muted Kanagawa gray
			{ Text = " " .. title .. " " },
		}
	end
end)

---------------------------------------------------------------
--- General Settings
---------------------------------------------------------------
config.automatically_reload_config = true
config.exit_behavior = "CloseOnCleanExit"
config.exit_behavior_messaging = "Verbose"
config.status_update_interval = 1000
config.audible_bell = "Disabled"
config.scrollback_lines = 20000

config.hyperlink_rules = {
	{ regex = "\\((\\w+://\\S+)\\)", format = "$1", highlight = 1 },
	{ regex = "\\[(\\w+://\\S+)\\]", format = "$1", highlight = 1 },
	{ regex = "\\{(\\w+://\\S+)\\}", format = "$1", highlight = 1 },
	{ regex = "<(\\w+://\\S+)>", format = "$1", highlight = 1 },
	{ regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+", format = "$0" },
	{ regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b", format = "mailto:$0" },
}

---------------------------------------------------------------
--- Appearance & Window
---------------------------------------------------------------
config.max_fps = 120
config.front_end = "WebGpu"
config.prefer_egl = false
config.webgpu_power_preference = "HighPerformance"
config.underline_thickness = "1.5pt"
config.enable_scroll_bar = false

-- Tab bar settings
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_max_width = 12
config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false

-- Command palette
config.command_palette_fg_color = "#b4befe"
config.command_palette_bg_color = "#11111b"
config.command_palette_font_size = 12
config.command_palette_rows = 25

-- Window settings
config.window_padding = { left = 10, right = 10, top = 10, bottom = 7.5 }
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
-- config.window_frame = { active_titlebar_bg = "#090909" }
config.window_frame = {}
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }
config.window_decorations = "RESIZE"

---------------------------------------------------------------
--- Fonts
---------------------------------------------------------------
local font_size = 16

config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = font_size

config.window_frame.font = wezterm.font({
	family = "JetBrainsMono Nerd Font Mono",
	weight = "Medium",
})
config.window_frame.font_size = font_size

config.freetype_load_target = "Normal"
config.freetype_render_target = "Normal"

---------------------------------------------------------------
--- Keybindings
---------------------------------------------------------------
config.disable_default_key_bindings = true
config.leader = { key = "Space", mods = mod.HYPER }

local keys = {
	-- Misc/Useful
	{ key = "#", mods = mod.HYPER, action = act.EmitEvent("toggle-theme") },
	{ key = "x", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "F2", mods = "NONE", action = act.ActivateCommandPalette },
	{ key = "F3", mods = "NONE", action = act.ShowLauncher },
	{ key = "F4", mods = "NONE", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
	{ key = "F5", mods = "NONE", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{ key = "F11", mods = "NONE", action = act.ToggleFullScreen },
	{ key = "F12", mods = "NONE", action = act.ShowDebugOverlay },
	{ key = "f", mods = "LEADER", action = act.Search({ CaseInSensitiveString = "" }) },
	{
		key = "u",
		mods = mod.SUPER_REV,
		action = act.QuickSelectArgs({
			label = "open url",
			patterns = {
				"\\((https?://\\S+)\\)",
				"\\[(https?://\\S+)\\]",
				"\\{(https?://\\S+)\\}",
				"<(https?://\\S+)>",
				"\\bhttps?://\\S+[)/a-zA-Z0-9-]+",
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},

	-- Cursor movement
	{ key = "LeftArrow", mods = mod.SUPER, action = act.SendString("\u{1b}OH") },
	{ key = "RightArrow", mods = mod.SUPER, action = act.SendString("\u{1b}OF") },
	{ key = "Backspace", mods = mod.SUPER, action = act.SendString("\u{15}") },

	-- Copy/Paste (Standard Mac CMD+C / CMD+V)
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

	-- Delete word/line
	{ key = "Backspace", mods = "ALT", action = act.SendKey({ key = "w", mods = "CTRL" }) },
	{ key = "Backspace", mods = mod.SUPER, action = act.SendKey({ key = "u", mods = "CTRL" }) },

	-- Tabs: spawn+close
	{ key = "t", mods = mod.SUPER, action = act.SpawnTab("DefaultDomain") },
	{ key = "w", mods = mod.SUPER_REV, action = act.CloseCurrentPane({ confirm = false }) },

	-- Tabs: navigation
	{ key = "[", mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = mod.SUPER, action = act.ActivateTabRelative(1) },
	{ key = "[", mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
	{ key = "]", mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

	-- Tab: title events
	{ key = "0", mods = mod.SUPER, action = act.EmitEvent("tabs.manual-update-tab-title") },
	{ key = "0", mods = mod.SUPER_REV, action = act.EmitEvent("tabs.reset-tab-title") },

	-- Window: zoom
	{
		key = "-",
		mods = mod.SUPER_REV,
		action = wezterm.action_callback(function(window, _pane)
			local dimensions = window:get_dimensions()
			if dimensions.is_full_screen then
				return
			end
			window:set_inner_size(dimensions.pixel_width - 50, dimensions.pixel_height - 50)
		end),
	},
	{
		key = "=",
		mods = mod.SUPER_REV,
		action = wezterm.action_callback(function(window, _pane)
			local dimensions = window:get_dimensions()
			if dimensions.is_full_screen then
				return
			end
			window:set_inner_size(dimensions.pixel_width + 50, dimensions.pixel_height + 50)
		end),
	},
	{
		key = "Enter",
		mods = mod.SUPER_REV,
		action = wezterm.action_callback(function(window, _pane)
			window:maximize()
		end),
	},

	-- Fonts
	{ key = "=", mods = mod.SUPER, action = act.IncreaseFontSize },
	{ key = "-", mods = mod.SUPER, action = act.DecreaseFontSize },

	-- Panes: split
	{ key = "h", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Panes: zoom+close pane
	{ key = "Enter", mods = mod.SUPER, action = act.TogglePaneZoomState },

	-- Panes: navigation
	{ key = "k", mods = mod.HYPER, action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = mod.HYPER, action = act.ActivatePaneDirection("Down") },
	{ key = "h", mods = mod.HYPER, action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = mod.HYPER, action = act.ActivatePaneDirection("Right") },
	{
		key = "p",
		mods = mod.SUPER_REV,
		action = act.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }),
	},

	-- Panes: scroll
	{ key = "u", mods = mod.SUPER, action = act.ScrollByLine(-5) },
	{ key = "d", mods = mod.SUPER, action = act.ScrollByLine(5) },
	{ key = "PageUp", mods = "NONE", action = act.ScrollByPage(-0.75) },
	{ key = "PageDown", mods = "NONE", action = act.ScrollByPage(0.75) },

	-- Key-tables triggers
	{
		key = "f",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_font", one_shot = false, timemout_milliseconds = 1000 }),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false, timemout_milliseconds = 1000 }),
	},
}

-- Add tab navigation for 1-9
for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = mod.SUPER,
		action = act.ActivateTab(i - 1),
	})
end

config.keys = keys

config.key_tables = {
	resize_font = {
		{ key = "k", action = act.IncreaseFontSize },
		{ key = "j", action = act.DecreaseFontSize },
		{ key = "r", action = act.ResetFontSize },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},
	resize_pane = {
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},
}

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

---------------------------------------------------------------
--- Theme & Tab Bar Setup
---------------------------------------------------------------
local theme_name = "Kanagawa Dragon (Gogh)"
config.color_scheme = theme_name

-- Fetch the built-in color schemes natively on nightly
local schemes = wezterm.color.get_builtin_schemes()
local theme_colors = schemes[theme_name]

if theme_colors then
	config.colors = {
		tab_bar = {
			background = theme_colors.background,
			active_tab = {
				bg_color = theme_colors.selection_bg or "#f3f3f3",
				fg_color = theme_colors.background,
			},
			inactive_tab = {
				bg_color = theme_colors.background,
				fg_color = "#727169",
			},
			inactive_tab_hover = {
				bg_color = theme_colors.selection_bg or "#223249",
				fg_color = theme_colors.foreground,
			},
			new_tab = {
				bg_color = theme_colors.background,
				fg_color = theme_colors.foreground,
			},
			new_tab_hover = {
				bg_color = theme_colors.selection_bg or "#223249",
				fg_color = theme_colors.foreground,
			},
		},
	}
end

return config
