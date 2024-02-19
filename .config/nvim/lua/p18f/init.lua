require("p18f.remap")
require("p18f.set")
require("p18f.packer")
require("p18f.neovide")

-- suppress annoying offset_encoding popup, whatever that is
local notify = vim.notify
    vim.notify = function(msg, ...)
        if msg:match("warning: multiple different client offset_encodings") then
            return
        end

        notify(msg, ...)
    end
