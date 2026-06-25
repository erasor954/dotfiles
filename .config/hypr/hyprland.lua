-------------------
--- MY PROGRAMS ---
-------------------
local terminal = "wezterm"
local fileManager = "nautilus"
local menu = "vicinae toggle"
local browser = "helium"
local editor = "~/.local/bin/zed"

local mainMod = "SUPER"
local shiftMod = "SUPER + SHIFT"

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-----------------
--- AUTOSTART ---
-----------------
hl.on("hyprland.start", function()
	-- hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- hl.exec_cmd("systemctl --user start graphical-session.target")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("mako")
	hl.exec_cmd("[workspace 1 silent] " .. terminal)
	hl.exec_cmd("[workspace 2 silent] " .. browser)
	hl.exec_cmd("sleep 2 && waybar")
	hl.exec_cmd("vicinae server")
end)

---------------------
--- CONFIGURATION ---
---------------------
hl.config({
	monitor = {
		",preferred,auto,auto",
	},

	general = {
		gaps_in = 5,
		gaps_out = 2,
		border_size = 1,
		["col.active_border"] = "rgba(74c7ecee)",
		["col.inactive_border"] = "rgba(595959aa)",
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.8,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		initial_workspace_tracking = 0,
	},

	input = {
		kb_layout = "us, de",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle,caps:nocaps,caps:escape",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
		},
	},

	device = {
		{
			name = "epic-mouse-v1",
			sensitivity = -0.5,
		},
	},

	-- Lua nested table matching for modern layer rules
	layerrule = {
		{
			name = "vicinae-blur",
			blur = true,
			ignore_alpha = 0,
			match = { namespace = "vicinae" },
		},
	},

	windowrule = {
		"suppress_event maximize, match:class .*",
		"no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0",
	},

	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

------------------
--- ANIMATIONS ---
------------------

-- Define your custom Bezier curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Apply the animations to the Animation Tree
-- Global
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

-- Borders
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })

-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })

-- Fade
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })

-- Layers
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })

-- Fade Layers
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

-- Workspaces
-- Note: As per the docs, if enabled = false, we can omit the other arguments (speed, curve, style).
hl.animation({ leaf = "workspaces", enabled = false })
hl.animation({ leaf = "workspacesIn", enabled = false })
hl.animation({ leaf = "workspacesOut", enabled = false })

-- Misc
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-------------------
--- KEYBINDINGS ---
-------------------

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(editor))
hl.bind(shiftMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Screenshots
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -o /home/erasor/Pictures/Screenshots/ -m window"))
hl.bind(shiftMod .. " + P", hl.dsp.exec_cmd("hyprshot -o /home/erasor/Pictures/Screenshots/ -m region"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(editor))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Workspaces
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(shiftMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Binds (using `{ mouse = true }` as the translation for `bindm`)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Repeating & Locked binds (previously bindel / bindl)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

-- Playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
