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
    end,
}
