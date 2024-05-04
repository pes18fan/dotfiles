return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                ---@param mode string
                ---@param binding string
                ---@param callback function
                ---@param opts? table
                local function map(mode, binding, callback, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, binding, callback, opts)
                end

                -- navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, { desc = "Next git hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, { desc = "Previous git hunk" })
            end,
        })
    end,
}
