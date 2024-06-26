-- map <space> as the leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- move highlighted stuff around effortlessly pressing J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up" })

-- Append next line at the front of current line, pressing J in normal mode
-- but, without moving the cursor to the end of the line
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append next line to front of current line" })

-- Press <leader>s to start replacing the word you pressed that on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace all occurences of word under cursor" })

-- Split easily
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>", { desc = "Split vertically" })

-- Tabs, I generally don't use these for much other than terminal instances
vim.keymap.set("n", "<leader>n", ":tabnew<CR>", { desc = "Create a new tab" })
vim.keymap.set("n", "<leader>]", "gt", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>[", "gT", { desc = "Go to previous tab" })

-- Remove arrow keys
vim.keymap.set("n", "<Up>", "<nop>", { noremap = true })
vim.keymap.set("n", "<Down>", "<nop>", { noremap = true })
vim.keymap.set("n", "<Left>", "<nop>", { noremap = true })
vim.keymap.set("n", "<Right>", "<nop>", { noremap = true })

vim.keymap.set("i", "<Up>", "<nop>", { noremap = true })
vim.keymap.set("i", "<Down>", "<nop>", { noremap = true })
vim.keymap.set("i", "<Left>", "<nop>", { noremap = true })
vim.keymap.set("i", "<Right>", "<nop>", { noremap = true })

-- Double esc to go to normal mode from terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
