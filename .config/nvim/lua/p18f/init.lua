require("p18f.remap")
require("p18f.set")
require("p18f.lazy")
require("p18f.neovide")

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

-- suppress annoying offset_encoding popup, whatever that is
local notify = vim.notify
    vim.notify = function(msg, ...)
        if msg:match("warning: multiple different client offset_encodings") then
            return
        end

        notify(msg, ...)
    end
