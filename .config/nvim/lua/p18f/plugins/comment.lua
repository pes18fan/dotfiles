-- Make commenting stuff easier
return {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
        require('Comment').setup({
            padding = true,
            mappings = {
                basic = true
            }
        })
    end,
}
