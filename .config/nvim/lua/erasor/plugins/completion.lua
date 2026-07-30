vim.pack.add({ gh("Saghen/blink.lib") })
vim.pack.add({ gh("Saghen/blink.cmp") })

local state_file = vim.fn.stdpath("data") .. "/blink_toggle_state.txt"

local function load_blink_state()
	local file = io.open(state_file, "r")
	if file then
		local content = file:read("*a"):gsub("%s+", "")
		file:close()
		return content == "true"
	end
	return true
end

local function save_blink_state(state)
	local file = io.open(state_file, "w")
	if file then
		file:write(state and "true" or "false")
		file:close()
	end
end

vim.g.blink_cmp_enabled = load_blink_state()

require("blink.cmp").setup({
	enabled = function()
		if not vim.g.blink_cmp_enabled then
			return false
		end
		return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
	end,

	fuzzy = {
		implementation = "lua",
	},

	keymap = {
		preset = "default",
		["<C-y>"] = { "select_and_accept", "fallback" },
		["<CR>"] = { "accept", "fallback" },
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	signature = { enabled = true },

	completion = {
		list = {
			selection = {
				preselect = false,
			},
		},
	},
})

vim.api.nvim_create_user_command("BlinkToggle", function()
	vim.g.blink_cmp_enabled = not vim.g.blink_cmp_enabled

	save_blink_state(vim.g.blink_cmp_enabled)

	if vim.g.blink_cmp_enabled then
		vim.notify("Autocomplete enabled globally", vim.log.levels.INFO)
	else
		local ok, blink = pcall(require, "blink.cmp")
		if ok then
			blink.hide()
		end
		vim.notify("Autocomplete disabled globally", vim.log.levels.INFO)
	end
end, { desc = "Toggle blink.cmp autocomplete globally" })

vim.keymap.set("n", "<leader>ta", "<cmd>BlinkToggle<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle autocomplete globally",
})
