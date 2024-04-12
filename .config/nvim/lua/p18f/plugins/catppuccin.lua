return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        transparent_background = true,
        dim_inactive = {
            enabled = true,
            shade = "dark",
            percentage = 0.2,
        },
        integrations = {
            telescope = {
                enabled = true,
            },
            which_key = true,
            mason = true,
            harpoon = true,
        }
    },
}
