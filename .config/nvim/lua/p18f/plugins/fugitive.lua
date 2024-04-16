return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
        { "<leader>gg", "<cmd>G<cr>",           desc = "Git: base command" },
        { "<leader>gP", "<cmd>G push<cr>",      desc = "Git: push" },
        { "<leader>gp", "<cmd>G pull<cr>",      desc = "Git: pull" },
        { "<leader>gd", "<cmd>G diff HEAD<cr>", desc = "Git: compare changes to HEAD" },
    }
}
