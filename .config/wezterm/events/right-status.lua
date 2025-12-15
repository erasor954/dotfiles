local wezterm = require("wezterm")
local Cells = require("utils.cells")

local nf = wezterm.nerdfonts
local attr = Cells.attr

local M = {}

local ICON_FOLDER = nf.md_folder

---@type table<string, Cells.SegmentColors>
local colors = {
	-- Changed to a blue/purple style for directories, but you can keep your old colors
	cwd = { fg = "#cba6f7", bg = "rgba(0, 0, 0, 0.4)" },
	separator = { fg = "#74c7ec", bg = "rgba(0, 0, 0, 0.4)" },
}

local cells = Cells:new()

-- Define the new segments (Icon + Text)
cells
	:add_segment("cwd_icon", ICON_FOLDER .. " ", colors.cwd, attr(attr.intensity("Bold")))
	:add_segment("cwd_text", "", colors.cwd)

---@param pane any
---@return string
local function get_cwd(pane)
	local cwd_uri = pane:get_current_working_dir()
	if not cwd_uri then
		return ""
	end

	local cwd = cwd_uri.file_path

	-- Replace home directory with ~
	local home = wezterm.home_dir
	if cwd:sub(1, #home) == home then
		cwd = "~" .. cwd:sub(#home + 1)
	end

	return cwd
end

M.setup = function()
	wezterm.on("update-right-status", function(window, pane)
		local cwd = get_cwd(pane)

		cells:update_segment_text("cwd_text", cwd)

		window:set_right_status(wezterm.format(cells:render({ "cwd_icon", "cwd_text" })))
	end)
end

return M
