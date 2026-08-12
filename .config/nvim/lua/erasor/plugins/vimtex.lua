vim.pack.add({ gh("lervag/vimtex") })

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

vim.g.vimtex_compiler_method = "latexmk"
vim.g.tex_flavor = "latex"

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tex",
	command = "set filetype=tex",
})

vim.g.vimtex_compiler_latexmk = {
	build_dir = "",
	callback = 1,
	continuous = 1,
	executable = "latexmk",
	hooks = {},
	options = {
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
		"-lualatex",
	},
}

vim.g.vimtex_view_method = "skim"
