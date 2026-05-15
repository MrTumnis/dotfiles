-- ~/.config/hypr/binds.lua

local h        = require("helpers")
local mod, sft = h.mod, h.sft
local ctl, alt = h.ctl, h.alt
local chord    = h.chord

local terminal    = "kitty"
local fileManager = "pcmanfm"
local browser     = "brave"
local altBrowser  = "helium"
local menu        = "fuzzel"
local locker      = "swaylock"
local yazi        = "kitty -e yazi"
local clipseTui   = "kitty -e clipse tui"
local noctaliaBar = "qs -c noctalia-shell ipc call bar toggle"

----------------------------------------
-- Launchers / apps
----------------------------------------
hl.bind(chord(mod, "return"), hl.dsp.exec_cmd(terminal))
hl.bind(chord(mod, "T"),      hl.dsp.exec_cmd(fileManager))
hl.bind(chord(mod, "Y"),      hl.dsp.exec_cmd(yazi))
hl.bind(chord(mod, "C"),      hl.dsp.exec_cmd(clipseTui))
hl.bind(chord(mod, "D"),      hl.dsp.exec_cmd(menu))
hl.bind(chord(mod, "B"),      hl.dsp.exec_cmd(browser))
hl.bind(chord(alt, "B"),      hl.dsp.exec_cmd(altBrowser))
hl.bind(chord(mod, alt, "L"), hl.dsp.exec_cmd(locker))
hl.bind(chord(alt, "T"),      hl.dsp.exec_cmd(noctaliaBar))
hl.bind(chord(mod, alt, "S"), hl.dsp.exec_cmd("sh -c 'pkill orca || exec orca'"),
        { locked = true })

----------------------------------------
-- Media / brightness keys
----------------------------------------
hl.bind("XF86AudioRaiseVolume",
        hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"),
        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),
        { locked = true, repeating = true })
