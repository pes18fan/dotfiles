-- Configuration for treesitter, basically a parser that provides better
-- syntax highlighting and code navigation
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    init = function()
        -- set up ensure_installed parsers
        local want = { "c", "cpp", "lua", "javascript", "typescript", "astro" }
        local have = require("nvim-treesitter.config").get_installed()
        local missing = vim.iter(want)
            :filter(function(p) return not vim.tbl_contains(have, p) end)
            :totable()
        if #missing > 0 then
            require("nvim-treesitter").install(missing)
        end

        -- enable highlighting and indentation
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                -- enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)

                -- enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        })
    end
}
