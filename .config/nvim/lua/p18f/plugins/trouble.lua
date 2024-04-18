-- TODO: Update to trouble v3
return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
        require("trouble").setup({
            auto_close = true,
            icons = false,
            cycle_results = true,
            group = true,
            indent_lines = true,
        })

        vim.keymap.set("n", "<leader>;;", ":TroubleToggle<CR>", { desc = "Toggle trouble.nvim" })
        vim.keymap.set("n", "<leader>;w", ":TroubleToggle workspace_diagnostics<CR>",
            { desc = "Toggle trouble.nvim workspace diagnostics" })
    end,
}
