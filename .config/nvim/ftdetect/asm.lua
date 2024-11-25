-- Disable indentation for assembly
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = { "*.asm" },
    callback = function(args)
        vim.o.indentexpr = ""
    end,
})
