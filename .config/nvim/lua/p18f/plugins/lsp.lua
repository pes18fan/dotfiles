-- Simple LSP configuration
-- Decided to redo it after lsp-zero felt overly bloated
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { "mason-org/mason.nvim" },
        { "mason-org/mason-lspconfig.nvim" },
        {
            "j-hui/fidget.nvim",
            opts = {}
        },
        {
            "saghen/blink.cmp",

            -- TODO: This is kept for stability, remove when new version is out
            version = "1.*",
            opts = {
                keymap = {
                    preset = "default",
                    ["<C-c>"] = { "select_and_accept" }
                },

                sources = {
                    default = { "lsp", "path", "buffer" },
                },

                signature = { enabled = true },
                completion = {
                    documentation = { auto_show = true },
                },
                fuzzy = { implementation = "prefer_rust_with_warning" },
            }
        },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buf = args.buf, silent = true }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            end
        })

        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        vim.lsp.enable("gleam")

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                "clangd",
                "ts_ls",
                "ols",
            },
            automatic_enable = true
        })
    end,
}
