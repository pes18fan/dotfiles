-- Cool UI to view a list of warnings, errors etc, similar to errors view in
-- VSCode
-- Can integrate with todo-comments.nvim to list out all todos and stuff in
-- the project
-- TODO: Bruh
return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    opts = {
        auto_close = true,
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>;;",
            "<cmd>Trouble diagnostics toggle focus=true<CR>",
            desc = "Diagnostics (Trouble)",
        },
    }
}
