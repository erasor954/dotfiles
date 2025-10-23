return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				java = {
					"clang-format", -- use clang-format instead of google-java-format
				},
			},
			formatters = {
				["clang-format"] = {
					prepend_args = {
						"--style={BasedOnStyle: Google, IndentWidth: 4, ContinuationIndentWidth: 4}",
					},
				},
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
