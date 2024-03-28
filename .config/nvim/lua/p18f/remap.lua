-- map <space> as the leader
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

vim.keymap.set("n", "<leader>;;", ":TroubleToggle<CR>", { desc = "Toggle trouble.nvim" })

-- move highlighted stuff around effortlessly pressing J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up" })

-- append next line at the front of current line, pressing J in normal mode
-- but, without moving the cursor to the end of the line
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append next line to front of current line" })

-- press <leader>s to start replacing the word you pressed that on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace all occurences of word under cursor" })

-- make split navigation easier
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to upper window" }) 
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to right window" })

-- remove arrow keys
vim.keymap.set("n", "<Up>", "<nop>", {noremap = true})
vim.keymap.set("n", "<Down>", "<nop>", {noremap = true})
vim.keymap.set("n", "<Left>", "<nop>", {noremap = true})
vim.keymap.set("n", "<Right>", "<nop>", {noremap = true})

vim.keymap.set("i", "<Up>", "<nop>", {noremap = true})
vim.keymap.set("i", "<Down>", "<nop>", {noremap = true})
vim.keymap.set("i", "<Left>", "<nop>", {noremap = true})
vim.keymap.set("i", "<Right>", "<nop>", {noremap = true})
