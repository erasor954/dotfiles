vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fl", vim.cmd.Ex)

-- Move a line UP/DOWN
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- CTRL + %, ", for split creation
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "[S]plit [V]ertical" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "[S]plit [H]orizontal" })
-- vim.keymap.set("n", "<leader>t", ":bot split | terminal<CR>")

-- CTRL + h, j, k, l, for split pane navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end, { desc = "[C]ode [F]ormat" })

vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Jump to next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Jump to prev buffer" })
vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "[Q]uit current buffer" })
vim.keymap.set("n", "<leader>wq", ":w | bd<CR>", { desc = "[W]rite and [Q]uit current buffer" })
