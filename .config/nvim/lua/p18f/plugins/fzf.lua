-- fzf-lua: fuzzy finder.
-- replaces telescope.nvim
return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons" },
    event = "VeryLazy",
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({
            winopts = {
                preview = { default = "bat" },
            },
            files = {
                hidden = true,
            },
        })

        vim.keymap.set("n", "<leader>pf", fzf.files,      { desc = "Find files"})
        vim.keymap.set("n", "<leader>ps", fzf.live_grep,  { desc = "Find a string"})
    end
}
