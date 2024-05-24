-- Setup for LSP using lsp-zero
-- Honestly I have no idea how lsp works, this is just some black magic voodoo
-- that generally gets the job done
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
        { "j-hui/fidget.nvim" },
        { "ray-x/lsp_signature.nvim" }
    },
    config = function()
        local lspconfig = require("lspconfig")
        local lsp = require("lsp-zero")
        local cmp = require("cmp")

        lsp.on_attach(function(_, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
        end)

        require("fidget").setup {}
        require("lsp_signature").setup {}
        require("mason").setup {}
        require("mason-lspconfig").setup {
            ensure_installed = {
                "clangd",
                "tsserver",
                "ols",
                "html",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            },
        }

        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Suppress annoying "undefined global `vim`" warning
                        globals = { "vim" }
                    }
                }
            }
        }

        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = { "E203", "E701" },
                            maxLineLength = 88
                        }
                    }
                }
            }
        }
        lspconfig.clangd.setup {}
        lspconfig.dartls.setup {}

        cmp.setup {
            mapping = cmp.mapping.preset.insert({
                ["<C-c>"] = cmp.mapping.confirm({ select = true }),
            })
        }
    end,
}
