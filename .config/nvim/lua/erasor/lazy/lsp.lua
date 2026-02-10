return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
		-- 1. Setup Mason
		require("mason").setup()

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"jdtls",
			},
			automatic_installation = true,
			handlers = {
				-- The default handler for most servers (lua_ls, etc.)
				function(server_name)
					require("lspconfig")[server_name].setup({
						autostart = false,
					})
				end,

				-- Specific override for JDTLS to fix the "Single File" issue
				["jdtls"] = function()
					require("lspconfig").jdtls.setup({
						autostart = false,
						-- JDTLS usually needs a project marker (.git, mvnw, etc.) to start.
						-- This function checks for those, and if not found, falls back to the
						-- current folder (vim.fn.getcwd()), allowing single files to work.
						root_dir = function(fname)
							return require("lspconfig.util").root_pattern(
								"mvnw",
								"gradlew",
								"pom.xml",
								"build.gradle",
								".git"
							)(fname) or vim.fn.getcwd()
						end,
					})
				end,
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Navigation
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				-- Actions
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

				-- Formatting (Native)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				-- Show the full diagnostic message in a floating window
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				-- Jump to previous/next warning
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})

		-- 6. Diagnostics UI
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		local function toggle_lsp()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			-- If clients are found, kill them
			if #clients > 0 then
				vim.cmd("LspStop")
				print("LSP Stopped")
			else
				-- If no clients found, start them (respecting the config we made above)
				vim.cmd("LspStart")
				print("LSP Started")
			end
		end

		-- Map <leader>tl to toggle the LSP
		vim.keymap.set("n", "<leader>tl", toggle_lsp, { desc = "[T]oggle [L]SP" })
	end,
}
