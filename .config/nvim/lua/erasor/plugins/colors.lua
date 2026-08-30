return {
    { "erikbackman/brightburn.vim", lazy = true },
    { "slugbyte/lackluster.nvim", lazy = true },
    { "aktersnurra/no-clown-fiesta.nvim", lazy = true },
    { "ayu-theme/ayu-vim", lazy = true },

    {
        "oskarnurm/koda.nvim",
        lazy = true,
        opts = {
            styles = {
                functions = { bold = false },
                comments = { italic = true },
            },
            colors = {
                bg = "#131313",
                func = "#9CBFE7",
                string = "#98bb6c",
            },
        },
    },

    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        opts = {
            terminal_colors = true,
            undercurl = true,
            underline = false,
            bold = true,
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,
            contrast = "",
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        },
    },

    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "storm",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
                sidebars = "dark",
                floats = "dark",
            },
        },
    },

    {
        "rose-pine/neovim",
        lazy = true,
        name = "rose-pine",
        opts = {
            disable_background = true,
            styles = {
                italic = false,
            },
        },
    },

    {
        "olimorris/onedarkpro.nvim",
        lazy = true,
        config = true,
    },

    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            flavour = "mocha",
            transparent_background = true,
            integrations = { telescope = true, treesitter = true },
        },
    },

    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function ()
            require("kanagawa").setup({})
            vim.cmd("colorscheme kanagawa-dragon")
        end,
    },

    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        opts = {
            palettes = {
                carbonfox = {
                    red = "#c47a95",
                    green = "#78a280",
                    blue = "#7398b5",
                    yellow = "#bba377",
                    magenta = "#a37fa4",
                    cyan = "#72a1a1",
                    orange = "#bd846b",
                },
            },
        },
    },
}
