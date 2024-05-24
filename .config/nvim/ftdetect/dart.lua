-- Couldn't get dartls to start automatically so here's a little hack
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = { "*.dart" },
    command = "LspStart dartls",
})
