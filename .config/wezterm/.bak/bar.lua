local wez = require("wezterm")
local bar = wez.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local M = {}
function M.apply_to_config(config)
	local bar_options = {
		modules = {
			workspace = {
				enabled = true,
				icon = wez.nerdfonts.cod_window,
				color = 8,
			},
			tabs = {
				active_tab_fg = 4,
				inactive_tab_fg = 6,
				new_tab_fg = 2,
			},
			leader = {
				enabled = true,
				icon = wez.nerdfonts.oct_rocket,
				color = 2,
			},
			zoom = {
				enabled = false,
				icon = wez.nerdfonts.md_fullscreen,
				color = 4,
			},
			pane = {
				enabled = true,
				icon = wez.nerdfonts.cod_multiple_windows,
				color = 7,
			},
			hostname = {
				enabled = false,
				icon = wez.nerdfonts.cod_server,
				color = 8,
			},
			username = {
				enabled = false,
				icon = wez.nerdfonts.fa_user,
				color = 6,
			},
			clock = {
				enabled = false,
				icon = wez.nerdfonts.md_calendar_clock,
				format = "%H:%M",
				color = 5,
			},
			cwd = {
				enabled = true,
				icon = wez.nerdfonts.oct_file_directory,
				color = 7,
			},
			spotify = {
				enabled = false,
				icon = wez.nerdfonts.fa_spotify,
				color = 3,
				max_width = 64,
				throttle = 15,
			},
		},
	}
	bar.apply_to_config(config, bar_options)
end
return M
