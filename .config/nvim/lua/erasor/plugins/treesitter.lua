-- Add the lightweight manager
vim.pack.add({ gh("romus204/tree-sitter-manager.nvim") })

require("tree-sitter-manager").setup({
    -- This will automatically download queries (the "highlighter" rules)
    -- for languages that Neovim doesn't bundle yet
})
-- Add this to your config to auto-start Treesitter highlighting
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "java", "lua", "python" }, -- Add your languages here
--     callback = function(args)
--         local bufnr = args.buf
--         -- Check if a parser is available for the language
--         if vim.treesitter.query.get(vim.bo[bufnr].filetype, "highlights") then
--             vim.treesitter.start(bufnr)
--         end
--     end,
-- })
