return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "abeldekat/harpoonline",
    },
    config = function()
        local harpoonline = require("harpoonline")
        harpoonline.setup({
            on_update = function() require("lualine").refresh() end,
        })

        local lualine_c = { harpoonline.format, "filename" }
        require("lualine").setup {
            sections = {
                lualine_c = lualine_c
            },
            options = {
                theme = "catppuccin"
            }
        }
    end,
}
