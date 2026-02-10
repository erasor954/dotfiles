local wezterm = require("wezterm")
local platform = require("utils.platform")

-- local font_family = 'Maple Mono NF'
local font_family = "JetBrains Mono"
-- local font_family = 'CartographCF Nerd Font'

local font_size = platform.is_mac and 12 or 16

return {
	font = wezterm.font({
		family = font_family,
		weight = "Medium",
		-- "calt=0" disables Contextual Alternates (the specific code for ligatures)
		-- "clig=0" and "liga=0" disable other standard ligatures
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	}),
	font_size = font_size,

	window_frame = {
		font = wezterm.font({
			family = "JetBrainsMono Nerd Font Mono",
			weight = "Medium",
		}),

		font_size = font_size,
	},

	--ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
	freetype_load_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
	freetype_render_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
