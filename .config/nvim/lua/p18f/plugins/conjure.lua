return {
    "Olical/conjure",
    ft = { "scheme" },
    config = function(_, _)
        require("conjure.main").main()
        require("conjure.mapping")["on-filetype"]()

        vim.keymap.set("n", "<leader>el", "<cmd>ConjureEval<CR>", { desc = "Evaluate current line with Conjure" })
        vim.keymap.set("n", "<leader>ee", "<cmd>ConjureEvalBuf<CR>", { desc = "Evaluate current buffer with Conjure" })
        vim.keymap.set("v", "<leader>ee", ":ConjureEval<CR>", { desc = "Evaluate selected content with Conjure" })
    end,
    init = function()
        vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
    end,
}
