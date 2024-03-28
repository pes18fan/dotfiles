return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    event = "VimEnter",
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add current file to Harpoon" })
        vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Open Harpoon menu" })
        vim.keymap.set("n", "<leader>c", function() harpoon:list():clear() end, { desc = "Clear Harpoon" })

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,
            { desc = "Select first file from Harpoon" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,
            { desc = "Select second file from Harpoon" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,
            { desc = "Select third file from Harpoon" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,
            { desc = "Select fourth file from Harpoon" })
    end,
}
