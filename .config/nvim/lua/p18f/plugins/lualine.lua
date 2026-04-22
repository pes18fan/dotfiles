-- Simple statusline
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-mini/mini.icons",
        "abeldekat/harpoonline", -- Show info for harpoon
    },
    event = "VeryLazy",
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
        }
    end,
}
