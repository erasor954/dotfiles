vim.pack.add({ gh("stevearc/conform.nvim") })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		java = {
			"clang-format",
		},
		sh = { "shfmt" },
		bash = { "shfmt" },
		html = { "prettier" },
	},
	formatters = {
		["clang-format"] = {
			prepend_args = {
				"--style={BasedOnStyle: Google, IndentWidth: 4, ContinuationIndentWidth: 4}",
			},
		},
		["prettier"] = {
			prepend_args = {
				"--tab-width",
				"4",
				"--use-tabs",
			},
		},
	},
	format_after_save = {
		lsp_format = "fallback",
	},
})
