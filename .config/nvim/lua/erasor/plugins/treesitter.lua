-- Add the lightweight manager
-- vim.pack.add({ gh("romus204/tree-sitter-manager.nvim") })

-- require("tree-sitter-manager").setup({})
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
	},
})
