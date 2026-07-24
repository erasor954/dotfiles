vim.pack.add({ gh("nvim-tree/nvim-web-devicons") })
vim.pack.add({ gh("ibhagwan/fzf-lua") })

require("fzf-lua").setup({
	winopts = {
		preview = {
			-- default = "bat", -- uses "bat" for preview if available
			layout = "flex", -- horizontal or vertical depending on window size
		},
	},
})

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "[F]zfLua [F]iles" })
vim.keymap.set("n", "<leader>fa", "<cmd>FzfLua git_files<cr>", { desc = "[F]zfLua [A]ll files in git repo" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "[F]zfLua [B]uffers" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "[F]zfLua [G]rep" })
vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "[C]ode [A]ctions" })
