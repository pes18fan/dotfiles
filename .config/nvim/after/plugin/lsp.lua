local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"clangd",
	"tsserver",
	"rust_analyzer",
})

lsp.setup()

require("lspconfig").ols.setup({})
