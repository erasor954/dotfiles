vim.pack.add({ gh("arborist-ts/arborist.nvim") })
require("arborist").setup({
	install_popular = false,
	ensure_installed = {
		"lua",
		"javascript",
		"typescript",
		"html",
		"css",
		"java",
		"bash",
		"latex",
	},
})
