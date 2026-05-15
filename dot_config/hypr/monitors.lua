hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1200@144.001",
    position = "auto",
    scale    = 1.0,
})

-- Fallback for anything else plugged in.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
