require("p18f.lazy")
require("p18f.remap")
require("p18f.set")
require("p18f.neovide")
require("p18f.filetype")

-- make background transparent
function Transparent()
    -- Make background transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
end

Transparent()
