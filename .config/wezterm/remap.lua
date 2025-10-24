local wezterm = require("wezterm")

local M = {}

M.keys = {
	-- Open new tab
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- Close current tab
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
}

-- Switch to tab 1..9 using Ctrl+number
for i = 1, 9 do
	table.insert(M.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = wezterm.action.ActivateTab(i - 1), -- Lua index is 0-based
	})
end

return M
