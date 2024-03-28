return {
    "lewis6991/hover.nvim",
    event = "VeryLazy",
    config = function()
        require("hover").setup {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
            end,
            preview_opts = {
                border = nil
            },
            preview_window = false,
            title = true
        }

        -- Keymaps
        vim.keymap.set("n", "<A-h>", require("hover").hover, { desc = "Run hover.nvim over word under cursor" })
    end,
}
