-- Simple LSP configuration
-- Decided to redo it after lsp-zero felt overly bloated
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "j-hui/fidget.nvim" },
        { "ray-x/lsp_signature.nvim" }
    },
    lazy = false,
    config = function()
        require("fidget").setup {}
        require("lsp_signature").setup {}

        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        })

        local cmp = require("cmp")
        cmp.setup {
            mapping = cmp.mapping.preset.insert({
                ["<C-c>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }
        }

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
