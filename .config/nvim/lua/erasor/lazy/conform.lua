return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				java = {
					"clang-format",
				},
			},
			formatters = {
				["clang-format"] = {
					prepend_args = {
						"--style={BasedOnStyle: Google, IndentWidth: 4, ContinuationIndentWidth: 4}",
					},
				},
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		})
	end,
}
