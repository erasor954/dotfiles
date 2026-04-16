vim.opt_local.wrap = true
vim.opt_local.spell = false
vim.opt_local.conceallevel = 2

vim.pack.add({
	"https://github.com/iamcco/markdown-preview.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

local ok, render_md = pcall(require, "render-markdown")
if ok then
	render_md.setup({
		heading = {
			sign = false,
			backgrounds = {},
			icons = { "󰉫  ", "󰉬  ", "󰉭  ", "󰉮  ", "󰉯  ", "󰉰  " },
		},

		code = {
			sign = false,
			style = "normal",
		},

		dash = {
			icon = "─",
			width = "full",
		},

		bullet = {
			icons = { "•", "◦", "▪" },
		},

		checkbox = {
			unchecked = { icon = "[ ] " },
			checked = { icon = "[x] " },
		},
	})
end

vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", {
	buffer = true,
	desc = "Preview Markdown in Browser",
})
