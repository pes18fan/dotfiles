-- Tell neovim the correct filetype for astro
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = { "*.astro" },
    command = "set filetype=astro",
})
