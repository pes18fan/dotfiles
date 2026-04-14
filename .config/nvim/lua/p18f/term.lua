-- Bottom terminal
local state = {
    buf = -1,
    win = -1
}

local function toggle_terminal()
    if not vim.api.nvim_win_is_valid(state.win) then
        -- Create buffer if it doesn't exist
        if not vim.api.nvim_buf_is_valid(state.buf) then
            state.buf = vim.api.nvim_create_buf(false, true)
        end

        -- Open the split at the bottom (height 15)
        vim.cmd("botright sbuf " .. state.buf)
        state.win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_height(state.win, 15)
        
        -- Start terminal if not already running in buffer
        if vim.bo[state.buf].buftype ~= "terminal" then
            vim.fn.termopen(vim.o.shell)
        end
    else
        vim.api.nvim_win_hide(state.win)
    end
end

-- Map it to whatever you used in nvterm (e.g., <leader>h)
vim.keymap.set({ "n", "t" }, "<C-j>", toggle_terminal, { desc = "Toggle Bottom Terminal" })

-- Floating terminal
local float_state = { 
    buf = -1, 
    win = -1 
}

local function toggle_float_terminal()
  -- If window is valid, hide it
  if vim.api.nvim_win_is_valid(float_state.win) then
    vim.api.nvim_win_hide(float_state.win)
    return
  end

  -- Create buffer if it doesn't exist
  if not vim.api.nvim_buf_is_valid(float_state.buf) then
    float_state.buf = vim.api.nvim_create_buf(false, true)
  end

  -- Define the size of the floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  -- Calculate the starting position (centered)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Window options
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded", -- You can use "single", "double", or "shadow"
  }

  -- Open the window
  float_state.win = vim.api.nvim_open_win(float_state.buf, true, opts)

  -- Start terminal if not already running
  if vim.bo[float_state.buf].buftype ~= "terminal" then
    vim.fn.termopen(vim.o.shell)
  end
end

vim.keymap.set({ "n", "t" }, "<C-k>", toggle_float_terminal, { desc = "Toggle Floating Terminal" })

-- Automatically enter insert mode when terminal is opened
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    pattern = "term://*",
    callback = function()
        vim.cmd("startinsert")
    end,
})

-- Automatically close terminal when shell process exits
vim.api.nvim_create_autocmd("TermClose", {
    pattern = "term://*",
    callback = function()
        -- Only close if it exited successfully (0)
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, { force = true })
        end
    end,
})
