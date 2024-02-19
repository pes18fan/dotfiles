vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>;;", ":TroubleToggle<CR>")

-- move highlighted stuff around effortlessly pressing J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append next line at the front of current line, pressing J in normal mode
-- but, without moving the cursor to the end of the line
vim.keymap.set("n", "J", "mzJ`z")

-- press <leader>s to start replacing the word you pressed that on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<Up>", "<nop>", {noremap = true})
vim.keymap.set("n", "<Down>", "<nop>", {noremap = true})
vim.keymap.set("n", "<Left>", "<nop>", {noremap = true})
vim.keymap.set("n", "<Right>", "<nop>", {noremap = true})

vim.keymap.set("i", "<Up>", "<nop>", {noremap = true})
vim.keymap.set("i", "<Down>", "<nop>", {noremap = true})
vim.keymap.set("i", "<Left>", "<nop>", {noremap = true})
vim.keymap.set("i", "<Right>", "<nop>", {noremap = true})
