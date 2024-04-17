return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    }
}
