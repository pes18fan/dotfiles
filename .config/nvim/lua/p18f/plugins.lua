---@param name string
---@return string
local function gh(name)
    return "https://github.com/" .. name
end

-- Treesitter update hook
vim.api.nvim_create_autocmd("PackChanged", {
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
    { src = gh "catppuccin/nvim",      name = "catppuccin" },
    gh "lewis6991/gitsigns.nvim",
    gh "nvim-lua/plenary.nvim",
    { src = gh "ThePrimeagen/harpoon", version = "harpoon2" },
    gh "neovim/nvim-lspconfig",
    { src = gh "saghen/blink.cmp", version = vim.version.range("1.*") },
    gh "j-hui/fidget.nvim",
    gh "nvim-mini/mini.icons",
    gh "abeldekat/harpoonline",
    gh "nvim-lualine/lualine.nvim",
    gh "nvim-mini/mini.pick",
    gh "stevearc/oil.nvim",
    gh "nvim-treesitter/nvim-treesitter"
})

-- Catppuccin
vim.cmd("colorscheme catppuccin")

-- Oil
-- Setup mini.icons first
require("mini.icons").setup()

require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
    columns = { "icon" },
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open oil.nvim" })

-- Picker
require("mini.pick").setup()

vim.keymap.set("n", "<leader>pf", function() vim.cmd("Pick files") end)
vim.keymap.set("n", "<leader>ps", function() vim.cmd("Pick grep_live") end)

-- Setup harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
    { desc = "Add current file to harpoon" })
vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Open harpoon menu" })
vim.keymap.set("n", "<leader>c", function() harpoon:list():clear() end, { desc = "Clear harpoon list" })

for i = 1, 5, 1 do
    vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end,
        { desc = "Select file " .. i .. " from Harpoon" })
    vim.keymap.set("n", "<leader>r" .. i, function()
        harpoon:list():replace_at(i)
    end, { desc = "Replace file " .. i .. " from harpoon" })
end

-- Lualine
local harpoonline = require("harpoonline")
harpoonline.setup({
    on_update = function() require("lualine").refresh() end,
})

local lualine_c = { harpoonline.format, "filename" }
require("lualine").setup {
    sections = {
        lualine_c = lualine_c
    },
}

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        -- enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)

        -- enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

-- Completion setup
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

-- LSP setup
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buf = args.buf, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    end
})

vim.lsp.config("*", {
    capabilities = blink.get_lsp_capabilities(),
})

vim.lsp.enable({
    "clangd",
    "ols",
    "ts_ls",
    "lua_ls",
    "gopls",
    "ty",
})
