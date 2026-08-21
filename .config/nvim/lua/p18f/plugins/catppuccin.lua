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
            vim.cmd.colorscheme(name)
        end
    }
end

return lazyTheme("rebelot/kanagawa.nvim", "kanagawa", function()
    require("kanagawa").setup({
        transparent = true,
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none"
                    }
                }
            }
        },
        overrides = function(colors)
            local theme = colors.theme
            return {
                NormalFloat = { bg = "none" },
                FloatBorder = { bg = "none" },
                FloatTitle = { bg = "none" },

                -- Save an hlgroup with dark background and dimmed foreground
                -- so that you can use it where your still want darker windows.
                -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                -- Popular plugins that open floats will link to NormalFloat by default;
                -- set their background accordingly if you wish to keep them dark and borderless
                LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            }
        end,
    })
end)