hl.bind("XF86AudioMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        { locked = true })
hl.bind("XF86AudioMicMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        { locked = true })

hl.bind("XF86MonBrightnessUp",
        hl.dsp.exec_cmd("brightnessctl --class=backlight set +10%"),
        { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",
        hl.dsp.exec_cmd("brightnessctl --class=backlight set 10%-"),
        { locked = true, repeating = true })

----------------------------------------
-- Window management
----------------------------------------
hl.bind(chord(alt, "Q"),      hl.dsp.window.close())
hl.bind(chord(mod, "V"),      hl.dsp.window.float({ action = "toggle" }))
hl.bind(chord(mod, sft, "V"), hl.dsp.window.cycle_next())

hl.bind(chord(mod, "F"),      hl.dsp.layout("colresize 1.0"))   -- maximize column
hl.bind(chord(mod, sft, "F"), hl.dsp.window.fullscreen())
hl.bind(chord(mod, ctl, "F"), hl.dsp.layout("fit visible"))     -- expand-to-available

hl.bind(chord(mod, "W"),      hl.dsp.group.toggle())            -- tabbed column

----------------------------------------
-- Focus: columns (left/right) and windows in a column (up/down)
----------------------------------------
hl.bind(chord(mod, "left"),  hl.dsp.focus({ direction = "left"  }))
hl.bind(chord(mod, "right"), hl.dsp.focus({ direction = "right" }))
hl.bind(chord(mod, "up"),    hl.dsp.focus({ direction = "up"    }))
hl.bind(chord(mod, "down"),  hl.dsp.focus({ direction = "down"  }))

hl.bind(chord(mod, "h"),     hl.dsp.focus({ direction = "left"  }))
hl.bind(chord(mod, "l"),     hl.dsp.focus({ direction = "right" }))
hl.bind(chord(mod, "k"),     hl.dsp.focus({ direction = "up"    }))
hl.bind(chord(mod, "j"),     hl.dsp.focus({ direction = "down"  }))

----------------------------------------
-- Move column / window (Mod+Ctrl+...)
-- L/R = swap column position, U/D = rearrange window within column
----------------------------------------
hl.bind(chord(mod, ctl, "left"),  hl.dsp.layout("swapcol l"))
hl.bind(chord(mod, ctl, "right"), hl.dsp.layout("swapcol r"))
hl.bind(chord(mod, ctl, "up"),    hl.dsp.layout("movewindowto u"))
hl.bind(chord(mod, ctl, "down"),  hl.dsp.layout("movewindowto d"))

hl.bind(chord(mod, ctl, "h"),     hl.dsp.layout("swapcol l"))
hl.bind(chord(mod, ctl, "l"),     hl.dsp.layout("swapcol r"))
hl.bind(chord(mod, ctl, "k"),     hl.dsp.layout("movewindowto u"))
hl.bind(chord(mod, ctl, "j"),     hl.dsp.layout("movewindowto d"))

hl.bind(chord(mod, "home"), hl.dsp.layout("fit tobeg"))
hl.bind(chord(mod, "end"),  hl.dsp.layout("fit toend"))

----------------------------------------
-- Monitor focus (Mod+Shift+...)
----------------------------------------
hl.bind(chord(mod, sft, "left"),  hl.dsp.focus({ monitor = "l" }))
hl.bind(chord(mod, sft, "right"), hl.dsp.focus({ monitor = "r" }))
hl.bind(chord(mod, sft, "up"),    hl.dsp.focus({ monitor = "u" }))
hl.bind(chord(mod, sft, "down"),  hl.dsp.focus({ monitor = "d" }))

hl.bind(chord(mod, sft, "h"),     hl.dsp.focus({ monitor = "l" }))
hl.bind(chord(mod, sft, "l"),     hl.dsp.focus({ monitor = "r" }))
hl.bind(chord(mod, sft, "k"),     hl.dsp.focus({ monitor = "u" }))
hl.bind(chord(mod, sft, "j"),     hl.dsp.focus({ monitor = "d" }))

----------------------------------------
-- Move column to monitor (Mod+Shift+Ctrl+...)
----------------------------------------
hl.bind(chord(mod, sft, ctl, "left"),  hl.dsp.window.move({ monitor = "l" }))
hl.bind(chord(mod, sft, ctl, "right"), hl.dsp.window.move({ monitor = "r" }))
hl.bind(chord(mod, sft, ctl, "up"),    hl.dsp.window.move({ monitor = "u" }))
hl.bind(chord(mod, sft, ctl, "down"),  hl.dsp.window.move({ monitor = "d" }))

hl.bind(chord(mod, sft, ctl, "h"),     hl.dsp.window.move({ monitor = "l" }))
hl.bind(chord(mod, sft, ctl, "l"),     hl.dsp.window.move({ monitor = "r" }))
hl.bind(chord(mod, sft, ctl, "k"),     hl.dsp.window.move({ monitor = "u" }))
hl.bind(chord(mod, sft, ctl, "j"),     hl.dsp.window.move({ monitor = "d" }))

----------------------------------------
-- Workspaces — relative
----------------------------------------
hl.bind(chord(mod, "Page_Down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(chord(mod, "Page_Up"),   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(chord(mod, "U"),         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(chord(mod, "I"),         hl.dsp.focus({ workspace = "e-1" }))

hl.bind(chord(mod, ctl, "Page_Down"), hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(chord(mod, ctl, "Page_Up"),   hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(chord(mod, ctl, "U"),         hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(chord(mod, ctl, "I"),         hl.dsp.window.move({ workspace = "e-1" }))

----------------------------------------
-- Workspaces — numbered (Mod+1..9 / Mod+Shift+1..9)
----------------------------------------
for i = 1, 9 do
    local key = tostring(i)
    hl.bind(chord(mod, key),      hl.dsp.focus({ workspace = i }))
    hl.bind(chord(mod, sft, key), hl.dsp.window.move({ workspace = i }))
end

----------------------------------------
-- Mouse-wheel workspace / column navigation
----------------------------------------
hl.bind(chord(mod, "mouse_down"),      hl.dsp.focus({ workspace = "e+1" }))
hl.bind(chord(mod, "mouse_up"),        hl.dsp.focus({ workspace = "e-1" }))
hl.bind(chord(mod, ctl, "mouse_down"), hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(chord(mod, ctl, "mouse_up"),   hl.dsp.window.move({ workspace = "e-1" }))

hl.bind(chord(mod, sft, "mouse_down"), hl.dsp.focus({ direction = "right" }))
hl.bind(chord(mod, sft, "mouse_up"),   hl.dsp.focus({ direction = "left"  }))

-- Click-drag windows
hl.bind(chord(mod, "mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(chord(mod, "mouse:273"), hl.dsp.window.resize(), { mouse = true })

----------------------------------------
-- Scrolling-layout: consume / expel / promote
----------------------------------------
hl.bind(chord(mod, "bracketleft"),  hl.dsp.layout("consume_or_expel l"))
hl.bind(chord(mod, "bracketright"), hl.dsp.layout("consume_or_expel r"))
hl.bind(chord(mod, "comma"),        hl.dsp.layout("consume r"))
hl.bind(chord(mod, "period"),       hl.dsp.layout("expel r"))

----------------------------------------
-- Column / window sizing
----------------------------------------
hl.bind(chord(mod, "R"),      hl.dsp.layout("colresize +conf"))
hl.bind(chord(mod, sft, "R"), hl.dsp.layout("colresize -conf"))
hl.bind(chord(mod, ctl, "R"), hl.dsp.layout("colresize 0.5"))

hl.bind(chord(mod, "minus"),      hl.dsp.layout("colresize -0.1"))
hl.bind(chord(mod, "equal"),      hl.dsp.layout("colresize +0.1"))
hl.bind(chord(mod, sft, "minus"), hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(chord(mod, sft, "equal"), hl.dsp.window.resize({ x = 0, y = 100,  relative = true }))

----------------------------------------
-- Centering
----------------------------------------
hl.bind(chord(alt, "C"),      hl.dsp.layout("center"))
hl.bind(chord(mod, ctl, "C"), hl.dsp.layout("fit visible"))

----------------------------------------
-- Overview
----------------------------------------
-- hl.bind(chord(mod, "O"), hl.dsp.overview.toggle(), { repeating = false })

----------------------------------------
-- Screenshots (grim + slurp + jq)
----------------------------------------
local screenshotDir = "~/Pictures/Screenshots"
local snapRegion = string.format(
    "sh -c 'mkdir -p %s && grim -g \"$(slurp)\" %s/Screenshot\\ from\\ $(date +%%F\\ %%H-%%M-%%S).png'",
    screenshotDir, screenshotDir)
local snapScreen = string.format(
    "sh -c 'mkdir -p %s && grim %s/Screenshot\\ from\\ $(date +%%F\\ %%H-%%M-%%S).png'",
    screenshotDir, screenshotDir)
local snapWindow = string.format(
    "sh -c 'mkdir -p %s && grim -g \"$(hyprctl activewindow -j | jq -r \".at | \\\"\\\\(.[0]),\\\\(.[1])\\\"\"),$(hyprctl activewindow -j | jq -r \".size | \\\"\\\\(.[0])x\\\\(.[1])\\\"\")\" %s/Screenshot\\ from\\ $(date +%%F\\ %%H-%%M-%%S).png'",
    screenshotDir, screenshotDir)

hl.bind("Print",             hl.dsp.exec_cmd(snapRegion))
hl.bind("F8",                hl.dsp.exec_cmd(snapRegion))
hl.bind(chord(ctl, "Print"), hl.dsp.exec_cmd(snapScreen))
hl.bind(chord(ctl, "F8"),    hl.dsp.exec_cmd(snapScreen))
hl.bind(chord(alt, "Print"), hl.dsp.exec_cmd(snapWindow))
hl.bind(chord(alt, "F8"),    hl.dsp.exec_cmd(snapWindow))

----------------------------------------
-- Session control
----------------------------------------
hl.bind(chord(mod, sft, "Q"),      hl.dsp.exec_cmd("uwsm stop || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(chord(ctl, alt, "Delete"), hl.dsp.exec_cmd("uwsm stop || hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind(chord(mod, sft, "P"), function()
    hl.timer(function()
        hl.dispatch(hl.dsp.dpms({ action = "disable" }))
    end, { timeout = 200, type = "oneshot" })
end)
