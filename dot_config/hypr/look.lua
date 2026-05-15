-- ~/.config/hypr/look.lua
-- general, decoration, animations, misc, cursor, ecosystem.

hl.config({
    general = {
        gaps_in       = 1,
        gaps_out      = 1,
        border_size   = 0,
        layout        = "scrolling",
        resize_on_border = false,
        allow_tearing    = false,
        col = {
            active_border   = "rgba(89b4fa33)",
            inactive_border = "rgba(505050ff)",
        },
    },

    decoration = {
        rounding       = 2,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = false,
            range        = 30,
            render_power = 3,
            color        = "rgba(00000077)",
            offset       = "0 5",
        },
        blur = { enabled = false, size = 3, passes = 1 },
    },

    animations = { enabled = true},

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        focus_on_activate       = true,
    },

    cursor = {
        hide_on_key_press = true,
        inactive_timeout  = 1,
        no_warps          = true,
    },

    ecosystem = { no_update_news = true },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fade",          enabled = true, speed = 1.03, bezier = "quick" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = false, speed = 7,    bezier = "quick" })
