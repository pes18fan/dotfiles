-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 250

-- never have less than 12 characters at the bottom or top
vim.opt.scrolloff = 12

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- show the line the cursor is on
vim.opt.cursorline = true

vim.opt.signcolumn = "yes"

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.cmd.colorscheme "catppuccin-mocha"

-- specific formatting for crystal
vim.cmd "autocmd FileType crystal setlocal shiftwidth=2 sts=2 tabstop=2 expandtab"
