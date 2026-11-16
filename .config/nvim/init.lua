----------------------------
--*-* My neovim config *-*--
----------------------------

-- Some aliases --
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

----------------------
-- General settings --
----------------------
do
    vim.loader.enable()               -- faster startup
    require("vim._core.ui2").enable() -- nicer UI

    -- Line numbers
    vim.o.nu = true             -- Enable line numbers
    vim.o.relativenumber = true -- Relative line numbers

    -- Indenting
    vim.o.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true  -- Turn tabs into spaces?
    vim.o.list = true       -- Show tabs and spaces explicitly

    vim.o.ignorecase = true -- Make search not be case-sensitive
    vim.o.smartcase = true  -- ..unless a capital letter is in search
    vim.o.infercase = true

    vim.o.smartindent = true
    vim.o.autoindent = true

    vim.o.wrap = false -- Don't use word wrapping

    -- Highlight search queries
    vim.o.hlsearch = false
    vim.o.incsearch = true

    vim.o.breakindent = true

    -- Use proper terminal colors
    vim.o.termguicolors = true

    -- Never have less than 12 characters at the bottom or top
    vim.o.scrolloff = 12

    vim.o.updatetime = 250
    vim.o.timeoutlen = 300

    vim.o.colorcolumn = "80"

    vim.o.switchbuf = "useopen"
    vim.o.undofile = true -- Allow persistent undo

    -- Highlight the line the cursor is on
    vim.o.cursorline = true

    -- Don't show mode in cmdline, statusline already shows it
    vim.o.showmode = false

    vim.o.splitbelow = true -- Splitting puts the window below
    vim.o.splitright = true -- Vsplit puts the window to the right
    vim.o.splitkeep = "screen"

    vim.o.signcolumn = "yes"
    vim.o.winborder = "single" -- set border for floating windows
    vim.o.pumborder = "single" -- border for popup menu

    -- If performing an operation that would fail (like :q on an unsaved file),
    -- instead of just failing ask if you wanna save the file first
    vim.o.confirm = true

    vim.o.exrc = true -- Project-local configs

    -- Some commands to interact with vim.pack easier
    -- TODO: remove when neovim 0.13 comes out, it has these natively
    command("Packupdate", function() vim.pack.update() end, {})
    command("Packsee", function()
        vim.pack.update(nil, { offline = true })
    end, {})
    command("Packdel", function(opts)
        vim.pack.del(opts.fargs)
    end, { nargs = "+" })

    -- custom filetype for my little language
    vim.filetype.add({ extension = { zn = "zen" } })

    -- Diagnostic opts
    -- Stolen from minimax :P
    local diagnostic_opts = {
        -- Show signs on top of any other sign, but only for warnings and errors
        signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

        underline = { severity = { min = 'HINT', max = 'ERROR' } },

        -- Show more details immediately for errors on the current line
        virtual_lines = false,
        virtual_text = {
            current_line = true,
            severity = { min = 'ERROR', max = 'ERROR' },
        },

        -- Don't update diagnostics when typing
        update_in_insert = false,
    }
    vim.schedule(function() vim.diagnostic.config(diagnostic_opts) end)

    --- Common autocmds ---
    do
        -- Highlight when yanking text, very cool
        autocmd("TextYankPost", {
            desc = "Highlight when yanking text",
            group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
            callback = function()
                vim.hl.on_yank()
            end,
        })

        -- Format on save when a LSP that supports formatting is attached
        autocmd("BufWritePre", {
            callback = function(args)
                local clients = vim.lsp.get_clients({
                    bufnr = args.buf,
                    method = "textDocument/formatting",
                })

                if #clients > 0 then
                    vim.lsp.buf.format({ bufnr = args.buf })
                end
            end,
        })

        -- Make everything transparent every time a colorscheme is set
        autocmd("ColorScheme", {
            callback = function()
                local groups = { 'Normal', 'NormalNC', 'NormalFloat', 'SignColumn',
                    'StatusLine', 'StatusLineNC' }
                for _, group in ipairs(groups) do
                    vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
                end
            end,
        })

        -- LSP specific binds
        autocmd("LspAttach", {
            callback = function(args)
                local opts = { buf = args.buf, silent = true }

                map("n", "gd", vim.lsp.buf.definition, opts)
                map("n", "gD", vim.lsp.buf.declaration, opts)
            end
        })

        -- Never expand tabs for Odin
        autocmd("FileType", {
            pattern = "odin",
            callback = function()
                vim.opt_local.expandtab = false
            end,
        })
    end

    -- Lsps!
    vim.lsp.enable({
        "clangd",   -- C, C++
        "ols",      -- Odin
        "ts_ls",    -- Typescript, Javascript
        "lua_ls",   -- Lua
        "gopls",    -- Go
        "ty",       -- Python
        "ocamllsp", -- OCaml
        "zls",      -- Zig
    })
