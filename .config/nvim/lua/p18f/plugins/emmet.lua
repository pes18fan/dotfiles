-- Plugin for Emmet, a tool for quick HTML writing
return {
    "mattn/emmet-vim",
    ft = { "html", "ejs", "jsx", "tsx", "ecr" },
    config = function()
        vim.g.user_emmet_settings = {
            html = {
                snippets = {
                    -- Snippet for HTML boilerplate
                    ["!"] = [[
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
</head>

<body>
</body>

</html>
]]
                }
            }
        }
    end,
}
