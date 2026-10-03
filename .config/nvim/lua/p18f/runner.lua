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

vim.keymap.set({ "n", "t" }, "<C-j>", boterminal, { desc = "Toggle bottom terminal" })
vim.keymap.set({ "n", "t" }, "<C-k>", floaterminal, { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>g", lazygit, { desc = "Open lazygit in floating terminal" })
