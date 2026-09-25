-- General opinionated settings

vim.loader.enable()           -- faster startup

vim.opt.nu = true             -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Make search not be case-sensitive, unless one or more capital letters are
-- in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = true
vim.opt.autoindent = true

-- Don't use word wrapping
vim.opt.wrap = false

-- Highlight search queries
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.o.breakindent = true

-- Use proper terminal colors
vim.opt.termguicolors = true

-- Never have less than 12 characters at the bottom or top
vim.opt.scrolloff = 12

vim.opt.updatetime = 250
vim.o.timeoutlen = 300

vim.opt.colorcolumn = "80"

-- Highlight the line the cursor is on
vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.winborder = "single" -- set border for floating windows

-- If performing an operation that would fail (like :q on an unsaved file),
-- instead of just failing ask if you wanna save the file first
vim.o.confirm = true

-- Highlight when yanking text, very cool
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Format on save",
    callback = function(args)
        vim.lsp.buf.format({ bufnr = args.buf })
    end,
})

-- Make stuff transparent (mostly)
local function make_transparent()
    local groups = { 'Normal', 'NormalNC', 'NormalFloat', 'SignColumn',
        'StatusLine', 'StatusLineNC' }
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
    end
end

make_transparent()
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = make_transparent,
})

-- custom filetype
vim.filetype.add({ zn = "zen" })
