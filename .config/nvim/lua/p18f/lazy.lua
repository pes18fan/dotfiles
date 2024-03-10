-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    -- telescope : fuzzy finder
    {
        'nvim-telescope/telescope.nvim', tag = "0.1.5",
        -- or                            , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = "BufReadPre",
    },

    {
        "jiangmiao/auto-pairs",
        lazy = true,
    },

    -- status bar
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- lsp
    {   
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    },

    -- catppuccin theme
    { "catppuccin/nvim", name = "catppuccin" },

    "lewis6991/hover.nvim",
    "folke/trouble.nvim",
    "NvChad/nvterm",

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
    },
})
