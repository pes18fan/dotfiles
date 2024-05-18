vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = { "*.dart" },
    command = "LspStart dartls",
})
