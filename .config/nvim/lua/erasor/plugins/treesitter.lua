vim.pack.add({gh("nvim-treesitter/nvim-treesitter")})

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    ensure_installed = {
        "lua", "vim", "java", "javascript", "html", "css", "python", "c", "bash"
    },
    
    auto_install = true,
    
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})
