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

        local toggle_modes = { 'n', 't' }

        local mappings = {
            { toggle_modes, "<C-j>", function()
                require("nvterm.terminal").toggle("horizontal")
            end, { desc = "Toggle horizontal terminal" } },
            { toggle_modes, "<C-k>", function()
                require("nvterm.terminal").toggle("float")
            end, { desc = "Toggle float terminal" } }
        }

        local opts = {
            noremap = true,
            silent = true,
        }

        for _, mapping in ipairs(mappings) do
            vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
        end
    end,
}
