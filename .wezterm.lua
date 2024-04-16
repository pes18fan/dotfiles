local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_prog = { "E:/ArchWSL2/Arch.exe" }

config.line_height = 1.05
config.font = wezterm.font_with_fallback({
    { family = "Rec Mono Semicasual", scale = 0.95 },
})

config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.95
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 3000
config.cursor_thickness = "1pt"
config.tab_bar_at_bottom = true

-- dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.2,
    brightness = 0.2,
}

-- keymaps
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    -- create panes
    { key = "-",  mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
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
}

config.key_tables = {
    resize_pane = {
        { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
        { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
        { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
        { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
        { key = "Escape", action = "PopKeyTable" },
    }
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000

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

return config
