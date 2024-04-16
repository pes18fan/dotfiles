return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
    },
    config = function()
        local lsp = require("lsp-zero")
        local cmp = require("cmp")

        lsp.on_attach(function(_, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
        end)

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-c>"] = cmp.mapping.confirm({ select = true }),
            })
        })

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

        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        -- Suppress annoying "undefined global `vim`" warning
                        globals = { "vim" }
                    }
                }
            }
        })
    end,
}
