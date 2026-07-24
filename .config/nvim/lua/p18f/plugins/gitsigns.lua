-- Show little signs for changes tracked by git beside the line numbers
return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({})
    end,
}
