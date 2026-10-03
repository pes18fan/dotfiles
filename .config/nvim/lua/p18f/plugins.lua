-- Plugin setup

-- Convenience wrapper to work with short repo names
---@param name string
---@return string
local function gh(name)
    return "https://github.com/" .. name
end

-- Shortnames
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- Update treesitter parsers when nvim-treesitter updates
autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end
})

-- All packages
vim.pack.add({
    { src = gh "catppuccin/nvim",      name = "catppuccin" },            -- Cute theme :D
    gh "lewis6991/gitsigns.nvim",                                        -- Git info in editor, staging hunks
    gh "nvim-lua/plenary.nvim",                                          -- Harpoon dependency
    { src = gh "ThePrimeagen/harpoon", version = "harpoon2" },           -- Quick switching between buffers
    gh "neovim/nvim-lspconfig",                                          -- LSP config defaults
    { src = gh "saghen/blink.cmp", version = vim.version.range("1.*") }, -- Autocomplete
    gh "j-hui/fidget.nvim",                                              -- Little eye candy for notifications :)
    gh "nvim-mini/mini.icons",                                           -- Icon pack
    gh "nvim-lualine/lualine.nvim",                                      -- Statusline
    gh "nvim-mini/mini.pick",                                            -- Fuzzy finder
    gh "stevearc/oil.nvim",                                              -- File explorer
    gh "nvim-treesitter/nvim-treesitter"                                 -- Overengineered syntax highlighting
})

-- Catppuccin, the goated theme
vim.cmd("colorscheme catppuccin")

-- Oil, the better netrw
-- Setup mini.icons first
do
    require("mini.icons").setup()

    require("oil").setup({
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
        columns = { "icon" },
    })

    map("n", "-", "<cmd>Oil<CR>", { desc = "Open oil.nvim" })
end

-- Fuzzy file/text/whatever picker
do
    require("mini.pick").setup()

    map("n", "<leader>pf", function() vim.cmd("Pick files") end)
    map("n", "<leader>ps", function() vim.cmd("Pick grep_live") end)
end

-- Harpoon, the plugin of all time
do
    local harpoon = require("harpoon")
    harpoon:setup()

    map("n", "<leader>a", function() harpoon:list():add() end,
        { desc = "Add current file to harpoon" })
    map("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Open harpoon menu" })
    map("n", "<leader>c", function() harpoon:list():clear() end, { desc = "Clear harpoon list" })

    for i = 1, 5, 1 do
        map("n", "<leader>" .. i, function() harpoon:list():select(i) end,
            { desc = "Select file " .. i .. " from Harpoon" })
        map("n", "<leader>r" .. i, function()
            harpoon:list():replace_at(i)
        end, { desc = "Replace file " .. i .. " from harpoon" })
    end
end

-- Lualine, simple statusline
require("lualine").setup()

-- Treesitter
autocmd("FileType", {
    callback = function(args)
        -- enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start, args.buf)

        -- enable treesitter-based indentation
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

-- Language intelligence stuff
do
    -- eye candy!
    require("fidget").setup()

    -- Completion
    local blink = require("blink.cmp")
    blink.setup({
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
    })

    vim.lsp.config("*", {
        capabilities = blink.get_lsp_capabilities(),
    })

    autocmd("LspAttach", {
        callback = function(args)
            local opts = { buf = args.buf, silent = true }

            map("n", "gd", vim.lsp.buf.definition, opts)
            map("n", "gD", vim.lsp.buf.declaration, opts)
            map("n", "<leader>f", vim.lsp.buf.format, opts)
        end
    })

    -- Default lsp setup
    vim.lsp.enable({
        "clangd",  -- C, C++
        "ols",     -- Odin
        "ts_ls",   -- Typescript, Javascript
        "lua_ls",  -- Lua
        "gopls",   -- Go
        "ty",      -- Python
        "ocamllsp" -- OCaml
    })
end
