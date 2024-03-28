return {
    "j-hui/fidget.nvim",
    event = "VimEnter",
    config = function()
        require("fidget").setup({
            notification = {
                override_vim_notify = true,
                window = {
                    winblend = 0,
                    border = "none",
                },
            }
        })
    end
}
