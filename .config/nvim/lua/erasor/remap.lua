vim.keymap.set("n", "<leader>fl", vim.cmd.Ex)

-- Move a line UP/DOWN
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Split panes
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "[S]plit [V]ertical" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "[S]plit [H]orizontal" })

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

vim.keymap.set("n", "H", "^", { desc = "Jump to first character on line" })
vim.keymap.set("n", "L", "$")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
