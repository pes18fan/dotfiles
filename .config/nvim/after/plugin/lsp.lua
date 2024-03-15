local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "tsserver",
        "ols",
        "html",
    },
    handlers = {
        lsp.default_setup,
    },
})
