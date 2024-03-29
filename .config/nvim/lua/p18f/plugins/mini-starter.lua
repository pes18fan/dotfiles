return {
    "echasnovski/mini.starter",
    version = false,
    config = function()
        local header_art =
        [[
          /\ \ \___  ___/\   /(_)_ __ ___
         /  \/ / _ \/ _ \ \ / | | '_ ` _ \
        / /\  |  __| (_) \ V /| | | | | | |
        \_\ \/ \___|\___/ \_/ |_|_| |_| |_|
        ]]

        local starter = require("mini.starter")
        starter.setup({
            header = header_art,
            footer = ""
        })
    end,
}
