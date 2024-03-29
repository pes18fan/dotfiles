return {
    "NvChad/nvterm",
    config = function()
        require("nvterm").setup()

        local toggle_modes = { 'n', 't' }

        local mappings = {
            { toggle_modes, "<A-j>", function()
                require("nvterm.terminal").toggle("horizontal")
            end },
            { toggle_modes, "<A-k>", function()
                require("nvterm.terminal").toggle("float")
            end }
        }

        local opts = {
            noremap = true,
            silent = true
        }

        for _, mapping in ipairs(mappings) do
            vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
        end
    end,
}
