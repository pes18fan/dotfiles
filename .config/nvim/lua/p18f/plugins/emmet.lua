return {
    "mattn/emmet-vim",
    event = "BufReadPre",
    config = function()
        vim.g.user_emmet_settings = {
            html = {
                snippets = {
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
