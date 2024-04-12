require("p18f.lazy")
require("p18f.remap")
require("p18f.set")
require("p18f.neovide")
require("p18f.filetype")

-- suppress annoying offset_encoding popup, whatever that is
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

-- make background transparent
function Transparent()
    -- Make background transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
end

Transparent()
