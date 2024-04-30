return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    event = "VimEnter",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
            { desc = "Add current file to harpoon" })
        vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Open harpoon menu" })
        vim.keymap.set("n", "<leader>c", function() harpoon:list():clear() end, { desc = "Clear harpoon list" })

        for i = 1, 5, 1 do
            vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end,
                { desc = "Select file " .. i .. " from Harpoon" })
        end

        for i = 1, 5, 1 do
            vim.keymap.set("n", "<leader>r" .. i, function()
                harpoon:list():replace_at(i)
            end, { desc = "Replace file " .. i .. " from harpoon" })
        end
    end,
}
