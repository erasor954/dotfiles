vim.pack.add({ gh("MeanderingProgrammer/render-markdown.nvim"), gh("brianhuster/live-preview.nvim") })

require("render-markdown").setup({
	heading = {
		sign = false,
		icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
	},
	code = {
		sign = false,
		width = "block",
		right_pad = 1,
	},
	checkbox = {
		unchecked = { icon = "󰄱 " },
		checked = { icon = "󰱒 " },
	},
})

require("live-preview").setup({
	port = 8080,
	browser = "default",
})

vim.keymap.set("n", "<leader>mp", "<cmd>LivePreview toggle<cr>", {
	desc = "Toggle Live Preview",
})
