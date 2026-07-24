-- Keybindings and other setup for the quickfix and location list

-- Open the quickfix list if it is closed, else close it.
local function toggle_qflist()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end

-- Open the location list if it is closed, else close it.
-- If the location list is empty, print a message saying so and return.
local function toggle_loclist()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.loclist == 1 then
            vim.cmd.lclose()
            return
        end
    end

    local ll = vim.fn.getloclist(0)
    if vim.tbl_isempty(ll) then
        vim.api.nvim_echo({
            { "Location list empty.", "MoreMsg" },
        }, false, {})
        return
    end

    vim.cmd.lopen()
end

-- Put diagnostics automatically in the location list
vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        vim.diagnostic.setloclist({ open = false })
    end,
})

-- Quickfix list mappings
vim.keymap.set("n", "<leader>q", toggle_qflist, { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>.", "<cmd>cnext<CR>", { desc = "Go to next item in quickfix list" })
vim.keymap.set("n", "<leader>,", "<cmd>cprev<CR>", { desc = "Go to previous item in quickfix list" })

-- Location list mappings
vim.keymap.set("n", "<leader>;", toggle_loclist, { desc = "Open location list" })
vim.keymap.set("n", "<leader>]", "<cmd>lnext<CR>", { desc = "Go to next item in location list" })
vim.keymap.set("n", "<leader>[", "<cmd>lprev<CR>", { desc = "Go to previous item in location list" })
