return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            },
        })

        vim.keymap.set("n", "<leader>pv", ":Oil<CR>", { desc = "Open oil.nvim" })
    end,
}
