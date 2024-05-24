vim.opt.nu = true             -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Make search not be case-sensitive
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.smartindent = true
vim.opt.autoindent = true

-- Don't use word wrapping
vim.opt.wrap = false

-- Highlight search queries
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Use proper terminal colors
vim.opt.termguicolors = true

vim.opt.updatetime = 250

-- Never have less than 12 characters at the bottom or top
vim.opt.scrolloff = 12

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Highlight the line the cursor is on
vim.opt.cursorline = true

vim.opt.signcolumn = "yes"

-- Highlight when yanking text, very cool
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
