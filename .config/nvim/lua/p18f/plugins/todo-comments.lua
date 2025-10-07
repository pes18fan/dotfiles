-- Highlight comments starting with the words listed below + a colon
-- Can also access them from trouble.nvim
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

        vim.keymap.set("n", "<leader>;t", "<cmd>Trouble todo toggle focus=true<CR>", { desc = "Open todos in trouble" })
    end,
}
