local state_file = vim.fn.stdpath("data") .. "/lsp_toggle_state"

local function is_lsp_enabled()
	if vim.fn.filereadable(state_file) == 0 then
		return true
	end
	local lines = vim.fn.readfile(state_file)
	return #lines > 0 and vim.trim(lines[1]) == "true"
end

local function set_lsp_state(state)
	vim.fn.writefile({ tostring(state) }, state_file)
end

_G.toggle_lsp_system = function()
	local currently_enabled = is_lsp_enabled()
	local new_state = not currently_enabled
	set_lsp_state(new_state)

	if new_state then
		vim.notify("LSP Enabled. Restart Neovim to load servers.", "info")
	else
		for _, client in ipairs(vim.lsp.get_clients()) do
			client:stop()
		end
		vim.notify("LSP Disabled and Stopped.", "warn")
	end
end

vim.keymap.set("n", "<leader>tl", "<cmd>lua _G.toggle_lsp_system()<CR>", { desc = "Toggle LSP Persistence" })

vim.pack.add({ gh("williamboman/mason.nvim") })
vim.pack.add({ gh("neovim/nvim-lspconfig") }) -- MUST be loaded before mason-lspconfig
vim.pack.add({ gh("williamboman/mason-lspconfig.nvim") })

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "jdtls" },
	automatic_installation = true,
})

if is_lsp_enabled() then
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	vim.lsp.config("lua_ls", { capabilities = capabilities })
	vim.lsp.enable("lua_ls")

	vim.lsp.config("jdtls", {
		capabilities = capabilities,
		root_dir = function(bufnr, on_dir)
			local root = vim.fs.root(bufnr, { "mvnw", "gradlew", "pom.xml", "build.gradle", ".git" })
			on_dir(root or vim.fn.getcwd())
		end,
	})
	vim.lsp.enable("jdtls")
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
	end,
})

vim.diagnostic.config({
	float = { border = "rounded", source = "always" },
})
