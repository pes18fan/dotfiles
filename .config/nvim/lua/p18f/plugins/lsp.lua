-- Simple LSP and autocomplete configuration
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = {
                    "clangd",
                    "ts_ls",
                    "ols",
                }
            }
        },
        { "j-hui/fidget.nvim",    opts = {} },
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
            },
        },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buf = args.buf, silent = true }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            end
        })

        vim.lsp.enable("racket-langserver")
    end,
}
