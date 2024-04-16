-- Add good enough syntax highlighting for mdx
vim.filetype.add({
    extension = {
        mdx = "mdx"
    }
})
vim.treesitter.language.register("markdown", "mdx")

-- specific formatting for crystal
vim.cmd "autocmd FileType crystal setlocal shiftwidth=2 sts=2 tabstop=2 expandtab"
