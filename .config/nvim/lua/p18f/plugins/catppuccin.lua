return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            integrations = {
                telescope = true
            }
        })
    end,
}
