return {
    "NvChad/nvterm",
    config = function()
        require("nvterm").setup({
            terminals = {
                type_opts = {
                    horizontal = {
                        location = "rightbelow",
                        split_ratio = 0.35
                    }
                }
            }
        })

        local modes = { 'n', 't' }

        vim.keymap.set(modes, "<C-j>", function()
            require("nvterm.terminal").toggle("horizontal")
        end, {
            desc = "Toggle horizontal terminal",
            noremap = true,
            silent = true
        })

        vim.keymap.set(modes, "<C-k>", function()
            require("nvterm.terminal").toggle("float")
        end, {
            desc = "Toggle float terminal",
            noremap = true,
            silent = true
        })
    end,
}