end

---------------------
-- General keymaps --
---------------------
do
    -- map <space> as the leader
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- move highlighted stuff around effortlessly pressing J and K
    map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down" })
    map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up" })

    -- Append next line at the front of current line. Pressing J in normal mode
    -- already does so, but this one does it without moving the cursor to the end
    -- of the line
    map("n", "J", "mzJ`z",
        { desc = "Append next line to front of current line without moving cursor" })

    -- Press <leader>s to start replacing the word you pressed that on
    map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        { desc = "Replace all occurences of word under cursor" })

    -- Split easily
    map("n", "<leader>-", ":split<CR>", { desc = "Split horizontally" })
    map("n", "<leader>\\", ":vsplit<CR>", { desc = "Split vertically" })

    map("i", "<C-[>", "<Esc>")

    -- Double esc to go to normal mode from terminal
    map("t", "<Esc><Esc>", "<C-\\><C-n>")

    -- Reselect after indenting
    map("v", "<", "<gv", { desc = "Indent left and reselect" })
    map("v", ">", ">gv", { desc = "Indent right and reselect" })

    -- Work with system clipboard
    map("v", "<leader>y", [["+y]], { desc = "Yank to system clipboard (register \"+)" })
    map("n", "<leader>p", [["+p]], { desc = "Put from system clipboard (register \"+)" })

    -- Remove arrow keys
    -- Not really 'remaps' but more like 'unremaps'
    map("n", "<Up>", "<nop>")
    map("n", "<Down>", "<nop>")
    map("n", "<Left>", "<nop>")
    map("n", "<Right>", "<nop>")

    map("i", "<Up>", "<nop>")
    map("i", "<Down>", "<nop>")
    map("i", "<Left>", "<nop>")
    map("i", "<Right>", "<nop>")

    -- Quickfix and location list mappings
    map("n", "<leader>q", function()
        for _, win in ipairs(vim.fn.getwininfo()) do
            if win.quickfix == 1 then
                vim.cmd.cclose()
                return
            end
        end
        vim.cmd.copen()
    end, { desc = "Toggle quickfix list" })
    map("n", "<leader>;", function()
        for _, win in ipairs(vim.fn.getwininfo()) do
            if win.loclist == 1 then
                vim.cmd.lclose()
                return
            end
        end
        vim.diagnostic.setloclist()
    end, { desc = "Toggle location list, placing diagnostics in it if opening it" })
end


-------------------------------------
-- Terminal process spawner thingy --
-------------------------------------
do
    -- Create a function to run a command in a toggleable floating/bottom terminal
    ---@param cmd string
    ---@param opts? { floating?: boolean }
    local function new_runner(cmd, opts)
        local state = { buf = -1, win = -1 }
        opts = opts or {}

        return function()
            if not vim.api.nvim_win_is_valid(state.win) then
                if not vim.api.nvim_buf_is_valid(state.buf) then
                    state.buf = vim.api.nvim_create_buf(false, true)
                end

                if opts.floating then
                    local width = math.floor(vim.o.columns * 0.8)
                    local height = math.floor(vim.o.lines * 0.8)

                    state.win = vim.api.nvim_open_win(state.buf, true, {
                        relative = "editor",
                        width = width,
                        height = height,
                        row = math.floor((vim.o.lines - height) / 2),
                        col = math.floor((vim.o.columns - width) / 2),
                        style = "minimal",
                        border = "single",
                    })
                else
                    vim.cmd("botright sbuf " .. state.buf)
                    state.win = vim.api.nvim_get_current_win()
                    vim.api.nvim_win_set_height(state.win, 15)
                end

                -- Start terminal if not already running in buffer
                if vim.bo[state.buf].buftype ~= "terminal" then
                    vim.fn.jobstart(cmd, {
                        term = true,
                        on_exit = function()
                            if vim.api.nvim_win_is_valid(state.win) then
                                vim.api.nvim_win_close(state.win, true)
                            end
                            if vim.api.nvim_buf_is_valid(state.buf) then
                                vim.api.nvim_buf_delete(state.buf, { force = true })
                            end
                        end
                    })
                end

                vim.cmd("startinsert")
            else
                vim.api.nvim_win_hide(state.win)
            end
        end
    end

    local boterminal = new_runner(vim.o.shell, { floating = false })
    local floaterminal = new_runner(vim.o.shell, { floating = true })
    local lazygit = new_runner("lazygit", { floating = true })

    map({ "n", "t" }, "<C-j>", boterminal, { desc = "Toggle bottom terminal" })
    map({ "n", "t" }, "<C-k>", floaterminal, { desc = "Toggle floating terminal" })
    map("n", "<leader>g", lazygit, { desc = "Open lazygit in floating terminal" })
end


--------------
-- Plugins! --
--------------
do
    ---@param name string
    ---@return string
    local function gh(name)
        return "https://github.com/" .. name
    end

    -- Update treesitter parsers when nvim-treesitter updates
    autocmd("PackChanged", {
        group = vim.api.nvim_create_augroup("ts-update-hook", { clear = true }),
        callback = function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if name == "nvim-treesitter" and kind == "update" then
                if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
                vim.cmd("TSUpdate")
            end
        end
    })

    -- All plugins!
    vim.pack.add({
        { src = gh "catppuccin/nvim",  name = "catppuccin" },                -- Cute theme :D
        gh "lewis6991/gitsigns.nvim",                                        -- Git info in editor, staging hunks
        gh "neovim/nvim-lspconfig",                                          -- LSP config defaults
        { src = gh "saghen/blink.cmp", version = vim.version.range("1.*") }, -- Autocomplete
        gh "nvim-lua/plenary.nvim",                                          -- Harpoon dep
        { src = gh "ThePrimeagen/harpoon", version = "harpoon2" },           -- Quick switching between bufs
        gh "j-hui/fidget.nvim",                                              -- Little eye candy for notifications :)
        gh "nvim-mini/mini.icons",                                           -- Icon pack
        gh "nvim-mini/mini.pick",                                            -- Fuzzy finder
        gh "nvim-lualine/lualine.nvim",                                      -- Statusline
        gh "stevearc/oil.nvim",                                              -- File explorer
        gh "nvim-treesitter/nvim-treesitter",                                -- Overengineered syntax highlighting
    })

    -- Catppuccin, the goated theme
    vim.cmd("colorscheme catppuccin-nvim")

    -- Oil, the better netrw
    do
        -- Setup mini.icons first
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

    -- Harpoon, the plugin of all time
    do
        local harpoon = require("harpoon")
        harpoon:setup()

        map("n", "<leader>a", function() harpoon:list():add() end,
            { desc = "Add current file to harpoon" })
        map("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Open harpoon menu" })

        for i = 1, 5, 1 do
            map("n", "<leader>" .. i, function() harpoon:list():select(i) end,
                { desc = "Select file " .. i .. " from Harpoon" })
        end
    end

    -- Fuzzy file/text/whatever picker
    do
        require("mini.pick").setup()

        map("n", "<leader>e", function() vim.cmd("Pick files") end)
        map("n", "<leader>f", function() vim.cmd("Pick grep_live") end)
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
        require("fidget").setup({
            notification = {
                override_vim_notify = true,
            }
        })

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
    end
end
