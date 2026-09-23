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
            vim.cmd.colorscheme(name)
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
