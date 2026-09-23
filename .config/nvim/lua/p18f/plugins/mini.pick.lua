return {
    "nvim-mini/mini.pick",
    event = "VeryLazy",
    config = function()
        require("mini.pick").setup()

        vim.keymap.set("n", "<leader>pf", function() vim.cmd("Pick files") end)
        vim.keymap.set("n", "<leader>ps", function() vim.cmd("Pick grep_live") end)
    end
}
