--[[
    Keywords recognized as todo comments include:
        - FIX
        - TODO
        - HACK
        - WARN
        - PERF
        - NOTE
        - TEST
--]]
return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
    },
    config = function()
        require("todo-comments").setup()

        vim.keymap.set("n", "<leader>;t", "<cmd>TodoTrouble<CR>", { desc = "Open todos in trouble" })
    end,
}
