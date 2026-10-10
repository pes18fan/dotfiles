-- General-purpose keymaps

-- map <space> as the leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- move highlighted stuff around effortlessly pressing J and K
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up" })

-- Append next line at the front of current line. Pressing J in normal mode
-- already does so, but this one does it without moving the cursor to the end
-- of the line
map("n", "J", "mzJ`z",
    { desc = "Append next line to front of current line without moving cursor" })

-- Press <leader>s to start replacing the word you pressed that on
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace all occurences of word under cursor" })

-- Split easily
map("n", "<leader>-", ":split<CR>", { desc = "Split horizontally" })
map("n", "<leader>\\", ":vsplit<CR>", { desc = "Split vertically" })

-- Double esc to go to normal mode from terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Reselect after indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Work with system clipboard
map("v", "<leader>y", [["+y]], { desc = "Yank to system clipboard (register \"+)" })
map("n", "<leader>p", [["+p]], { desc = "Put from system clipboard (register \"+)" })

-- Remove arrow keys
-- Not really 'remaps' but more like 'unremaps'
map("n", "<Up>", "<nop>")
map("n", "<Down>", "<nop>")
map("n", "<Left>", "<nop>")
map("n", "<Right>", "<nop>")

map("i", "<Up>", "<nop>")
map("i", "<Down>", "<nop>")
map("i", "<Left>", "<nop>")
map("i", "<Right>", "<nop>")

-- Quickfix list mappings
map("n", "<leader>q", function()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end, { desc = "Toggle quickfix list" })
map("n", "<leader>.", "<cmd>cnext<CR>", { desc = "Go to next item in quickfix list" })
map("n", "<leader>,", "<cmd>cprev<CR>", { desc = "Go to previous item in quickfix list" })

-- Location list mappings
map("n", "<leader>;", function()
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
end, { desc = "Toggle location list" })
map("n", "<leader>]", "<cmd>lnext<CR>", { desc = "Go to next item in location list" })
map("n", "<leader>[", "<cmd>lprev<CR>", { desc = "Go to previous item in location list" })
