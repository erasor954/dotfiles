return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			java = { "clang-format" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			html = { "prettier" },
			css = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			svelte = { "prettier" },
		},
		formatters = {
			["clang-format"] = {
				prepend_args = {
					"--style={BasedOnStyle: Google, IndentWidth: 4, ContinuationIndentWidth: 4, AccessModifierOffset: -4}",
				},
			},
			["biome"] = {
				require_cwd = false,
				args = {
					"format",
					"--config-path",
					vim.fn.expand("~/.config/biome"),
					"--stdin-file-path",
					"$FILENAME",
				},
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
