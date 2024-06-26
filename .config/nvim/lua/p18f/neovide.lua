-- Config for the neovide GUI
if vim.g.neovide then
    vim.cmd(":cd") -- Meant for WSL, go into the proper home dir

    vim.o.guifont = "RecMonoCasual Nerd Font:h14"
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_transparency = 0.85
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_hide_mouse_when_typing = true

    vim.o.linespace = 4

    vim.g.neovide_remember_window_size = true

    vim.g.neovide_cursor_vfx_mode = "railgun"
end
