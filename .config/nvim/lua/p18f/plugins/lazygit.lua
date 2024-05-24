-- Helper to launch lazygit within neovim
-- Might be able to do this without a plugin
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
