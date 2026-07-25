-- Set colorscheme and turn on transparency
---@param color string
function Color(color)
    color = color
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
end

-- Return a plugin setup object for lazy.nvim for a particular theme
---@param url string
---@param name string
---@param config_fn function?
local function lazyTheme(url, name, config_fn)
    return {
        url,
        name = name,
        priority = 1000,
        config = function()
            if config_fn ~= nil then
                config_fn()
            end
            Color(name)
        end
    }
end

return lazyTheme("catppuccin/nvim", "catppuccin", function()
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
end)
