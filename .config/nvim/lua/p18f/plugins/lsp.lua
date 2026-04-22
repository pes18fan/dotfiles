-- Simple LSP configuration
-- Decided to redo it after lsp-zero felt overly bloated
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { "mason-org/mason.nvim" },
        { "mason-org/mason-lspconfig.nvim" },
        { "j-hui/fidget.nvim" },
        {
            "saghen/blink.cmp",

            -- TODO: This is kept for stability, remove when new version is out
            version = "1.*" 
        }
    },
    lazy = false,
    config = function()
        require("fidget").setup {}

        local function on_attach(client, bufnr)
            local opts = { noremap = true, silent = true }

            vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        end

        local cmp = require("blink.cmp")
        cmp.setup {
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

        vim.lsp.config("*", {
            capabilities = cmp.get_lsp_capabilities(),
            on_attach = on_attach
        })

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
