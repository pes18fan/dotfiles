return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
    },
    config = function()
        require("oil").setup()

        vim.keymap.set("n", "<leader>pv", ":Oil<CR>", { desc = "Open oil.nvim" })
    end,
}
