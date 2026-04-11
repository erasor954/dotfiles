vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2

vim.pack.add({
	"https://github.com/iamcco/markdown-preview.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

local ok, render_md = pcall(require, "render-markdown")
if ok then
	render_md.setup({
		-- 1. Headers: Keep them simple, no heavy backgrounds
		heading = {
			sign = false, -- Removes the chunky icons from the far-left sign column
			backgrounds = {}, -- Strips away the solid background colors
			icons = { "◆ ", "◇ ", "• ", "◦ ", "▪ ", "▫ " }, -- Clean, minimal bullets instead of massive icons
		},

		-- 2. Code Blocks: Just the code, no flashy borders
		code = {
			sign = false, -- No sign column icon for code blocks
			style = "normal", -- Prevents the plugin from drawing heavy boxes around your code
		},

		-- 3. Dividers: A sleek, thin line
		dash = {
			icon = "─", -- Replaces thick blocks with a simple, thin horizontal line
			width = "full",
		},

		-- 4. Lists: Classic, understated dots
		bullet = {
			icons = { "•", "◦", "▪" },
		},

		-- 5. Checkboxes: Plain text style
		checkbox = {
			unchecked = { icon = "[ ] " },
			checked = { icon = "[x] " },
		},
	})
end

vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", {
	buffer = true,
	desc = "Preview Markdown in Browser",
})
