function ColorMyPencils(color)
	color = color or "koda"
	vim.cmd.colorscheme(color)

	--    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

	{
		"erikbackman/brightburn.vim",
	},

	{
		"oskarnurm/koda.nvim",
		lazy = false, -- Load this immediately
		priority = 1000, -- Ensure it loads before other plugins
		config = function()
			require("koda").setup({
				styles = {
					functions = { bold = false },
					comments = { italic = true },
				},
				colors = {
					bg = "#131313",
					func = "#9CBFE7",
					string = "#98bb6c",
				},
			})
			ColorMyPencils()
		end,
	},

	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		config = function() end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {},
		config = function() end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = false },
					keywords = { italic = false },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
			})
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		config = function()
			require("onedarkpro").setup({})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				integrations = { telescope = true, treesitter = true },
			})
		end,
	},
}
