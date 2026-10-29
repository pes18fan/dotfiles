-- General settings

vim.loader.enable()               -- faster startup

require("vim._core.ui2").enable() -- nicer UI

vim.opt.nu = true                 -- Line numbers
vim.opt.relativenumber = true     -- Relative line numbers

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.list = true         -- Show tabs and spaces explicitly

vim.opt.ignorecase = true -- Make search not be case-sensitive
vim.opt.smartcase = true  -- ..unless a capital letter is in search
vim.o.infercase = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false -- Don't use word wrapping

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

vim.o.switchbuf = "useopen"
vim.o.undofile = true -- Allow persistent undo

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Don't show mode in cmdline, statusline already shows it
vim.o.showmode = false

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "screen"

vim.opt.signcolumn = "yes"
vim.opt.winborder = "single" -- set border for floating windows
vim.o.pumborder = "single"   -- border for popup menu

-- If performing an operation that would fail (like :q on an unsaved file),
-- instead of just failing ask if you wanna save the file first
vim.o.confirm = true

vim.o.exrc = true -- Project-local configs

-- Some commands to interact with vim.pack easier
vim.api.nvim_create_user_command("Packupdate", function()
    vim.pack.update()
end, {})

vim.api.nvim_create_user_command("Packsee", function()
    vim.pack.update(nil, { offline = true })
end, {})

vim.api.nvim_create_user_command("Packdel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+" })

-- custom filetype for my little language
vim.filetype.add({ extension = { zn = "zen", waz = "waz" } })

-- Diagnostic opts
-- Stolen from minimax :P
local diagnostic_opts = {
    -- Show signs on top of any other sign, but only for warnings and errors
    signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

    underline = { severity = { min = 'HINT', max = 'ERROR' } },

    -- Show more details immediately for errors on the current line
    virtual_lines = false,
    virtual_text = {
        current_line = true,
        severity = { min = 'ERROR', max = 'ERROR' },
    },

    -- Don't update diagnostics when typing
    update_in_insert = false,
}

vim.schedule(function() vim.diagnostic.config(diagnostic_opts) end)

local autocmd = vim.api.nvim_create_autocmd
do
    -- Highlight when yanking text, very cool
    autocmd("TextYankPost", {
        desc = "Highlight when yanking text",
        group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
        callback = function()
            vim.hl.on_yank()
        end,
    })

    -- Format on save when a valid LSP is attached
    autocmd("BufWritePre", {
        callback = function(args)
            local clients = vim.lsp.get_clients({
                bufnr = args.buf,
                method = "textDocument/formatting",
            })

            if #clients > 0 then
                vim.lsp.buf.format({ bufnr = args.buf })
            end
        end,
    })

    -- Make everything transparent every time a colorscheme is set
    autocmd("ColorScheme", {
        callback = function()
            local groups = { 'Normal', 'NormalNC', 'NormalFloat', 'SignColumn',
                'StatusLine', 'StatusLineNC' }
            for _, group in ipairs(groups) do
                vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
            end
        end,
    })

    -- Clear the argument list when entering nvim
    autocmd("VimEnter", {
        callback = function()
            vim.cmd("argdelete *")
        end
    })
end
