local M = {}

local default_colors = require("config.appearance").darktheme

function M.get_color(window, key)
	local overrides = window:get_config_overrides() or {}

	if overrides.colors and overrides.colors[key] then
		return overrides.colors[key]
	end

	return default_colors[key]
end

return M
