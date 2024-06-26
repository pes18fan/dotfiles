-- Formatter
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        -- Keymap to format
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            python = { "black" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            crystal = { "crystal" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
    }
}
