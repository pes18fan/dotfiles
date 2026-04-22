-- Set colorscheme and turn on transparency
---@param color string?
function Color(color)
    color = color or "catppuccin-mocha"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
end

-- The theme of all time
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            integrations = {
                blink_cmp = {
                    style = "bordered"
                },
                fidget = true,
                fzf = true,
                gitsigns = true,
                harpoon = true,
                lsp_trouble = true,
                mason = true,
            }
        })

        Color()
    end
}
