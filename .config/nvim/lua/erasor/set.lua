-- Syntax highlighting
vim.cmd("syntax on")

-- Filetype detection and indentation
vim.cmd("filetype on")
vim.cmd("filetype plugin indent on")

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = 80

-- Indentation
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
