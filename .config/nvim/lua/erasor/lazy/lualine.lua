return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			bg = "#101010",
			fg = "#b0b0b0",
			line = "#272727",
			emphasis = "#ffffff",
			comment = "#50585d",
			blue = "#7e9cd8",
		}

		local custom_theme = require("lualine.themes.auto")

		local high_contrast_theme = {
			a = { fg = colors.bg, bg = colors.emphasis, gui = "bold" },
			b = { fg = colors.fg, bg = colors.line },
			c = { fg = colors.fg, bg = colors.bg },
			z = { fg = colors.bg, bg = colors.emphasis, gui = "bold" },
		}

		custom_theme.normal = high_contrast_theme
		custom_theme.insert = high_contrast_theme
		require("lualine").setup({

			options = {
				theme = custom_theme,

				section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },

				globalstatus = true,
			},

			sections = {
				-- Left side
				lualine_a = { "mode" },
				lualine_b = { "" },
				lualine_c = {
					{
						"buffers",
						mode = 0,
						show_modified_status = true,
						show_filename_only = true,

						buffers_color = {
							active = { fg = "#7e9cd8", gui = "bold" },
							inactive = { fg = "#50585d" },
						},

						symbols = {
							modified = "[+]",
							alternate_file = "",
							directory = "",
						},
					},
				},

				-- Right side
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = "E", warn = "W", info = "I", hint = "H" },
					},
				},
				lualine_y = {
					-- {
					-- 	function()
					-- 		-- 1. Get path relative to home (~/dev/projects/my-app)
					-- 		local path = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					--
					-- 		-- 2. Shorten the path: '~/dev/projects/my-app' -> '~/d/p/my-app'
					-- 		-- This regex finds folder names followed by a separator and keeps the first char
					-- 		return " " .. path:gsub("([^/])[^/]*/", "%1/")
					-- 	end,
					-- 	color = { fg = colors.fg, gui = "bold" },
					-- 	separator = { right = "|" },
					-- },
					"branch",
				},
				lualine_z = { "location" },
			},
		})
	end,
}
