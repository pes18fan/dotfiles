local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    -- telescope : fuzzy finder
    {
        'nvim-telescope/telescope.nvim', tag = "0.1.5",
        -- or                            , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = "VeryLazy"
    },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = "BufReadPre",
    },

    "vim-crystal/vim-crystal",

    "jiangmiao/auto-pairs",

    -- status bar
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy"
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

    {
        "lewis6991/hover.nvim",
        event = "VeryLazy",
    },

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
    },

    {
        "NvChad/nvterm",
        event = "VeryLazy",
    },

    {
        'Exafunction/codeium.vim',
        config = function()
            vim.g.codeium_no_map_tab = 1

            vim.keymap.set('i', '<M-l>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        end
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    "mattn/emmet-vim",
})
