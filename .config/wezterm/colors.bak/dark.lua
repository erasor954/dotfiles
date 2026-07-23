-- colors.lua
return {
	-- The Main Background & Foreground
	-- background = "#0D0D0D",
	background = "#131313",
	foreground = "#F2F2F2",

	-- UI Elements (Derived from the palette)
	cursor_bg = "#F2F2F2",
	cursor_fg = "#0D0D0D",
	cursor_border = "#F2F2F2",

	selection_fg = "#F2F2F2",
	selection_bg = "#5E5E5E", -- Uses the "Blue" shade for selection highlight

	scrollbar_thumb = "#595959",
	split = "#2D2D2D",

	-- Standard ANSI Colors (Black, Red, Green, Yellow, Blue, Purple, Cyan, White)
	ansi = {
		"#0D0D0D", -- Black
		"#595959", -- Red
		"#A9A9A9", -- Green
		"#BFBFBF", -- Yellow
		"#5E5E5E", -- Blue
		"#3B3B3B", -- Purple
		"#B6B6B6", -- Cyan
		"#F2F2F2", -- White
	},

	-- Brights
	brights = {
		"#2D2D2D", -- Bright Black
		"#8C8C8C", -- Bright Red
		"#C9C9C9", -- Bright Green
		"#DFDFDF", -- Bright Yellow
		"#7E7E7E", -- Bright Blue
		"#3B3B3B", -- Bright Purple
		"#D6D6D6", -- Bright Cyan
		"#FFFFFF", -- Bright White
	},

	tab_bar = {
		background = "#131313",
	},
}
