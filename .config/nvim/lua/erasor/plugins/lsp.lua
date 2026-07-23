vim.pack.add({ gh("williamboman/mason.nvim") })
vim.pack.add({ gh("neovim/nvim-lspconfig") })
vim.pack.add({ gh("williamboman/mason-lspconfig.nvim") })
vim.pack.add({ gh("WhoIsSethDaniel/mason-tool-installer.nvim") })

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"shellcheck",
		"shfmt",
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jdtls",
		"ts_ls",
		"html",
		"cssls",
		"biome",
		"texlab",
		"bashls",
	},
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

vim.lsp.config("html", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
	end,
})
vim.lsp.enable("html")

vim.lsp.config("cssls", { capabilities = capabilities })
vim.lsp.enable("cssls")

vim.lsp.config("ts_ls", { capabilities = capabilities })
vim.lsp.enable("ts_ls")

vim.lsp.config("biome", { capabilities = capabilities })
vim.lsp.enable("biome")

vim.lsp.config("bashls", { capabilities = capabilities })
vim.lsp.enable("bashls")

vim.lsp.config("texlab", { capabilities = capabilities })
vim.lsp.enable("texlab")

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

vim.cmd("silent! doautoall FileType")
