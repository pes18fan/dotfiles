-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- never have less than 8 characters at the bottom
vim.opt.scrolloff = 12

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- specific formatting for crystal
vim.cmd "autocmd FileType crystal setlocal shiftwidth=2 sts=2 tabstop=2 expandtab"
