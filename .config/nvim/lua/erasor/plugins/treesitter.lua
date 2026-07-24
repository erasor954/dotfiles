vim.pack.add({ gh("nvim-treesitter/nvim-treesitter") })

require("nvim-treesitter").install({
	"lua",
	"javascript",
	"typescript",
	"html",
	"css",
	"java",
	"bash",
})

vim.treesitter.language.register("bash", "zsh")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
