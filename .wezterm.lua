-- Note: This is only for Windows.
local wezterm = require("wezterm")
local act = wezterm.action

local date = wezterm.strftime("%b %d, %Y")
local time = wezterm.strftime("%I:%M %p")

wezterm.on("update-right-status", function(window, _)
    -- Date and time
    window:set_right_status(wezterm.format({
        { Text = wezterm.nerdfonts.md_calendar .. " " .. date },
        { Text = " | " },
        { Text = wezterm.nerdfonts.md_clock .. " " .. time }
    }))
end)

return {
    default_prog = { "E:/ArchWSL2/Arch.exe" },
    line_height = 1.05,
    font = wezterm.font_with_fallback({
        { family = "Rec Mono Semicasual",     scale = 1 },
        { family = "JetBrainsMono Nerd Font", scale = 1 },
        { family = "Consolas",                scale = 1 }
    }),
    color_scheme = "Catppuccin Mocha",
    window_background_opacity = 0.95,
    window_close_confirmation = "NeverPrompt",
    scrollback_lines = 3000,
    cursor_thickness = "1pt",
    tab_bar_at_bottom = true,

    -- dim inactive panes
    inactive_pane_hsb = {
        saturation = 0.2,
        brightness = 0.2,
    },

    -- keymaps
    leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        -- create panes
        { key = "v",  mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
        { key = "\\", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },

        -- pane movement
        { key = "h",  mods = "LEADER", action = act.ActivatePaneDirection("Left") },
        { key = "j",  mods = "LEADER", action = act.ActivatePaneDirection("Down") },
        { key = "k",  mods = "LEADER", action = act.ActivatePaneDirection("Up") },
        { key = "l",  mods = "LEADER", action = act.ActivatePaneDirection("Right") },

        -- resize panes
        { key = "r",  mods = "LEADER", action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

        -- tabs
        { key = "n",  mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
        { key = "[",  mods = "LEADER", action = act.ActivateTabRelative(-1) },
        { key = "]",  mods = "LEADER", action = act.ActivateTabRelative(1) },
        { key = "t",  mods = "LEADER", action = act.ShowTabNavigator }
    },

    key_tables = {
        resize_pane = {
            { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
            { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
            { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
            { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
            { key = "Escape", action = "PopKeyTable" },
        }
    },

    use_fancy_tab_bar = false,
    status_update_interval = 1000,
}
