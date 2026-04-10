-- Specific formatting for Gleam
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = { "*.gleam" },
    command = "setlocal shiftwidth=2 sts=2 tabstop=2 expandtab",
})
