-- telescope : fuzzy finder
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = "0.1.5",
        -- or                            , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = "VimEnter",
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Find a string" })
        end
    },
}
