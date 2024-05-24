-- Code completion service similar to GitHub Copilot
return {
    'Exafunction/codeium.vim',
    event = "VimEnter",
    config = function()
        vim.g.codeium_no_map_tab = 1

        vim.keymap.set("i", "<C-l>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
    end,
}
