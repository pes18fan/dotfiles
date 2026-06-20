vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = { "*.zn" },
    command = "set filetype=zen",
})
