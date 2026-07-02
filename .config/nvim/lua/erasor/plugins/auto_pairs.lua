vim.pack.add({ gh("windwp/nvim-autopairs") })
vim.pack.add({ gh("windwp/nvim-ts-autotag") })

require("nvim-autopairs").setup({
	check_ts = true,
})

require("nvim-ts-autotag").setup()
