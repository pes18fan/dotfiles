-- Add good enough syntax highlighting for mdx
vim.filetype.add({
    extension = {
        mdx = "mdx"
    }
})
vim.treesitter.language.register("markdown", "mdx")
