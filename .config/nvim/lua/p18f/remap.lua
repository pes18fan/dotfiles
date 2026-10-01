-- General-purpose keymaps

-- map <space> as the leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Format
map("n", "<leader>f", vim.lsp.buf.format,
    { desc = "Format current buffer" })

-- move highlighted stuff around effortlessly pressing J and K
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up" })

-- Append next line at the front of current line, pressing J in normal mode
-- but, without moving the cursor to the end of the line
map("n", "J", "mzJ`z", { desc = "Append next line to front of current line" })

-- Press <leader>s to start replacing the word you pressed that on
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace all occurences of word under cursor" })

-- Split easily
map("n", "<leader>-", ":split<CR>", { desc = "Split horizontally" })
map("n", "<leader>\\", ":vsplit<CR>", { desc = "Split vertically" })

-- Tabs, I generally don't use these for much other than terminal instances
map("n", "<leader>n", ":tabnew<CR>", { desc = "Create a new tab" })

-- Double esc to go to normal mode from terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Reselect after indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

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
