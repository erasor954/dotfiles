vim.pack.add({ gh("Saghen/blink.lib") })
vim.pack.add({ gh("Saghen/blink.cmp") })

require("blink.cmp").setup({
	fuzzy = {
		implementation = "lua",
	},

	keymap = { preset = "default" },

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	signature = { enabled = true },
})
