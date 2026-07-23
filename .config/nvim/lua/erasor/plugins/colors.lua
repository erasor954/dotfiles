vim.pack.add({ gh("erikbackman/brightburn.vim") })
vim.pack.add({ gh("oskarnurm/koda.nvim") })
vim.pack.add({ gh("slugbyte/lackluster.nvim") })
vim.pack.add({ gh("folke/tokyonight.nvim") })
vim.pack.add({ gh("ellisonleao/gruvbox.nvim") })
vim.pack.add({ gh("rose-pine/neovim") })
vim.pack.add({ gh("olimorris/onedarkpro.nvim") })
vim.pack.add({ gh("catppuccin/nvim") })
vim.pack.add({ gh("rebelot/kanagawa.nvim") })
vim.pack.add({ gh("aktersnurra/no-clown-fiesta.nvim") })
vim.pack.add({ gh("ayu-theme/ayu-vim") })
vim.pack.add({ gh("EdenEast/nightfox.nvim") })

-- Koda
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

-- Gruvbox
require("gruvbox").setup({
	terminal_colors = true,
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
	inverse = true,
	contrast = "",
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
})

-- TokyoNight
require("tokyonight").setup({
	style = "storm",
	transparent = true,
	terminal_colors = true,
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
		sidebars = "dark",
		floats = "dark",
	},
})

-- Rose-Pine
require("rose-pine").setup({
	disable_background = true,
	styles = {
		italic = false,
	},
})

-- OneDarkPro
require("onedarkpro").setup({})

-- Catppuccin
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	integrations = { telescope = true, treesitter = true },
})

require("kanagawa").setup()

require("nightfox").setup({
	palettes = {
		carbonfox = {
			red = "#c47a95", -- Dusty rose
			green = "#78a280", -- Sage green
			blue = "#7398b5", -- Steel blue
			yellow = "#bba377", -- Soft ochre
			magenta = "#a37fa4", -- Muted plum
			cyan = "#72a1a1", -- Slate teal
			orange = "#bd846b", -- Rust
		},
	},
})

vim.cmd.colorscheme("kanagawa-dragon")
