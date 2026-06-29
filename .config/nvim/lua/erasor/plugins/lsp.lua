vim.pack.add({ gh("williamboman/mason.nvim") })
vim.pack.add({ gh("neovim/nvim-lspconfig") })
vim.pack.add({ gh("williamboman/mason-lspconfig.nvim") })

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "jdtls", "ts_ls", "html", "cssls" },
	automatic_installation = true,
})

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
