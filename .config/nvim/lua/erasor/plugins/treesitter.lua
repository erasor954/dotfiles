return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", 
	event = { "BufReadPost", "BufNewFile" }, 
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"javascript",
			"typescript",
			"html",
			"css",
			"java",
			"bash",
            "c",
            "cpp",
		})

		vim.treesitter.language.register("bash", "zsh")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "tex", "latex" },
			callback = function()
				vim.treesitter.stop()
			end,
		})
	end,
}
