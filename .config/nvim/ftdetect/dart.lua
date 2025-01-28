-- Specific formatting for Dart
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = { "*.dart" },
    command = "setlocal shiftwidth=2 sts=2 tabstop=2 expandtab",
})
