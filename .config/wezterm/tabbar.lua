local wezterm = require("wezterm")
local module = {}

-- This table will hold config options to be exported
module.config = {}

-- 1. Ensure you are using the non-fancy tab bar
module.config.use_fancy_tab_bar = false
module.config.tab_bar_at_bottom = true
module.config.window_decorations = "NONE"
module.config.use_fancy_tab_bar = false
module.config.show_new_tab_button_in_tab_bar = false
module.config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- This function will be called by the event handler
local function format_window_title(tab, pane, tabs, panes, config)
	local user = pane.user_vars.USER
	local host = pane.user_vars.HOSTNAME
	local title = pane.title or ""

	local prefix = ""

	if user and user ~= "" then
		if host and host ~= "" then
			-- Format as user@host
			prefix = string.format("%s@%s: ", user, host)
		else
			-- Just the user
			prefix = string.format("%s: ", user)
		end
	end

	return prefix .. title
end

-- 3. Register the event handler
-- We register the event here so all logic stays in this file.
wezterm.on("format-window-title", format_window_title)

-- Return the config table to be merged by wezterm.lua
return module
