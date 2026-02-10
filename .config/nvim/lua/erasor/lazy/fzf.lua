return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Calling setup is optional, but allows you to configure the UI
			require("fzf-lua").setup({
				winopts = {
					preview = {
						-- default = "bat", -- uses "bat" for preview if available
						layout = "flex", -- horizontal or vertical depending on window size
					},
				},
			})

			-- Keybindings
			vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "FzfLua Files" })
			vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "FzfLua Buffers" })
			vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "FzfLua Grep" })
			vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "Code Actions" })
		end,
	},
}
