local wezterm = require("wezterm")
local shared_state = require("shared_state")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function active_tab_icon(tab)
	local idx = tab.tab_index + 1 -- tab_index is 0-based
	local field_name = "md_numeric_" .. idx .. "_box"
	local icon = wezterm.nerdfonts[field_name]
	local icon_str = icon or tostring(ids)
	local padding = " "
	return padding .. icon_str
end

local function inactive_tab_icon(tab)
	local idx = tab.tab_index + 1 -- tab_index is 0-based
	local field_name = "md_numeric_" .. idx .. "_box_outline"
	local icon = wezterm.nerdfonts[field_name]
	local icon_str = icon or tostring(ids)
	local padding = " "
	return padding .. icon_str .. padding
end

-- Tab bar
tabline.setup({
	options = {
		icons_enabled = true,
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = "",
			right = "",
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = "",
			right = "",
		},
	},
	sections = {
		tabline_a = { " " .. os.getenv("USER") .. " " },
		tabline_b = { { "" }, padding = { left = 0, right = 0 } },
		tabline_c = { "" },
		--[[
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
        --]]
		tab_active = {
			active_tab_icon,
			"process",
		},
		tab_inactive = {
			inactive_tab_icon,
			{ "process", padding = { left = 0, right = 1 } },
		},
		tabline_x = { "" },
		tabline_y = { { "" }, padding = { left = 0, right = 0 } },
		tabline_z = { "domain" },
	},
	extensions = {},
})

local M = {}
M.apply_to_config = tabline.apply_to_config
return M
