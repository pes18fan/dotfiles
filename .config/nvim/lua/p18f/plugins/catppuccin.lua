-- Set colorscheme and turn on transparency
---@param color string
function Color(color)
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
end

-- Return a plugin setup object for lazy.nvim for a particular theme
---@param url string
---@param name string
---@param opts table
local function lazyTheme(url, name, opts)
    return {
        url,
        name = name,
        priority = 1000,
        opts = opts,
        config = function()
            Color(name)
        end
    }
end

return lazyTheme("catppuccin/nvim", "catppuccin", {
    transparent_background = true,
    integrations = {
        blink_cmp = {
            style = "bordered"
        },
        fidget = true,
        gitsigns = true,
        harpoon = true,
        mason = true
    }
})
