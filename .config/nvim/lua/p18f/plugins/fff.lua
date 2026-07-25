return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        -- downloads a prebuilt binary or falls back to cargo build
        require("fff.download").download_or_build_binary()
    end,
    -- for nixos:
    -- build = "nix run .#release",
    opts = {
        debug = {
            enabled = true,
            show_scores = true,
        },
    },
    lazy = false, -- the plugin lazy-initialises itself
    keys = {
        { "<leader>pf", function() require('fff').find_files() end, desc = 'Find files' },
        { "<leader>ps", function() require('fff').live_grep() end,  desc = 'Live grep' },
    },
}
