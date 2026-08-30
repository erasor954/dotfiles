return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "FzfLua",
    keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>",  desc = "[F]zfLua [F]iles" },
        { "<leader>fa", "<cmd>FzfLua git_files<cr>",  desc = "[F]zfLua [A]ll files in git repo" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>",  desc = "[F]zfLua [B]uffers" },
        { "<leader>fg", "<cmd>FzfLua live_grep<cr>",  desc = "[F]zfLua [G]rep" },
        { "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>",  desc = "[C]ode [A]ctions" },
    },
    opts = {
        winopts = {
            preview = {
                -- default = "bat",
                layout = "flex", 
            },
        },
    },
}
